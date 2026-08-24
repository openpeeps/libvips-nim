import ../bindings/vips
import ../bindings/glib/glib
import ./types, ./image, ./transform

proc g_free*(p: pointer) {.cdecl, importc: "g_free".}

const
  jpegDefaultQuality* = 75
  pngDefaultCompression* = 6
  webpDefaultQuality* = 75
  heifDefaultQuality* = 50
  avifDefaultQuality* = 50
  jxlDefaultQuality* = 75

proc save*(img: Image, path: string) =
  let rc = vips_image_write_to_file(img.v, path.cstring)
  checkVips(rc, "save image to: " & path)

proc saveJPEG*(img: Image, path: string, quality: range[0..100] = jpegDefaultQuality) =
  let rc = vips_jpegsave_safe(img.v, path.cstring, quality.cint)
  checkVips(rc, "save JPEG to: " & path)

proc savePNG*(img: Image, path: string, compression: range[0..9] = pngDefaultCompression) =
  let rc = vips_pngsave_safe(img.v, path.cstring, compression.cint)
  checkVips(rc, "save PNG to: " & path)

proc saveWebP*(img: Image, path: string, quality: range[0..100] = webpDefaultQuality) =
  let rc = vips_webpsave_safe(img.v, path.cstring, quality.cint)
  checkVips(rc, "save WebP to: " & path)

proc saveTIFF*(img: Image, path: string, compression: VipsForeignTiffCompression = VIPS_FOREIGN_TIFF_COMPRESSION_LZW) =
  let rc = vips_tiffsave_safe(img.v, path.cstring, compression.cint)
  checkVips(rc, "save TIFF to: " & path)

proc saveHEIF*(img: Image, path: string, quality: range[0..100] = heifDefaultQuality) =
  let rc = vips_heifsave_safe(img.v, path.cstring, quality.cint)
  checkVips(rc, "save HEIF to: " & path)

proc saveAVIF*(img: Image, path: string, quality: range[0..100] = avifDefaultQuality) =
  let rc = vips_heifsave_safe(img.v, path.cstring, quality.cint)
  checkVips(rc, "save AVIF to: " & path)

proc saveJXL*(img: Image, path: string, quality: range[0..100] = jxlDefaultQuality) =
  let rc = vips_jxlsave_safe(img.v, path.cstring, quality.cint)
  checkVips(rc, "save JXL to: " & path)

proc saveJPEG*(img: Image, quality: range[0..100] = jpegDefaultQuality): seq[uint8] =
  var buf: pointer
  var len: csize_t
  let rc = vips_jpegsave_buffer_safe(img.v, addr buf, addr len, quality.cint)
  checkVips(rc, "save JPEG to buffer")
  result = newSeq[uint8](len)
  copyMem(addr result[0], buf, len)
  g_free(buf)

proc savePNG*(img: Image, compression: range[0..9] = pngDefaultCompression): seq[uint8] =
  var buf: pointer
  var len: csize_t
  let rc = vips_pngsave_buffer_safe(img.v, addr buf, addr len, compression.cint)
  checkVips(rc, "save PNG to buffer")
  result = newSeq[uint8](len)
  copyMem(addr result[0], buf, len)
  g_free(buf)

proc saveWebP*(img: Image, quality: range[0..100] = webpDefaultQuality): seq[uint8] =
  var buf: pointer
  var len: csize_t
  let rc = vips_webpsave_buffer_safe(img.v, addr buf, addr len, quality.cint)
  checkVips(rc, "save WebP to buffer")
  result = newSeq[uint8](len)
  copyMem(addr result[0], buf, len)
  g_free(buf)

proc thumbnailFromFile*(path: string, width: int): Image =
  var outPtr: ptr VipsImage
  let rc = vips_thumbnail(path.cstring, addr outPtr, width.cint)
  checkVips(rc, "create thumbnail from: " & path)
  Image(v: outPtr)

proc thumbnailFromFile*(path: string, width, height: int): Image =
  result = thumbnailFromFile(path, width)
  if result.height > height:
    let scale = height.float / result.height.float
    result = result.resize(scale)

proc thumbnailFromBuffer*(buf: seq[uint8], width: int): Image =
  var outPtr: ptr VipsImage
  let rc = vips_thumbnail_buffer(unsafeAddr buf[0], buf.len.csize_t, addr outPtr, width.cint)
  checkVips(rc, "create thumbnail from buffer")
  Image(v: outPtr)

proc thumbnailFromBuffer*(buf: seq[uint8], width, height: int): Image =
  result = thumbnailFromBuffer(buf, width)
  if result.height > height:
    let scale = height.float / result.height.float
    result = result.resize(scale)

proc loadGIF*(path: string): Image =
  var outPtr: ptr VipsImage
  let rc = vips_gifload(path.cstring, addr outPtr)
  checkVips(rc, "load GIF from: " & path)
  Image(v: outPtr)

proc saveGIF*(img: Image, path: string) =
  let rc = vips_gifsave_safe(img.v, path.cstring)
  checkVips(rc, "save GIF to: " & path)
