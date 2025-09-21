import std/[unittest, os]

import libvips
import libvips/bindings/glib/glib

proc logVipsError(prefix: string = "vips") =
  let msg = $vips_error_buffer()
  if msg.len > 0: echo prefix, " error: ", msg
  vips_error_clear()

suite "libvips bindings":

  # Resolve test asset relative to this source file
  let imgPath = parentDir(currentSourcePath()) / "data" / "07_11_000198_image_access_800.jpg"
  doAssert fileExists(imgPath), "Missing test image at: " & imgPath

  test "initialize libvips":
    # Use real argv0 so libvips can locate modules
    check vips_init(getAppFilename().cstring) == 0

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

  test "shutdown libvips":
    vips_shutdown()