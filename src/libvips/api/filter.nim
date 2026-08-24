import ../bindings/vips
import ./types, ./image

proc sharpen*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_sharpen(img.v, addr outPtr)
  checkVips(rc, "sharpen")
  Image(v: outPtr)

proc blur*(img: Image, sigma: float64 = 1.0): Image =
  var outPtr: ptr VipsImage
  let rc = vips_gaussblur(img.v, addr outPtr, sigma.cdouble)
  checkVips(rc, "gaussian blur")
  Image(v: outPtr)

proc invert*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_invert(img.v, addr outPtr)
  checkVips(rc, "invert")
  Image(v: outPtr)

proc gamma*(img: Image, exponent: float64 = 2.2): Image =
  var outPtr: ptr VipsImage
  let rc = vips_gamma(img.v, addr outPtr, exponent.cdouble)
  checkVips(rc, "gamma")
  Image(v: outPtr)

proc sobel*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_sobel(img.v, addr outPtr)
  checkVips(rc, "sobel")
  Image(v: outPtr)

proc scharr*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_scharr(img.v, addr outPtr)
  checkVips(rc, "scharr")
  Image(v: outPtr)

proc prewitt*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_prewitt(img.v, addr outPtr)
  checkVips(rc, "prewitt")
  Image(v: outPtr)

proc canny*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_canny(img.v, addr outPtr)
  checkVips(rc, "canny edge detection")
  Image(v: outPtr)

proc absolute*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_abs(img.v, addr outPtr)
  checkVips(rc, "absolute value")
  Image(v: outPtr)

proc clamp*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_clamp(img.v, addr outPtr)
  checkVips(rc, "clamp")
  Image(v: outPtr)
