import ../bindings/vips

export VipsBandFormat, VipsInterpretation, VipsBlendMode, VipsDirection,
  VipsAngle, VipsInteresting, VipsExtend, VipsKernel, VipsCompassDirection,
  VipsIntent, VipsForeignTiffCompression

type
  VipsError* = object of CatchableError
  VerticalAlignment* = enum VAlignTop, VAlignCenter, VAlignBottom
  HorizontalAlignment* = enum HAlignLeft, HAlignCenter, HAlignRight

proc vipsErrorContext*(op: string): string =
  let buf = $vips_error_buffer()
  vips_error_clear()
  if buf.len > 0: op & ": " & buf else: "Failed to " & op

proc checkVips*(rc: cint, op: string) =
  if rc != 0:
    raise newException(VipsError, vipsErrorContext(op))
