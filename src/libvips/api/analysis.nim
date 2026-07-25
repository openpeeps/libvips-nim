import ../bindings/vips
import ./types, ./image

proc avg*(img: Image): float64 =
  var res: cdouble
  let rc = vips_avg(img.v, addr res)
  checkVips(rc, "compute average")
  res

proc min*(img: Image): float64 =
  var res: cdouble
  let rc = vips_min(img.v, addr res)
  checkVips(rc, "compute minimum")
  res

proc max*(img: Image): float64 =
  var res: cdouble
  let rc = vips_max(img.v, addr res)
  checkVips(rc, "compute maximum")
  res

proc deviate*(img: Image): float64 =
  var res: cdouble
  let rc = vips_deviate(img.v, addr res)
  checkVips(rc, "compute standard deviation")
  res

proc histogram*(img: Image): Image =
  var outPtr: ptr VipsImage
  let rc = vips_hist_find(img.v, addr outPtr)
  checkVips(rc, "find histogram")
  Image(v: outPtr)

proc findTrim*(img: Image): tuple[left, top, width, height: int] =
  var left, top, width, height: cint
  let rc = vips_find_trim(img.v, addr left, addr top, addr width, addr height)
  checkVips(rc, "find trim")
  (left.int, top.int, width.int, height.int)

proc getPoint*(img: Image, x, y: int): seq[cdouble] =
  var vec: ptr cdouble
  var n: cint
  let rc = vips_getpoint(img.v, addr vec, addr n, x.cint, y.cint)
  checkVips(rc, "get point")
  let arr = cast[ptr UncheckedArray[cdouble]](vec)
  result = newSeq[cdouble](n)
  for i in 0 ..< int(n): result[i] = arr[i]
