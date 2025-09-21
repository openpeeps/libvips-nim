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
{.push cdecl, importc, header: "vips/convolution.h".}
proc vips_conv*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_convf*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_convi*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_conva*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_convsep*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_convasep*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_compass*(input: ptr VipsImage, output: ptr ptr VipsImage, mask: ptr VipsImage, args: varargs[pointer]): cint
proc vips_gaussblur*(input: ptr VipsImage, output: ptr ptr VipsImage, sigma: cdouble, args: varargs[pointer]): cint
proc vips_sharpen*(input: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_spcor*(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_fastcor*(input: ptr VipsImage, reference: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_sobel*(input: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_scharr*(input: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_prewitt*(input: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
proc vips_canny*(input: ptr VipsImage, output: ptr ptr VipsImage, args: varargs[pointer]): cint
{.pop.}