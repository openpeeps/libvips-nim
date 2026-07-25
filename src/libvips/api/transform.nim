import ../bindings/vips
import ./types, ./image

proc resize*(img: Image, scale: float): Image =
  var outPtr: ptr VipsImage
  let rc = vips_resize(img.v, addr outPtr, scale.cdouble)
  checkVips(rc, "resize")
  Image(v: outPtr)

proc resize*(img: Image, width: int): Image =
  let scale = width.float / img.width.float
  img.resize(scale)

proc resize*(img: Image, width, height: int): Image =
  let scale = min(width.float / img.width.float, height.float / img.height.float)
  img.resize(scale)

proc rotate*(img: Image, angle: float): Image =
  var outPtr: ptr VipsImage
  let rc = vips_rotate(img.v, addr outPtr, angle.cdouble)
  checkVips(rc, "rotate")
  Image(v: outPtr)

proc rotate*(img: Image, angle: VipsAngle): Image =
  var outPtr: ptr VipsImage
  let rc = vips_rot(img.v, addr outPtr, angle)
  checkVips(rc, "rotate")
  Image(v: outPtr)

proc flip*(img: Image, direction: VipsDirection): Image =
  var outPtr: ptr VipsImage
  let rc = vips_flip(img.v, addr outPtr, direction)
  checkVips(rc, "flip")
  Image(v: outPtr)

proc flipHorizontal*(img: Image): Image =
  img.flip(VIPS_DIRECTION_HORIZONTAL)

proc flipVertical*(img: Image): Image =
  img.flip(VIPS_DIRECTION_VERTICAL)

proc crop*(img: Image, left, top, width, height: int): Image =
  var outPtr: ptr VipsImage
  let rc = vips_crop(img.v, addr outPtr, left.cint, top.cint, width.cint, height.cint)
  checkVips(rc, "crop")
  Image(v: outPtr)

proc crop*(img: Image, width, height: int): Image =
  let left = (img.width - width) div 2
  let top = (img.height - height) div 2
  img.crop(left, top, width, height)

proc smartCrop*(img: Image, width, height: int,
    interesting: VipsInteresting = VIPS_INTERESTING_ATTENTION): Image =
  var outPtr: ptr VipsImage
  let rc = vips_smartcrop(img.v, addr outPtr, width.cint, height.cint)
  checkVips(rc, "smart crop")
  Image(v: outPtr)

proc thumbnail*(img: Image, size: int): Image =
  var outPtr: ptr VipsImage
  let rc = vips_thumbnail_image(img.v, addr outPtr, size.cint)
  checkVips(rc, "thumbnail")
  Image(v: outPtr)

proc thumbnail*(img: Image, width, height: int): Image =
  result = img.thumbnail(width)
  if result.height > height:
    let scale = height.float / result.height.float
    result = result.resize(scale)

proc extractBand*(img: Image, band: int): Image =
  var outPtr: ptr VipsImage
  let rc = vips_extract_band(img.v, addr outPtr, band.cint)
  checkVips(rc, "extract band")
  Image(v: outPtr)

proc autorotate*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_autorot(img.v, addr outPtr)
  checkVips(rc, "auto-rotate")
  Image(v: outPtr)

proc embed*(img: Image, x, y, width, height: int,
    extend: VipsExtend = VIPS_EXTEND_BLACK): Image =
  var outPtr: ptr VipsImage
  let rc = vips_embed(img.v, addr outPtr, x.cint, y.cint, width.cint, height.cint)
  checkVips(rc, "embed")
  Image(v: outPtr)
