import ../bindings/vips
import ../bindings/glib/glib
import ./types, ./image, ./colour

proc addAlpha*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_addalpha(img.v, addr outPtr)
  checkVips(rc, "add alpha")
  Image(v: outPtr)

proc flatten*(img: Image, background: openArray[cdouble] = @[0.0, 0.0, 0.0]): Image =
  var outPtr: ptr VipsImage
  var bg = @background
  let bgImg = vips_image_new_from_image(img.v, unsafeAddr bg[0], bg.len.cint)
  if bgImg == nil:
    raise newException(VipsError, "flatten: failed to create background image")
  let rc = vips_flatten(img.v, addr outPtr)
  g_object_unref(cast[pointer](bgImg))
  checkVips(rc, "flatten alpha")
  Image(v: outPtr)

proc composite*(img: Image, overlay: Image, mode: VipsBlendMode,
    x: int = 0, y: int = 0): Image =
  var overlayPlaced: ptr VipsImage
  var outPtr: ptr VipsImage

  let ob = overlay.bands
  let ib = img.bands
  var base = img
  var ov = overlay

  if ob != ib:
    if ob < ib:
      ov = ov.toColourspace(img.space)
    if vips_image_hasalpha(ov.v) != 0:
      base = base.addAlpha()

  let targetBands = max(base.bands, ov.bands)
  var zeros = newSeq[cdouble](targetBands)
  for i in 0 ..< targetBands: zeros[i] = 0.0

  var canvas = vips_image_new_from_image(base.v, unsafeAddr zeros[0], targetBands.cint)
  if canvas == nil:
    raise newException(VipsError, "composite: failed to create overlay canvas")

  let irc = vips_insert(canvas, ov.v, addr overlayPlaced, x.cint, y.cint)
  if irc != 0:
    g_object_unref(cast[pointer](canvas))
    raise newException(VipsError, vipsErrorContext("composite insert"))

  let rc = vips_composite2(base.v, overlayPlaced, addr outPtr, mode)
  g_object_unref(cast[pointer](canvas))
  g_object_unref(cast[pointer](overlayPlaced))
  checkVips(rc, "composite")
  Image(v: outPtr)

proc composite*(img: Image, overlays: openArray[Image],
    modes: openArray[VipsBlendMode]): Image =
  if overlays.len == 0: return img
  if overlays.len != modes.len:
    raise newException(ValueError, "composite: overlays and modes must have same length")
  result = img
  for i in 0 ..< overlays.len:
    result = result.composite(overlays[i], modes[i])

proc blendOver*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_OVER)

proc blendMultiply*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_MULTIPLY)

proc blendScreen*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_SCREEN)

proc blendOverlay*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_OVERLAY)

proc blendDarken*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_DARKEN)

proc blendLighten*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_LIGHTEN)

proc blendAdd*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_ADD)

proc blendDifference*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_DIFFERENCE)

proc blendExclusion*(img: Image, overlay: Image): Image =
  img.composite(overlay, VIPS_BLEND_MODE_EXCLUSION)

proc premultiply*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_premultiply(img.v, addr outPtr)
  checkVips(rc, "premultiply")
  Image(v: outPtr)

proc unpremultiply*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_unpremultiply(img.v, addr outPtr)
  checkVips(rc, "unpremultiply")
  Image(v: outPtr)

proc bandJoin*(img: Image, other: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_bandjoin2(img.v, other.v, addr outPtr)
  checkVips(rc, "band join")
  Image(v: outPtr)

proc bandJoin*(images: openArray[Image]): Image =
  if images.len == 0:
    raise newException(ValueError, "bandJoin: at least one image required")
  result = images[0]
  for i in 1 ..< images.len:
    result = result.bandJoin(images[i])

proc bandMean*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_bandmean(img.v, addr outPtr)
  checkVips(rc, "band mean")
  Image(v: outPtr)

proc ifThenElse*(condition, ifTrue, ifFalse: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_ifthenelse(condition.v, ifTrue.v, ifFalse.v, addr outPtr)
  checkVips(rc, "if then else")
  Image(v: outPtr)

proc recomb*(img: Image, matrix: array[3, array[3, float]]): Image =
  var flat: seq[cdouble]
  for row in matrix:
    for val in row:
      flat.add(val.cdouble)
  var matImg = vips_image_new_from_image(img.v, unsafeAddr flat[0], 9.cint)
  if matImg == nil:
    raise newException(VipsError, "recomb: failed to create matrix image")
  var outPtr: ptr VipsImage
  let rc = vips_recomb(img.v, addr outPtr, matImg)
  g_object_unref(cast[pointer](matImg))
  checkVips(rc, "recomb")
  Image(v: outPtr)
