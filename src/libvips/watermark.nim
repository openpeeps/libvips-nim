# High-level API for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./bindings/vips
import ./bindings/glib/glib

import ./api

proc watermark*(img: ptr VipsImage, watermark: ptr VipsImage,
    x, y: int, opacity: range[0.0..1.0]): ptr VipsImage =
  ## Apply a watermark to the image at specified (x, y) coordinates with given opacity
  if img == nil:
    raise newException(ValueError, "Input image is nil")
  if watermark == nil:
    raise newException(ValueError, "Watermark image is nil")

  # clamp opacity
  let op = opacity
  if op == 0:
    # No-op: return a copy of the base image
    var outCopy: ptr VipsImage = nil
    if vips_copy(img, addr outCopy) != 0:
      raise newException(ValueError, "vips_copy failed")
    return outCopy

  # Gather base image info
  let baseWidth = vips_image_get_width(img)
  let baseHeight = vips_image_get_height(img)
  let baseFmt = vips_image_get_format(img)
  let baseInterp = vips_image_get_interpretation(img)

  # Convert watermark to the same colourspace/profile as base
  var wmCS: ptr VipsImage = nil
  var wmCurrent: ptr VipsImage = watermark
  when declared(vips_colourspace):
    if vips_colourspace(watermark, addr wmCS, baseInterp) == 0 and wmCS != nil:
      wmCurrent = wmCS
    else:
      # If colourspace conversion failed, keep original
      wmCurrent = watermark
  else:
    wmCurrent = watermark

  # ensure watermark has alpha (if not, add it)
  var wmWithAlpha: ptr VipsImage = wmCurrent
  if vips_image_hasalpha(wmCurrent) == 0:
    var tmp: ptr VipsImage = nil
    if vips_addalpha(wmCurrent, addr tmp) != 0 or tmp == nil:
      raise newException(ValueError, "vips_addalpha failed on watermark")
    wmWithAlpha = tmp

  # match pixel format (cast watermark to base format if different)
  if vips_image_get_format(wmWithAlpha) != baseFmt:
    var tmpCast: ptr VipsImage = nil
    if vips_cast(wmWithAlpha, addr tmpCast, baseFmt) != 0 or tmpCast == nil:
      raise newException(ValueError, "vips_cast failed on watermark to match base format")
    wmWithAlpha = tmpCast

  # apply opacity by scaling the alpha band.
  # extract alpha band (last band), multiply by opacity, and rejoin
  let wmBands = vips_image_get_bands(wmWithAlpha)
  if wmBands < 2:
    raise newException(ValueError, "Watermark must have at least 2 bands after ensuring alpha")

  if op != 1.0:
    var r: ptr VipsImage = nil
    var g: ptr VipsImage = nil
    var b: ptr VipsImage = nil
    var a: ptr VipsImage = nil
    # extract RGB (or color) bands individually (0..wmBands-2)
    if wmBands >= 3:
      if vips_extract_band(wmWithAlpha, addr r, 0) != 0 or r == nil:
        raise newException(ValueError, "vips_extract_band failed for band 0")
      if vips_extract_band(wmWithAlpha, addr g, 1) != 0 or g == nil:
        raise newException(ValueError, "vips_extract_band failed for band 1")
      if vips_extract_band(wmWithAlpha, addr b, 2) != 0 or b == nil:
        raise newException(ValueError, "vips_extract_band failed for band 2")
    else:
      # Grayscale + alpha case: duplicate gray into 3 bands for consistency
      if vips_extract_band(wmWithAlpha, addr r, 0) != 0 or r == nil:
        raise newException(ValueError, "vips_extract_band failed for gray band")
      g = r
      b = r

    # extract alpha
    if vips_extract_band(wmWithAlpha, addr a, (wmBands - 1).cint) != 0 or a == nil:
      raise newException(ValueError, "vips_extract_band failed for alpha band")

    # Scale alpha by opacity
    var aScaled: ptr VipsImage = nil
    if vips_linear1(a, addr aScaled, op.cdouble, 0.0) != 0 or aScaled == nil:
      raise newException(ValueError, "vips_linear1 failed when scaling alpha")

    # reassemble RGBA (or color+alpha)
    var parts: array[4, ptr VipsImage]
    parts[0] = r
    parts[1] = g
    parts[2] = b
    parts[3] = aScaled

    var wmAdjusted: ptr VipsImage = nil
    if vips_bandjoin(addr parts[0], addr wmAdjusted, 4.cint) != 0 or wmAdjusted == nil:
      raise newException(ValueError, "vips_bandjoin failed to rebuild watermark with scaled alpha")
    wmWithAlpha = wmAdjusted

  # Build a transparent overlay canvas same size as base and with the
  # same number of bands as the adjusted watermark, then insert the watermark at (x, y)
  let overlayBands = vips_image_get_bands(wmWithAlpha) # should be color+alpha
  # Make a zero-filled const vector for vips_image_new_from_image
  var zeros = newSeq[cdouble](overlayBands)
  for i in 0 ..< overlayBands:
    zeros[i] = 0.0

  var overlayCanvas: ptr VipsImage = nil
  overlayCanvas = vips_image_new_from_image(img, unsafeAddr zeros[0], overlayBands.cint)
  if overlayCanvas == nil:
    raise newException(ValueError, "vips_image_new_from_image failed to create overlay canvas")

  var overlayPlaced: ptr VipsImage = nil
  if vips_insert(overlayCanvas, wmWithAlpha, addr overlayPlaced, x.cint, y.cint) != 0 or overlayPlaced == nil:
    raise newException(ValueError, "vips_insert failed when placing watermark on canvas")

  # Composite overlay onto base with OVER
  var outImg: ptr VipsImage = nil
  if vips_composite2(img, overlayPlaced, addr outImg, VIPS_BLEND_MODE_OVER) != 0 or outImg == nil:
    raise newException(ValueError, "vips_composite2(OVER) failed")
  return outImg

proc watermark*(img: ptr VipsImage, watermark: ptr VipsImage,
                verticalAlignment: VerticalAlignment = VAlignCenter,
                horizontalAlignment: HorizontalAlignment = HAlignCenter,
                opacity: float = 0.5, margin: int = 20): ptr VipsImage =
  ## Apply a watermark to the image with specified alignment, opacity, and margin.
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
  # Horizontal alignment (x axis)
  case horizontalAlignment
  of HAlignLeft:
    x = margin
  of HAlignCenter:
    x = (bgWidth - wmWidth) div 2
  of HAlignRight:
    x = bgWidth - wmWidth - margin

  # Vertical alignment (y axis)
  case verticalAlignment
  of VAlignTop:
    y = margin
  of VAlignCenter:
    y = (bgHeight - wmHeight) div 2
  of VAlignBottom:
    y = bgHeight - wmHeight - margin
  
  watermark(img, watermark, x, y, opacity)