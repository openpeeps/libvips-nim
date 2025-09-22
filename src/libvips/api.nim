# High-level API for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./bindings/vips
import ./bindings/glib/glib

type
  VipsError* = object of CatchableError
    ## A VipsError represents an error returned by libvips operations.

template init_vips*(body: untyped) =
  block:
    assert vips_init(getAppFilename().cstring) == 0, "Failed to initialize libvips"
    body

proc enableVipsAcceleration*(numWorkers: int) =
  vips_vector_set_enabled(1)
  vips_concurrency_set(numWorkers.cint)
  assert vips_vector_isenabled() == 1

template init_vips_accelerated*(workers: int, body: untyped) =
  block:
    assert vips_init(getAppFilename().cstring) == 0, "Failed to initialize libvips"
    enableVipsAcceleration(workers)
    body

proc openImage*(path: string): ptr VipsImage =
  ## Open an image from the specified file path.
  var img = vips_image_new_from_file(path.cstring)
  assert img != nil, "Failed to load image from path: " & path
  img

proc save*(img: ptr VipsImage, path: string) =
  ## Save the image to the specified file path.
  let rc = vips_image_write_to_file(img, path.cstring)
  if rc != 0:
    raise newException(VipsError,
              "Failed to save image to path: " & path)

proc width*(img: ptr VipsImage): int =
  ## Get the width of the image.
  vips_image_get_width(img).int

proc height*(img: ptr VipsImage): int =
  ## Get the height of the image.
  vips_image_get_height(img).int

proc resize*(img: ptr VipsImage, scale: float): ptr VipsImage =
  ## Resize the image by the given scale factor.
  var res: ptr VipsImage
  let rc = vips_resize(img, addr res, cdouble(scale))
  if rc != 0:
    raise newException(VipsError, "Failed to resize image")
  res

proc rotate*(img: ptr VipsImage, angle: float = 90): ptr VipsImage =
  ## Rotate the image by the specified angle (in degrees).
  var res: ptr VipsImage
  let rc = vips_rotate(img, addr res, cdouble(angle))
  if rc != 0:
    raise newException(VipsError, "Failed to rotate image")
  res

proc flip*(img: ptr VipsImage, vertical: bool = true): ptr VipsImage =
  ## Flip the image vertically or horizontally.
  var res: ptr VipsImage
  let direction = if vertical: VIPS_DIRECTION_VERTICAL else: VIPS_DIRECTION_HORIZONTAL
  let rc = vips_flip(img, addr res, direction)
  if rc != 0:
    raise newException(VipsError, "Failed to flip image")
  res

proc crop*(img: ptr VipsImage, left, top, width, height: int): ptr VipsImage =
  ## Crop the image to the specified rectangle.
  var res: ptr VipsImage
  let rc = vips_crop(img, addr res, cint(left), cint(top), cint(width), cint(height))
  if rc != 0:
    raise newException(VipsError, "Failed to crop image")
  res

proc crop*(img: ptr VipsImage, width, height: int): ptr VipsImage =
  ## Crop the image to the specified width and height, centered.
  let left = (img.width - width) div 2
  let top = (img.height - height) div 2
  crop(img, left, top, width, height)

proc close*(img: ptr VipsImage) =
  ## Release resources associated with the image.
  if img != nil: g_object_unref(img)