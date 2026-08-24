import ../bindings/vips
import ../bindings/glib/glib
import std/algorithm
import std/tables
import ./types, ./image, ./colour

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

proc stats*(img: Image): seq[seq[float64]] =
  var outPtr: ptr VipsImage
  let rc = vips_stats(img.v, addr outPtr)
  checkVips(rc, "compute stats")
  let hist = Image(v: outPtr)
  let nBands = hist.bands
  let width = hist.width
  let dataPtr = cast[ptr UncheckedArray[cdouble]](vips_image_get_data(hist.v))
  result = newSeq[seq[float64]](nBands)
  for b in 0 ..< nBands:
    result[b] = newSeq[float64](width)
    for x in 0 ..< width:
      result[b][x] = dataPtr[b * width + x]

proc histogramData*(img: Image, bins: int = 256): seq[float64] =
  var outPtr: ptr VipsImage
  let rc = vips_hist_find_ndim(img.v, addr outPtr, bins.cint)
  checkVips(rc, "find ndim histogram")
  let hist = Image(v: outPtr)
  let totalPixels = img.width.float * img.height.float
  let dataPtr = cast[ptr UncheckedArray[cdouble]](vips_image_get_data(hist.v))
  let nBins = hist.width
  result = newSeq[float64](nBins)
  for i in 0 ..< nBins:
    result[i] = dataPtr[i] / totalPixels

proc cumulativeHistogram*(img: Image, bins: int = 256): seq[float64] =
  result = img.histogramData(bins)
  var cumSum = 0.0
  for i in 0 ..< result.len:
    cumSum += result[i]
    result[i] = cumSum

type
  ColorEntry* = tuple[r, g, b: uint8, count: int]
  DeltaEMode* = enum
    dE76, dE00, dECMC

proc dominantColors*(img: Image, count: int = 5, accuracy: int = 10): seq[ColorEntry] =
  let srgb = img.toSRGB()
  let dataPtr = cast[ptr UncheckedArray[uint8]](vips_image_get_data(srgb.v))
  let nBands = srgb.bands
  let w = srgb.width
  let h = srgb.height
  var colorCounts: Table[(uint8, uint8, uint8), int]
  for y in 0 ..< h:
    for x in 0 ..< w:
      let idx = (y * w + x) * nBands
      let r = (dataPtr[idx] div accuracy.uint8) * accuracy.uint8
      let g = (dataPtr[idx + 1] div accuracy.uint8) * accuracy.uint8
      let b = (dataPtr[idx + 2] div accuracy.uint8) * accuracy.uint8
      let key = (r, g, b)
      colorCounts.mgetOrPut(key, 0) += 1
  var entries: seq[ColorEntry]
  for key, cnt in colorCounts:
    entries.add((key[0], key[1], key[2], cnt))
  entries.sort(proc (a, b: ColorEntry): int = cmp(b.count, a.count))
  if entries.len > count:
    entries.setLen(count)

proc deltaE*(img1, img2: Image, mode: DeltaEMode = dE76): float64 =
  let lab1 = img1.toLAB()
  let lab2 = img2.toLAB()
  var outPtr: ptr VipsImage
  let rc = case mode
  of dE76: vips_dE76(lab1.v, lab2.v, addr outPtr)
  of dE00: vips_dE00(lab1.v, lab2.v, addr outPtr)
  of dECMC: vips_dECMC(lab1.v, lab2.v, addr outPtr)
  checkVips(rc, "compute delta E")
  let diff = Image(v: outPtr)
  diff.avg()

proc equalize*(img: Image): Image =
  let y = img.toColourspace(VIPS_INTERPRETATION_B_W)
  var histPtr: ptr VipsImage
  checkVips(vips_hist_find(y.v, addr histPtr), "equalize: build histogram")
  var cumPtr: ptr VipsImage
  checkVips(vips_hist_cum(histPtr, addr cumPtr), "equalize: cumulative histogram")
  g_object_unref(cast[pointer](histPtr))
  var normPtr: ptr VipsImage
  checkVips(vips_hist_norm(cumPtr, addr normPtr), "equalize: normalize histogram")
  g_object_unref(cast[pointer](cumPtr))
  var outPtr: ptr VipsImage
  checkVips(vips_maplut(y.v, addr outPtr, normPtr), "equalize: apply LUT")
  g_object_unref(cast[pointer](normPtr))
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
