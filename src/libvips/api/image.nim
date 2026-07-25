import ../bindings/vips
import ../bindings/glib/glib
import ./types

type
  ImageObj = object
    v*: ptr VipsImage
  Image* = ref ImageObj

proc `=destroy`(x: var ImageObj) =
  if x.v != nil:
    g_object_unref(cast[pointer](x.v))
    x.v = nil

template init_vips*(body: untyped) =
  block:
    assert vips_init(getAppFilename().cstring) == 0, "Failed to initialize libvips"
    body

proc enableVipsAcceleration*(numWorkers: int) =
  vips_vector_set_enabled(1)
  vips_concurrency_set(numWorkers.cint)
  assert vips_vector_isenabled() == 1

template init_vips_accelerated*(workers: int, body: untyped) {.dirty.} =
  assert vips_init(getAppFilename().cstring) == 0, "Failed to initialize libvips"
  enableVipsAcceleration(workers)
  body

proc openImage*(path: string): Image =
  var img = vips_image_new_from_file(path.cstring)
  if img == nil:
    raise newException(VipsError, vipsErrorContext("open image: " & path))
  Image(v: img)

proc openBuffer*(buf: seq[uint8]): Image =
  var img = vips_image_new_from_buffer(unsafeAddr buf[0], buf.len.csize_t, nil)
  if img == nil:
    raise newException(VipsError, vipsErrorContext("open image from buffer"))
  Image(v: img)

proc fromMemory*(data: seq[uint8], width, height, bands: int, format: VipsBandFormat): Image =
  var img = vips_image_new_from_memory(unsafeAddr data[0], data.len.csize_t,
    width.cint, height.cint, bands.cint, format)
  if img == nil:
    raise newException(VipsError, vipsErrorContext("create image from memory"))
  Image(v: img)

proc black*(width, height: int, bands: int = 1): Image =
  var outPtr: ptr VipsImage
  let rc = vips_black(addr outPtr, width, height)
  checkVips(rc, "create black image")
  result = Image(v: outPtr)
  if bands > 1:
    var imgs = newSeq[ptr VipsImage](bands)
    for i in 0 ..< bands: imgs[i] = outPtr
    var joinPtr: ptr VipsImage
    checkVips(vips_bandjoin(addr imgs[0], addr joinPtr, bands.cint), "join black image bands")
    result = Image(v: joinPtr)

proc text*(text: string): Image =
  var outPtr: ptr VipsImage
  let rc = vips_text(addr outPtr, text)
  checkVips(rc, "create text image")
  Image(v: outPtr)

proc width*(img: Image): int =
  vips_image_get_width(img.v).int

proc height*(img: Image): int =
  vips_image_get_height(img.v).int

proc bands*(img: Image): int =
  vips_image_get_bands(img.v).int

proc format*(img: Image): VipsBandFormat =
  vips_image_get_format(img.v)

proc space*(img: Image): VipsInterpretation =
  vips_image_get_interpretation(img.v)

proc hasAlpha*(img: Image): bool =
  vips_image_hasalpha(img.v) != 0

proc xres*(img: Image): float =
  vips_image_get_xres(img.v).float

proc yres*(img: Image): float =
  vips_image_get_yres(img.v).float

proc orientation*(img: Image): int =
  vips_image_get_orientation(img.v).int

proc castUchar*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_cast_uchar(img.v, addr outPtr)
  checkVips(rc, "cast to uchar")
  Image(v: outPtr)

proc scale*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_scale(img.v, addr outPtr)
  checkVips(rc, "scale")
  Image(v: outPtr)
