import std/[unittest, os, times]
import libvips/api

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

  test "resize image":
    initVips:
      let img = api.openImage(imgPath)
      let resized = img.resize(0.5)
      resized.save(tempPath / "api_test_output_resize.jpg")
      
      assert fileExists(tempPath / "api_test_output_resize.jpg")
      removeFile(tempPath / "api_test_output_resize.jpg")

  test "rotate image":
    initVips:
      let img = api.openImage(imgPath)
      let rotated = img.rotate(90)
      rotated.save(tempPath / "api_test_output_rotate.jpg")

  test "crop":
    initVips:
      let img = api.openImage(imgPath)
      let cropped = img.crop(100, 100, 200, 200)
      cropped.save(tempPath / "api_test_output_crop.jpg")

  test "crop center":
    initVips:
      let img = api.openImage(imgPath)
      let cropped = img.crop(200, 200)
      cropped.save(tempPath / "api_test_output_crop_center.jpg")