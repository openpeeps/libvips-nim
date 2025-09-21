# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./basic, ./types

type
  VipsKernel* = enum
    VIPS_KERNEL_NEAREST,
    VIPS_KERNEL_LINEAR,
    VIPS_KERNEL_CUBIC,
    VIPS_KERNEL_MITCHELL,
    VIPS_KERNEL_LANCZOS2,
    VIPS_KERNEL_LANCZOS3,
    VIPS_KERNEL_LAST

  VipsSize* = enum
    VIPS_SIZE_BOTH,
    VIPS_SIZE_UP,
    VIPS_SIZE_DOWN,
    VIPS_SIZE_FORCE,
    VIPS_SIZE_LAST

{.push cdecl, importc, header: "vips/resample.h".}
proc c_vips_shrink*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink, vshrink: cdouble): cint {.varargs.}
proc c_vips_shrinkh*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink: cint): cint {.varargs.}
proc c_vips_shrinkv*(input: ptr VipsImage, output: ptr ptr VipsImage, vshrink: cint): cint {.varargs.}
proc c_vips_reduce*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink, vshrink: cdouble): cint {.varargs.}
proc c_vips_reduceh*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink: cdouble): cint {.varargs.}
proc c_vips_reducev*(input: ptr VipsImage, output: ptr ptr VipsImage, vshrink: cdouble): cint {.varargs.}
proc c_vips_thumbnail*(filename: cstring, output: ptr ptr VipsImage, width: cint): cint {.varargs.}
proc c_vips_thumbnail_buffer*(buf: pointer, len: csize_t, output: ptr ptr VipsImage, width: cint): cint {.varargs.}
proc c_vips_thumbnail_image*(input: ptr VipsImage, output: ptr ptr VipsImage, width: cint): cint {.varargs.}
proc c_vips_thumbnail_source*(source: ptr VipsSource, output: ptr ptr VipsImage, width: cint): cint {.varargs.}
proc c_vips_similarity*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc c_vips_rotate*(input: ptr VipsImage, output: ptr ptr VipsImage, angle: cdouble): cint {.varargs.}
proc c_vips_affine*(input: ptr VipsImage, output: ptr ptr VipsImage, a, b, c, d: cdouble): cint {.varargs.}
proc c_vips_resize*(input: ptr VipsImage, output: ptr ptr VipsImage, scale: cdouble): cint {.varargs.}
proc c_vips_mapim*(input: ptr VipsImage, output: ptr ptr VipsImage, index: ptr VipsImage): cint {.varargs.}
proc c_vips_quadratic*(input: ptr VipsImage, output: ptr ptr VipsImage, coeff: ptr VipsImage): cint {.varargs.}
{.pop.}

# Safe, exported wrappers
proc vips_shrink*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink, vshrink: cdouble): cint =
  c_vips_shrink(input, output, hshrink, vshrink, nil)

proc vips_shrinkh*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink: cint): cint =
  c_vips_shrinkh(input, output, hshrink, nil)

proc vips_shrinkv*(input: ptr VipsImage, output: ptr ptr VipsImage, vshrink: cint): cint =
  c_vips_shrinkv(input, output, vshrink, nil)

proc vips_reduce*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink, vshrink: cdouble): cint =
  c_vips_reduce(input, output, hshrink, vshrink, nil)

proc vips_reduceh*(input: ptr VipsImage, output: ptr ptr VipsImage, hshrink: cdouble): cint =
  c_vips_reduceh(input, output, hshrink, nil)

proc vips_reducev*(input: ptr VipsImage, output: ptr ptr VipsImage, vshrink: cdouble): cint =
  c_vips_reducev(input, output, vshrink, nil)

proc vips_thumbnail*(filename: cstring, output: ptr ptr VipsImage, width: cint): cint =
  c_vips_thumbnail(filename, output, width, nil)

proc vips_thumbnail_buffer*(buf: pointer, len: csize_t, output: ptr ptr VipsImage, width: cint): cint =
  c_vips_thumbnail_buffer(buf, len, output, width, nil)

proc vips_thumbnail_image*(input: ptr VipsImage, output: ptr ptr VipsImage, width: cint): cint =
  c_vips_thumbnail_image(input, output, width, nil)

proc vips_thumbnail_source*(source: ptr VipsSource, output: ptr ptr VipsImage, width: cint): cint =
  c_vips_thumbnail_source(source, output, width, nil)

proc vips_similarity*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_similarity(input, output, nil)

proc vips_rotate*(input: ptr VipsImage, output: ptr ptr VipsImage, angle: cdouble): cint =
  c_vips_rotate(input, output, angle, nil)

proc vips_affine*(input: ptr VipsImage, output: ptr ptr VipsImage, a, b, c, d: cdouble): cint =
  c_vips_affine(input, output, a, b, c, d, nil)

proc vips_resize*(input: ptr VipsImage, output: ptr ptr VipsImage, scale: cdouble): cint =
  c_vips_resize(input, output, scale, nil)

proc vips_mapim*(input: ptr VipsImage, output: ptr ptr VipsImage, index: ptr VipsImage): cint =
  c_vips_mapim(input, output, index, nil)

proc vips_quadratic*(input: ptr VipsImage, output: ptr ptr VipsImage, coeff: ptr VipsImage): cint =
  c_vips_quadratic(input, output, coeff, nil)