# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

type
  ## A picture element. Cast this to whatever the associated VipsBandFormat says to get the value.
  VipsPel* = uint8

  ## Callback function types
  VipsCallbackFn* = proc(a: pointer, b: pointer): cint {.cdecl.}
  VipsSListMap2Fn* = proc(item: pointer, a: pointer, b: pointer): pointer {.cdecl.}
  VipsSListMap4Fn* = proc(item: pointer, a: pointer, b: pointer, c: pointer, d: pointer): pointer {.cdecl.}
  VipsSListFold2Fn* = proc(item: pointer, a: pointer, b: pointer, c: pointer): pointer {.cdecl.}

  ## Enum for VipsPrecision
  VipsPrecision* {.size: sizeof(cint).} = enum
    VIPS_PRECISION_INTEGER,
    VIPS_PRECISION_FLOAT,
    VIPS_PRECISION_APPROXIMATE,
    VIPS_PRECISION_LAST

# Opaque pointer types for VIPS structs
type
  VipsImage* = object
  PVipsImage* = ptr VipsImage
  VipsRegion* = object
  PVipsRegion* = ptr VipsRegion
  VipsBuf* = object
  PVipsBuf* = ptr VipsBuf
  VipsSource* = object
  PVipsSource* = ptr VipsSource
  VipsTarget* = object
  PVipsTarget* = ptr VipsTarget
  VipsInterpolate* = object
  PVipsInterpolate* = ptr VipsInterpolate
  VipsOperation* = object
  PVipsOperation* = ptr VipsOperation

# External procs
proc vips_path_filename7*(path: cstring): cstring {.cdecl, importc.}
proc vips_path_mode7*(path: cstring): cstring {.cdecl, importc.}
