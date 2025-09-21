# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./image, ./rect

type
  VipsTransformation* = object
    iarea*: VipsRect
    oarea*: VipsRect
    a*, b*, c*, d*: cdouble
    idx*, idy*: cdouble
    odx*, ody*: cdouble
    ia*, ib*, ic*, id*: cdouble

{.push cdecl, importc, header: "vips/transform.h".}
proc vips__transform_init*(trn: ptr VipsTransformation)
proc vips__transform_calc_inverse*(trn: ptr VipsTransformation): cint
proc vips__transform_isidentity*(trn: ptr VipsTransformation): cint
proc vips__transform_add*(in1: ptr VipsTransformation, in2: ptr VipsTransformation, out: ptr VipsTransformation): cint
proc vips__transform_print*(trn: ptr VipsTransformation)
proc vips__transform_forward_point*(trn: ptr VipsTransformation, x, y: cdouble, ox, oy: ptr cdouble)
proc vips__transform_invert_point*(trn: ptr VipsTransformation, x, y: cdouble, ox, oy: ptr cdouble)
proc vips__transform_forward_rect*(trn: ptr VipsTransformation, `in`: ptr VipsRect, out: ptr VipsRect)
proc vips__transform_invert_rect*(trn: ptr VipsTransformation, `in`: ptr VipsRect, out: ptr VipsRect)
proc vips__transform_set_area*(trn: ptr VipsTransformation)
proc vips__affine*(input: ptr VipsImage, output: ptr VipsImage, trn: ptr VipsTransformation): cint
{.pop.}