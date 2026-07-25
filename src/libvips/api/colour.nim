import ../bindings/vips
import ./types, ./image

proc toColourspace*(img: Image, space: VipsInterpretation): Image =
  var outPtr: ptr VipsImage
  let rc = vips_colourspace(img.v, addr outPtr, space)
  checkVips(rc, "convert colourspace")
  Image(v: outPtr)

proc toSRGB*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_sRGB)

proc toGrayscale*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_B_W)

proc toCMYK*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_CMYK)

proc toLAB*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_LAB)

proc toHSV*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_HSV)

proc toXYZ*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_XYZ)

proc toLCh*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_LCH)

proc toscRGB*(img: Image): Image =
  img.toColourspace(VIPS_INTERPRETATION_scRGB)

proc iccTransform*(img: Image, outputProfile: string): Image =
  var outPtr: ptr VipsImage
  let rc = vips_icc_transform(img.v, addr outPtr, outputProfile.cstring)
  checkVips(rc, "ICC transform to: " & outputProfile)
  Image(v: outPtr)

proc iccImport*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_icc_import(img.v, addr outPtr)
  checkVips(rc, "ICC import")
  Image(v: outPtr)

proc iccExport*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_icc_export(img.v, addr outPtr)
  checkVips(rc, "ICC export")
  Image(v: outPtr)
