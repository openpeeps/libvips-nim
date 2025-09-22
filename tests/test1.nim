import std/[unittest, os, times]

import libvips
import libvips/bindings/glib/glib

proc logVipsError(prefix: string = "vips") =
  let msg = $vips_error_buffer()
  if msg.len > 0: echo prefix, " error: ", msg
  vips_error_clear()

template runBasicTests() =
  let startTime = cpuTime()
  # Resolve test asset relative to this source file
  let imgPath = parentDir(currentSourcePath()) / "data" / "07_11_000198_image_access_800.jpg"
  doAssert fileExists(imgPath), "Missing test image at: " & imgPath
  
  test "create and save image":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    let outPath = "test_output.jpg"
    let rc = vips_image_write_to_file(img, outPath.cstring)
    if rc != 0: logVipsError("save")
    check rc == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    removeFile(outPath)

  test "image properties":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    assert vips_image_get_width(img) == 562
    assert vips_image_get_height(img) == 800
    assert vips_image_get_bands(img) == 3
    assert vips_image_get_format(img) == VIPS_FORMAT_UCHAR
    
    g_object_unref(img)

  test "simple image operation":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    var outImg: ptr VipsImage
    let rcInv = vips_invert(img, addr outImg)
    if rcInv != 0: logVipsError("invert")
    check rcInv == 0

    let outPath = "test_output_invert.jpg"
    let rcW = vips_image_write_to_file(outImg, outPath.cstring)
    if rcW != 0: logVipsError("save")
    check rcW == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    if outImg != nil: g_object_unref(outImg)
    removeFile(outPath)

  test "resize image":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    var outImg: ptr VipsImage
    let scale = 0.5.cdouble
    let rcR = vips_resize(img, addr outImg, scale)
    if rcR != 0: logVipsError("resize")
    check rcR == 0
    check vips_image_get_width(outImg) == 281
    check vips_image_get_height(outImg) == 400

    # write resized image
    let outPath = "test_output_resize.jpg"
    let rcW = vips_image_write_to_file(outImg, outPath.cstring)
    if rcW != 0: logVipsError("save")
    check rcW == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    if outImg != nil: g_object_unref(outImg)
    removeFile(outPath)

  test "crop image":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    var outImg: ptr VipsImage
    let left = 100.cint
    let top = 100.cint
    let width = 200.cint
    let height = 200.cint
    let rcC = vips_crop(img, addr outImg, left, top, width, height)
    if rcC != 0: logVipsError("crop")
    check rcC == 0
    check vips_image_get_width(outImg) == width
    check vips_image_get_height(outImg) == height

    # write cropped image
    let outPath = "test_output_crop.jpg"
    let rcW = vips_image_write_to_file(outImg, outPath.cstring)
    if rcW != 0: logVipsError("save")
    check rcW == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    if outImg != nil: g_object_unref(outImg)
    removeFile(outPath)

  test "flip image":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    var outImg: ptr VipsImage
    let rcF = vips_flip(img, addr outImg, VIPS_DIRECTION_VERTICAL)
    if rcF != 0: logVipsError("flip")
    check rcF == 0

    # write flipped image
    let outPath = "test_output_flip.jpg"
    let rcW = vips_image_write_to_file(outImg, outPath.cstring)
    if rcW != 0: logVipsError("save")
    check rcW == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    if outImg != nil: g_object_unref(outImg)
    removeFile(outPath)

  test "rotate image":
    var img = vips_image_new_from_file(imgPath.cstring)
    if img == nil: logVipsError("load")
    check img != nil

    var outImg: ptr VipsImage
    let angle = 90.cdouble
    let rcR = vips_rotate(img, addr outImg, angle)
    if rcR != 0: logVipsError("rotate")
    check rcR == 0

    # write rotated image
    let outPath = "test_output_rotate.jpg"
    let rcW = vips_image_write_to_file(outImg, outPath.cstring)
    if rcW != 0: logVipsError("save")
    check rcW == 0
    check fileExists(outPath)

    # Clean up
    if img != nil: g_object_unref(img)
    if outImg != nil: g_object_unref(outImg)
    removeFile(outPath)

  echo "Suite time: ", cpuTime() - startTime, " seconds"

suite "libvips low-level bindings":
  check vips_init(getAppFilename().cstring) == 0
  runBasicTests()

suite "libvips low-level SIMD/GPU acceleration":
  check vips_init(getAppFilename().cstring) == 0

  vips_vector_set_enabled(1)
  vips_concurrency_set(4)
  assert vips_vector_isenabled() == 1

  runBasicTests()