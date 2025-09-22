import std/[unittest, os, times]
import libvips/[api, watermark]

suite "libvips high-level API":
  let
    tempPath = parentDir(currentSourcePath()) / "temp"
    dataPath = parentDir(currentSourcePath()) / "data"
    imgPath = dataPath / "07_11_000198_image_access_800.jpg"

  discard existsOrCreateDir(tempPath)
  test "open and save image":
    initVips:
      let img = api.openImage(imgPath)
      img.save(tempPath / "api_test_output.jpg")
      assert fileExists(tempPath / "api_test_output.jpg")

  test "resize image":
    initVips:
      let img = api.openImage(imgPath)
      let resized = img.resize(0.5)
      resized.save(tempPath / "api_test_output_resize.jpg")
      assert fileExists(tempPath / "api_test_output_resize.jpg")

  test "rotate image":
    initVips:
      let img = api.openImage(imgPath)
      let rotated = img.rotate(90)
      rotated.save(tempPath / "api_test_output_rotate.jpg")
      assert fileExists(tempPath / "api_test_output_rotate.jpg")

  test "crop":
    initVips:
      let img = api.openImage(imgPath)
      let cropped = img.crop(100, 100, 200, 200)
      cropped.save(tempPath / "api_test_output_crop.jpg")
      assert fileExists(tempPath / "api_test_output_crop.jpg")

  test "crop center":
    initVips:
      let img = api.openImage(imgPath)
      let cropped = img.crop(200, 200)
      cropped.save(tempPath / "api_test_output_crop_center.jpg")
      assert fileExists(tempPath / "api_test_output_crop_center.jpg")

  test "thumbnail":
    initVips:
      let img = api.openImage(imgPath)
      let thumb = img.thumbnail(150)
      thumb.save(tempPath / "api_test_output_thumbnail.jpg")
      assert fileExists(tempPath / "api_test_output_thumbnail.jpg")

  test "sharpen":
    initVips:
      let img = api.openImage(imgPath)
      let sharp = img.sharpen()
      sharp.save(tempPath / "api_test_output_sharpen.jpg")
      assert fileExists(tempPath / "api_test_output_sharpen.jpg")
  
  test "blur":
    initVips:
      let img = api.openImage(imgPath)
      let blurred = img.blur(5.0)
      blurred.save(tempPath / "api_test_output_blur.jpg")
      assert fileExists(tempPath / "api_test_output_blur.jpg")

  test "watermark":
    initVips:
      let img = api.openImage(imgPath)
      let wm = api.openImage(dataPath / "bpl.png")
      let watermarked = img.watermark(wm.resize(0.3), VAlignTop, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignTop, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignTop, HAlignRight)
                           
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignBottom, HAlignRight)

                           .watermark(wm.resize(0.3), VAlignCenter, HAlignLeft)
                           .watermark(wm.resize(0.3), VAlignCenter, HAlignCenter)
                           .watermark(wm.resize(0.3), VAlignCenter, HAlignRight)
      watermarked.save(tempPath / "api_test_output_watermark.jpg")
      assert fileExists(tempPath / "api_test_output_watermark.jpg")