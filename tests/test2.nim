import std/[unittest, os]
import libvips/api

suite "libvips high-level API v2":
  let
    tempPath = parentDir(currentSourcePath()) / "temp"
    dataPath = parentDir(currentSourcePath()) / "data"
    imgPath = dataPath / "07_11_000198_image_access_800.jpg"

  discard existsOrCreateDir(tempPath)

  test "open and save image":
    initVips:
      let img = openImage(imgPath)
      img.save(tempPath / "api2_test_output.jpg")
      assert fileExists(tempPath / "api2_test_output.jpg")

  test "image properties":
    initVips:
      let img = openImage(imgPath)
      assert img.width == 562
      assert img.height == 800
      assert img.bands == 3
      assert img.format == VIPS_FORMAT_UCHAR
      assert img.space == VIPS_INTERPRETATION_sRGB
      assert not img.hasAlpha

  test "resize image":
    initVips:
      let img = openImage(imgPath)
      let resized = img.resize(0.5)
      assert resized.width == 281
      assert resized.height == 400
      resized.save(tempPath / "api2_test_output_resize.jpg")

  test "resize to width":
    initVips:
      let img = openImage(imgPath)
      let resized = img.resize(200)
      assert resized.width == 200

  test "rotate image":
    initVips:
      let img = openImage(imgPath)
      let rotated = img.rotate(90)
      rotated.save(tempPath / "api2_test_output_rotate.jpg")

  test "rotate by angle enum":
    initVips:
      let img = openImage(imgPath)
      let rotated = img.rotate(VIPS_ANGLE_D90)
      rotated.save(tempPath / "api2_test_output_rotate90.jpg")

  test "flip horizontal":
    initVips:
      let img = openImage(imgPath)
      let flipped = img.flipHorizontal()
      flipped.save(tempPath / "api2_test_output_flip_h.jpg")

  test "flip vertical":
    initVips:
      let img = openImage(imgPath)
      let flipped = img.flipVertical()
      flipped.save(tempPath / "api2_test_output_flip_v.jpg")

  test "crop":
    initVips:
      let img = openImage(imgPath)
      let cropped = img.crop(100, 100, 200, 200)
      assert cropped.width == 200
      assert cropped.height == 200
      cropped.save(tempPath / "api2_test_output_crop.jpg")

  test "crop center":
    initVips:
      let img = openImage(imgPath)
      let cropped = img.crop(200, 200)
      assert cropped.width == 200
      assert cropped.height == 200
      cropped.save(tempPath / "api2_test_output_crop_center.jpg")

  test "smart crop":
    initVips:
      let img = openImage(imgPath)
      let cropped = img.smartCrop(200, 200)
      assert cropped.width == 200
      assert cropped.height == 200
      cropped.save(tempPath / "api2_test_output_smartcrop.jpg")

  test "thumbnail":
    initVips:
      let img = openImage(imgPath)
      let thumb = img.thumbnail(150)
      assert thumb.width <= 150
      thumb.save(tempPath / "api2_test_output_thumbnail.jpg")

  test "thumbnail from file":
    initVips:
      let thumb = thumbnailFromFile(imgPath, 150)
      assert thumb.width <= 150
      thumb.save(tempPath / "api2_test_output_thumbnail_file.jpg")

  test "sharpen":
    initVips:
      let img = openImage(imgPath)
      let sharp = img.sharpen()
      sharp.save(tempPath / "api2_test_output_sharpen.jpg")

  test "blur":
    initVips:
      let img = openImage(imgPath)
      let blurred = img.blur(5.0)
      blurred.save(tempPath / "api2_test_output_blur.jpg")

  test "invert":
    initVips:
      let img = openImage(imgPath)
      let inv = img.invert()
      inv.save(tempPath / "api2_test_output_invert.jpg")

  test "gamma":
    initVips:
      let img = openImage(imgPath)
      let g = img.gamma()
      g.save(tempPath / "api2_test_output_gamma.jpg")

  test "extract band":
    initVips:
      let img = openImage(imgPath)
      let r = img.extractBand(0)
      assert r.bands == 1
      r.save(tempPath / "api2_test_output_red_channel.jpg")

  test "autorotate":
    initVips:
      let img = openImage(imgPath)
      let auto = img.autorotate()
      auto.save(tempPath / "api2_test_output_autorotate.jpg")

  test "colourspace conversion":
    initVips:
      let img = openImage(imgPath)
      let grey = img.toGrayscale()
      assert grey.bands == 1
      grey.save(tempPath / "api2_test_output_grayscale.jpg")

  test "add alpha and flatten":
    initVips:
      let img = openImage(imgPath)
      let withAlpha = img.addAlpha()
      assert withAlpha.hasAlpha
      assert withAlpha.bands == 4
      let flat = withAlpha.flatten()
      flat.save(tempPath / "api2_test_output_flatten.jpg")

  test "band join":
    initVips:
      let img = openImage(imgPath)
      let r = img.extractBand(0)
      let g = img.extractBand(1)
      let b = img.extractBand(2)
      let rejoined = r.bandJoin(g).bandJoin(b)
      assert rejoined.bands == 3
      rejoined.save(tempPath / "api2_test_output_bandjoin.jpg")

  test "band mean":
    initVips:
      let img = openImage(imgPath)
      let mean = img.bandMean()
      assert mean.bands == 1
      mean.save(tempPath / "api2_test_output_bandmean.jpg")

  test "analysis - avg, min, max":
    initVips:
      let img = openImage(imgPath)
      let a = img.avg()
      let mn = img.min()
      let mx = img.max()
      assert a > 0.0
      assert mn >= 0.0
      assert mx <= 255.0

  test "analysis - deviate":
    initVips:
      let img = openImage(imgPath)
      let d = img.deviate()
      assert d > 0.0

  test "analysis - histogram":
    initVips:
      let img = openImage(imgPath)
      let hist = img.histogram()
      assert hist.width > 0
      hist.save(tempPath / "api2_test_output_histogram.jpg")

  test "analysis - find trim":
    initVips:
      let img = openImage(imgPath)
      let (l, t, w, h) = img.findTrim()
      assert w > 0
      assert h > 0

  test "analysis - get point":
    initVips:
      let img = openImage(imgPath)
      let p = img.getPoint(0, 0)
      assert p.len == 3

  test "edge detection - sobel":
    initVips:
      let img = openImage(imgPath)
      let edges = img.sobel()
      edges.save(tempPath / "api2_test_output_sobel.jpg")

  test "edge detection - canny":
    initVips:
      let img = openImage(imgPath)
      let edges = img.canny().scale().castUchar()
      edges.save(tempPath / "api2_test_output_canny.jpg")

  test "watermark":
    initVips:
      let img = openImage(imgPath)
      let wm = openImage(dataPath / "bpl.png")
      let watermarked = img.watermark(wm.resize(0.3), VAlignTop, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignTop, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignTop, HAlignRight)
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignRight)
                           .watermark(wm.resize(0.3), VAlignCenter, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignCenter, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignCenter, HAlignRight)
      watermarked.save(tempPath / "api2_test_output_watermark.jpg")
      assert fileExists(tempPath / "api2_test_output_watermark.jpg")

  test "composite blend modes":
    initVips:
      let img = openImage(imgPath)
      let overlay = openImage(dataPath / "bpl.png").resize(0.3)
      let blended = img.blendOver(overlay)
      blended.save(tempPath / "api2_test_output_blend_over.jpg")

  test "save JPEG with quality":
    initVips:
      let img = openImage(imgPath)
      img.saveJPEG(tempPath / "api2_test_output_quality.jpg", quality=85)
      assert fileExists(tempPath / "api2_test_output_quality.jpg")

  test "save PNG":
    initVips:
      let img = openImage(imgPath)
      img.savePNG(tempPath / "api2_test_output_png.png")
      assert fileExists(tempPath / "api2_test_output_png.png")

  test "save WebP":
    initVips:
      let img = openImage(imgPath)
      img.saveWebP(tempPath / "api2_test_output_webp.webp")
      assert fileExists(tempPath / "api2_test_output_webp.webp")

  test "save buffer JPEG":
    initVips:
      let img = openImage(imgPath)
      let buf = img.saveJPEG(quality=85)
      assert buf.len > 0
      assert buf.len > 1000
