import ./bindings/vips
import ./bindings/glib/glib
import ./api/types
import ./api/image

proc watermark*(img: Image, watermark: Image,
    x, y: int, opacity: range[0.0 .. 1.0]): Image =
  if img == nil: raise newException(ValueError, "Input image is nil")
  if watermark == nil: raise newException(ValueError, "Watermark image is nil")

  let op = opacity
  if op == 0:
    var outCopy: ptr VipsImage
    checkVips(vips_copy(img.v, addr outCopy), "copy image in watermark")
    return Image(v: outCopy)

  let baseWidth = img.width
  let baseHeight = img.height
  let baseFmt = img.format
  let baseInterp = img.space

  var wmCurrent = watermark.v
  var wmCS: ptr VipsImage
  if vips_colourspace(watermark.v, addr wmCS, baseInterp) == 0 and wmCS != nil:
    wmCurrent = wmCS

  var wmWithAlpha = wmCurrent
  if vips_image_hasalpha(wmCurrent) == 0:
    var tmp: ptr VipsImage
    checkVips(vips_addalpha(wmCurrent, addr tmp), "add alpha to watermark")
    wmWithAlpha = tmp

  if vips_image_get_format(wmWithAlpha) != baseFmt:
    var tmpCast: ptr VipsImage
    checkVips(vips_cast(wmWithAlpha, addr tmpCast, baseFmt), "cast watermark format")
    wmWithAlpha = tmpCast

  let wmBands = vips_image_get_bands(wmWithAlpha)
  if wmBands < 2:
    raise newException(ValueError, "Watermark must have at least 2 bands after ensuring alpha")

  if op != 1.0:
    var r, g, b, a: ptr VipsImage
    if wmBands >= 3:
      checkVips(vips_extract_band(wmWithAlpha, addr r, 0), "extract watermark band 0")
      checkVips(vips_extract_band(wmWithAlpha, addr g, 1), "extract watermark band 1")
      checkVips(vips_extract_band(wmWithAlpha, addr b, 2), "extract watermark band 2")
    else:
      checkVips(vips_extract_band(wmWithAlpha, addr r, 0), "extract watermark gray band")
      g = r; b = r

    checkVips(vips_extract_band(wmWithAlpha, addr a, (wmBands - 1).cint), "extract watermark alpha")

    var aScaled: ptr VipsImage
    checkVips(vips_linear1(a, addr aScaled, op.cdouble, 0.0), "scale watermark alpha")

    var parts: array[4, ptr VipsImage]
    parts[0] = r; parts[1] = g; parts[2] = b; parts[3] = aScaled
    var wmAdjusted: ptr VipsImage
    checkVips(vips_bandjoin(addr parts[0], addr wmAdjusted, 4.cint), "rebuild watermark with scaled alpha")
    wmWithAlpha = wmAdjusted

  let overlayBands = vips_image_get_bands(wmWithAlpha)
  var zeros = newSeq[cdouble](overlayBands)
  var overlayCanvas = vips_image_new_from_image(img.v, unsafeAddr zeros[0], overlayBands.cint)
  if overlayCanvas == nil:
    raise newException(ValueError, "Failed to create overlay canvas in watermark")

  var overlayPlaced: ptr VipsImage
  checkVips(vips_insert(overlayCanvas, wmWithAlpha, addr overlayPlaced, x.cint, y.cint),
    "place watermark on canvas")

  var outImg: ptr VipsImage
  checkVips(vips_composite2(img.v, overlayPlaced, addr outImg, VIPS_BLEND_MODE_OVER),
    "composite watermark")
  Image(v: outImg)

proc watermark*(img: Image, watermark: Image,
    verticalAlignment: VerticalAlignment = VAlignCenter,
    horizontalAlignment: HorizontalAlignment = HAlignCenter,
    opacity: float = 0.5, margin: int = 20): Image =
  if img == nil: raise newException(VipsError, "Input image is nil")
  if watermark == nil: raise newException(VipsError, "Watermark image is nil")
  let bgWidth = img.width
  let bgHeight = img.height
  let wmWidth = watermark.width
  let wmHeight = watermark.height

  if horizontalAlignment == HAlignLeft and wmWidth + margin > bgWidth:
    raise newException(VipsError, "Watermark width exceeds background width with margin")
  if horizontalAlignment == HAlignRight and wmWidth + margin > bgWidth:
    raise newException(VipsError, "Watermark width exceeds background width with margin")
  if verticalAlignment == VAlignTop and wmHeight + margin > bgHeight:
    raise newException(VipsError, "Watermark height exceeds background height with margin")
  if verticalAlignment == VAlignBottom and wmHeight + margin > bgHeight:
    raise newException(VipsError, "Watermark height exceeds background height with margin")

  var x, y: int
  case horizontalAlignment
  of HAlignLeft: x = margin
  of HAlignCenter: x = (bgWidth - wmWidth) div 2
  of HAlignRight: x = bgWidth - wmWidth - margin

  case verticalAlignment
  of VAlignTop: y = margin
  of VAlignCenter: y = (bgHeight - wmHeight) div 2
  of VAlignBottom: y = bgHeight - wmHeight - margin

  watermark(img, watermark, x, y, opacity)
