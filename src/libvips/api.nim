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
  VerticalAlignment* = enum
    VAlignTop, VAlignCenter, VAlignBottom
  
  HorizontalAlignment* = enum
    HAlignLeft, HAlignCenter, HAlignRight

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

proc close*(img: ptr VipsImage) # forward declaration

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

proc bands*(img: ptr VipsImage): int =
  ## Get the number of bands (channels) in the image.
  vips_image_get_bands(img).int

proc interpretation*(img: ptr VipsImage): VipsInterpretation =
  ## Get the color interpretation of the image.
  vips_image_get_interpretation(img)

proc format*(img: ptr VipsImage): VipsBandFormat =
  ## Get the pixel format of the image.
  vips_image_get_format(img)

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

proc thumbnail*(img: ptr VipsImage, size: int): ptr VipsImage =
  ## Create a thumbnail of the image with the specified maximum size.
  var res: ptr VipsImage
  let rc = vips_thumbnail_image(img, addr res, cint(size))
  if rc != 0:
    raise newException(VipsError, "Failed to create thumbnail")
  res

proc sharpen*(img: ptr VipsImage): ptr VipsImage =
  ## Sharpen the image.
  var res: ptr VipsImage
  let rc = vips_sharpen(img, addr res)
  if rc != 0:
    raise newException(VipsError, "Failed to sharpen image")
  res

proc blur*(img: ptr VipsImage, sigma: float = 1.0): ptr VipsImage =
  ## Blur the image using a Gaussian filter with the specified sigma.
  var res: ptr VipsImage
  let rc = vips_gaussblur(img, addr res, cdouble(sigma))
  if rc != 0:
    raise newException(VipsError, "Failed to blur image")
  res


#
# blending modes
#
proc blend*(img: ptr VipsImage, overlay: ptr VipsImage, mode: VipsBlendMode): ptr VipsImage =
  ## Blend the overlay image onto the base image using the specified mode.
  var res: ptr VipsImage
  let rc = vips_composite2(img, overlay, addr res, mode)
  if rc != 0:
    raise newException(VipsError, "Failed to blend images")
  res

proc blendMultiply*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using multiply mode.
  blend(img, overlay, VIPS_BLEND_MODE_MULTIPLY)

proc blendScreen*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using screen mode.
  blend(img, overlay, VIPS_BLEND_MODE_SCREEN)

proc blendOverlay*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using overlay mode.
  blend(img, overlay, VIPS_BLEND_MODE_OVERLAY)

proc blendDarken*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using darken mode.
  blend(img, overlay, VIPS_BLEND_MODE_DARKEN)

proc blendLighten*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using lighten mode.
  blend(img, overlay, VIPS_BLEND_MODE_LIGHTEN)

proc blendAdd*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using add mode.
  blend(img, overlay, VIPS_BLEND_MODE_ADD)

proc blendDifference*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using difference mode.
  blend(img, overlay, VIPS_BLEND_MODE_DIFFERENCE)

proc blendExclusion*(img: ptr VipsImage, overlay: ptr VipsImage): ptr VipsImage =
  ## Blend the overlay image onto the base image using exclusion mode.
  blend(img, overlay, VIPS_BLEND_MODE_EXCLUSION)

proc close*(img: ptr VipsImage) =
  ## Release resources associated with the image.
  if img != nil: g_object_unref(img)