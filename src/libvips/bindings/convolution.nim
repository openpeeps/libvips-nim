# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim
import ./types, ./basic, ./image

type
  VipsCombine* = enum
    VIPS_COMBINE_MAX,
    VIPS_COMBINE_SUM,
    VIPS_COMBINE_MIN,
    VIPS_COMBINE_LAST

# Assume VipsImage is defined elsewhere
{.push cdecl, header: "vips/vips.h".}
proc c_vips_conv(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_conv", varargs.}
proc c_vips_convf(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_convf", varargs.}
proc c_vips_convi(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_convi", varargs.}
proc c_vips_conva(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_conva", varargs.}
proc c_vips_convsep(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_convsep", varargs.}
proc c_vips_convasep(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_convasep", varargs.}
proc c_vips_compass(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint {.importc: "vips_compass", varargs.}
proc c_vips_gaussblur(input: ptr VipsImage, output: ptr ptr VipsImage, sigma: cdouble): cint {.importc: "vips_gaussblur", varargs.}
proc c_vips_sharpen(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_sharpen", varargs.}
proc c_vips_spcor(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_spcor", varargs.}
proc c_vips_fastcor(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_fastcor", varargs.}
proc c_vips_sobel(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_sobel", varargs.}
proc c_vips_scharr(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_scharr", varargs.}
proc c_vips_prewitt(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_prewitt", varargs.}
proc c_vips_canny(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_canny", varargs.}
{.pop.}

# Safe wrappers

proc vips_conv*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_conv(input, output, mask, nil)

proc vips_convf*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_convf(input, output, mask, nil)

proc vips_convi*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_convi(input, output, mask, nil)

proc vips_conva*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_conva(input, output, mask, nil)

proc vips_convsep*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_convsep(input, output, mask, nil)

proc vips_convasep*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_convasep(input, output, mask, nil)

proc vips_compass*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage): cint =
  c_vips_compass(input, output, mask, nil)

proc vips_gaussblur*(input: ptr VipsImage, output: ptr ptr VipsImage, sigma: cdouble): cint =
  c_vips_gaussblur(input, output, sigma, nil)

proc vips_sharpen*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_sharpen(input, output, nil)

proc vips_spcor*(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_spcor(input, reference, output, nil)

proc vips_fastcor*(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_fastcor(input, reference, output, nil)

proc vips_sobel*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_sobel(input, output, nil)

proc vips_scharr*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_scharr(input, output, nil)

proc vips_prewitt*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_prewitt(input, output, nil)

proc vips_canny*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_canny(input, output, nil)
