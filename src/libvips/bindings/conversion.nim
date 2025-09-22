# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./basic, ./image, ./arithmetic

type
  VipsExtend* {.size: sizeof(cint).} = enum
    VIPS_EXTEND_BLACK,
    VIPS_EXTEND_COPY,
    VIPS_EXTEND_REPEAT,
    VIPS_EXTEND_MIRROR,
    VIPS_EXTEND_WHITE,
    VIPS_EXTEND_BACKGROUND,
    VIPS_EXTEND_LAST

  VipsCompassDirection* {.size: sizeof(cint).} = enum
    VIPS_COMPASS_DIRECTION_CENTRE,
    VIPS_COMPASS_DIRECTION_NORTH,
    VIPS_COMPASS_DIRECTION_EAST,
    VIPS_COMPASS_DIRECTION_SOUTH,
    VIPS_COMPASS_DIRECTION_WEST,
    VIPS_COMPASS_DIRECTION_NORTH_EAST,
    VIPS_COMPASS_DIRECTION_SOUTH_EAST,
    VIPS_COMPASS_DIRECTION_SOUTH_WEST,
    VIPS_COMPASS_DIRECTION_NORTH_WEST,
    VIPS_COMPASS_DIRECTION_LAST

  VipsDirection* {.size: sizeof(cint).} = enum
    VIPS_DIRECTION_HORIZONTAL,
    VIPS_DIRECTION_VERTICAL,
    VIPS_DIRECTION_LAST

  VipsAlign* {.size: sizeof(cint).} = enum
    VIPS_ALIGN_LOW,
    VIPS_ALIGN_CENTRE,
    VIPS_ALIGN_HIGH,
    VIPS_ALIGN_LAST

  VipsAngle* {.size: sizeof(cint).} = enum
    VIPS_ANGLE_D0,
    VIPS_ANGLE_D90,
    VIPS_ANGLE_D180,
    VIPS_ANGLE_D270,
    VIPS_ANGLE_LAST

  VipsAngle45* {.size: sizeof(cint).} = enum
    VIPS_ANGLE45_D0,
    VIPS_ANGLE45_D45,
    VIPS_ANGLE45_D90,
    VIPS_ANGLE45_D135,
    VIPS_ANGLE45_D180,
    VIPS_ANGLE45_D225,
    VIPS_ANGLE45_D270,
    VIPS_ANGLE45_D315,
    VIPS_ANGLE45_LAST

  VipsInteresting* {.size: sizeof(cint).} = enum
    VIPS_INTERESTING_NONE,
    VIPS_INTERESTING_CENTRE,
    VIPS_INTERESTING_ENTROPY,
    VIPS_INTERESTING_ATTENTION,
    VIPS_INTERESTING_LOW,
    VIPS_INTERESTING_HIGH,
    VIPS_INTERESTING_ALL,
    VIPS_INTERESTING_LAST

  VipsBlendMode* {.size: sizeof(cint).} = enum
    VIPS_BLEND_MODE_CLEAR,
    VIPS_BLEND_MODE_SOURCE,
    VIPS_BLEND_MODE_OVER,
    VIPS_BLEND_MODE_IN,
    VIPS_BLEND_MODE_OUT,
    VIPS_BLEND_MODE_ATOP,
    VIPS_BLEND_MODE_DEST,
    VIPS_BLEND_MODE_DEST_OVER,
    VIPS_BLEND_MODE_DEST_IN,
    VIPS_BLEND_MODE_DEST_OUT,
    VIPS_BLEND_MODE_DEST_ATOP,
    VIPS_BLEND_MODE_XOR,
    VIPS_BLEND_MODE_ADD,
    VIPS_BLEND_MODE_SATURATE,
    VIPS_BLEND_MODE_MULTIPLY,
    VIPS_BLEND_MODE_SCREEN,
    VIPS_BLEND_MODE_OVERLAY,
    VIPS_BLEND_MODE_DARKEN,
    VIPS_BLEND_MODE_LIGHTEN,
    VIPS_BLEND_MODE_COLOUR_DODGE,
    VIPS_BLEND_MODE_COLOUR_BURN,
    VIPS_BLEND_MODE_HARD_LIGHT,
    VIPS_BLEND_MODE_SOFT_LIGHT,
    VIPS_BLEND_MODE_DIFFERENCE,
    VIPS_BLEND_MODE_EXCLUSION,
    VIPS_BLEND_MODE_LAST

# Function declarations
{.push cdecl, header: "vips/vips.h".}
proc c_vips_copy(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_copy", varargs.}
proc c_vips_tilecache(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_tilecache", varargs.}
proc c_vips_linecache(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_linecache", varargs.}
proc c_vips_sequential(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_sequential", varargs.}
proc c_vips_copy_file(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_copy_file", varargs.}
proc c_vips_embed(input: ptr VipsImage, output: ptr ptr VipsImage, x, y, width, height: cint): cint {.importc: "vips_embed", varargs.}
proc c_vips_gravity(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsCompassDirection, width, height: cint): cint {.importc: "vips_gravity", varargs.}
proc c_vips_flip(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint {.importc: "vips_flip", varargs.}
proc c_vips_insert(main, sub: ptr VipsImage, output: ptr ptr VipsImage, x, y: cint): cint {.importc: "vips_insert", varargs.}
proc c_vips_join(in1, in2: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint {.importc: "vips_join", varargs.}
proc c_vips_arrayjoin(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.importc: "vips_arrayjoin", varargs.}
proc c_vips_extract_area(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint {.importc: "vips_extract_area", varargs.}
proc c_vips_crop(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint {.importc: "vips_crop", varargs.}
proc c_vips_smartcrop(input: ptr VipsImage, output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_smartcrop", varargs.}
proc c_vips_extract_band(input: ptr VipsImage, output: ptr ptr VipsImage, band: cint): cint {.importc: "vips_extract_band", varargs.}
proc c_vips_replicate(input: ptr VipsImage, output: ptr ptr VipsImage, across, down: cint): cint {.importc: "vips_replicate", varargs.}
proc c_vips_grid(input: ptr VipsImage, output: ptr ptr VipsImage, tile_height, across, down: cint): cint {.importc: "vips_grid", varargs.}
proc c_vips_transpose3d(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_transpose3d", varargs.}
proc c_vips_wrap(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_wrap", varargs.}
proc c_vips_rot(input: ptr VipsImage, output: ptr ptr VipsImage, angle: VipsAngle): cint {.importc: "vips_rot", varargs.}
proc c_vips_rot90(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_rot90", varargs.}
proc c_vips_rot180(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_rot180", varargs.}
proc c_vips_rot270(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_rot270", varargs.}
proc c_vips_rot45(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_rot45", varargs.}
proc c_vips_autorot_remove_angle(image: ptr VipsImage) {.cdecl, importc.}
proc c_vips_autorot(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_autorot", varargs.}
proc c_vips_zoom(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint {.importc: "vips_zoom", varargs.}
proc c_vips_subsample(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint {.importc: "vips_subsample", varargs.}
proc c_vips_cast(input: ptr VipsImage, output: ptr ptr VipsImage, format: VipsBandFormat): cint {.importc: "vips_cast", varargs.}
proc c_vips_cast_uchar(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_uchar", varargs.}
proc c_vips_cast_char(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_char", varargs.}
proc c_vips_cast_ushort(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_ushort", varargs.}
proc c_vips_cast_short(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_short", varargs.}
proc c_vips_cast_uint(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_uint", varargs.}
proc c_vips_cast_int(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_int", varargs.}
proc c_vips_cast_float(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_float", varargs.}
proc c_vips_cast_double(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_double", varargs.}
proc c_vips_cast_complex(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_complex", varargs.}
proc c_vips_cast_dpcomplex(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_cast_dpcomplex", varargs.}
proc c_vips_scale(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_scale", varargs.}
proc c_vips_msb(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_msb", varargs.}
proc c_vips_byteswap(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_byteswap", varargs.}
proc c_vips_bandjoin(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.importc: "vips_bandjoin", varargs.}
proc c_vips_bandjoin2(in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandjoin2", varargs.}
proc c_vips_bandjoin_const(input: ptr VipsImage, output: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_bandjoin_const", varargs.}
proc c_vips_bandjoin_const1(input: ptr VipsImage, output: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_bandjoin_const1", varargs.}
proc c_vips_bandrank(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.importc: "vips_bandrank", varargs.}
proc c_vips_bandfold(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandfold", varargs.}
proc c_vips_bandunfold(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandunfold", varargs.}
proc c_vips_bandbool(input: ptr VipsImage, output: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint {.importc: "vips_bandbool", varargs.}
proc c_vips_bandand(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandand", varargs.}
proc c_vips_bandor(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandor", varargs.}
proc c_vips_bandeor(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandeor", varargs.}
proc c_vips_bandmean(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_bandmean", varargs.}
proc c_vips_recomb(input: ptr VipsImage, output: ptr ptr VipsImage, m: ptr VipsImage): cint {.importc: "vips_recomb", varargs.}
proc c_vips_ifthenelse(cond, in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_ifthenelse", varargs.}
proc c_vips_switch(tests: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.importc: "vips_switch", varargs.}
proc c_vips_flatten(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_flatten", varargs.}
proc c_vips_addalpha(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_addalpha", varargs.}
proc c_vips_premultiply(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_premultiply", varargs.}
proc c_vips_unpremultiply(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_unpremultiply", varargs.}
proc c_vips_composite(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint, mode: ptr cint): cint {.importc: "vips_composite", varargs.}
proc c_vips_composite2(base, overlay: ptr VipsImage, output: ptr ptr VipsImage, mode: VipsBlendMode): cint {.importc: "vips_composite2", varargs.}
proc c_vips_falsecolour(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_falsecolour", varargs.}
proc c_vips_gamma(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_gamma", varargs.}
{.pop.}

# Safe wrappers
proc vips_copy*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_copy(input, output, nil)
  
proc vips_tilecache*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_tilecache(input, output, nil)
  
proc vips_linecache*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_linecache(input, output, nil)
  
proc vips_sequential*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_sequential(input, output, nil)
  
proc vips_copy_file*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_copy_file(input, output, nil)
  
proc vips_embed*(input: ptr VipsImage, output: ptr ptr VipsImage, x, y, width, height: cint): cint =
  c_vips_embed(input, output, x, y, width, height, nil)
  
proc vips_gravity*(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsCompassDirection, width, height: cint): cint =
  c_vips_gravity(input, output, direction, width, height, nil)
  
proc vips_flip*(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint =
  c_vips_flip(input, output, direction, nil)
  
proc vips_insert*(main, sub: ptr VipsImage, output: ptr ptr VipsImage, x, y: cint): cint =
  c_vips_insert(main, sub, output, x, y, nil)
  
proc vips_join*(in1, in2: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint =
  c_vips_join(in1, in2, output, direction, nil)
  
proc vips_arrayjoin*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint =
  c_vips_arrayjoin(input, output, n, nil)
  
proc vips_extract_area*(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint =
  c_vips_extract_area(input, output, left, top, width, height, nil)
  
proc vips_crop*(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint =
  c_vips_crop(input, output, left, top, width, height, nil)
  
proc vips_smartcrop*(input: ptr VipsImage, output: ptr ptr VipsImage, width, height: cint): cint =
  c_vips_smartcrop(input, output, width, height, nil)
  
proc vips_extract_band*(input: ptr VipsImage, output: ptr ptr VipsImage, band: cint): cint =
  c_vips_extract_band(input, output, band, nil)
  
proc vips_replicate*(input: ptr VipsImage, output: ptr ptr VipsImage, across, down: cint): cint =
  c_vips_replicate(input, output, across, down, nil)
  
proc vips_grid*(input: ptr VipsImage, output: ptr ptr VipsImage, tile_height, across, down: cint): cint =
  c_vips_grid(input, output, tile_height, across, down, nil)
  
proc vips_transpose3d*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_transpose3d(input, output, nil)
  
proc vips_wrap*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_wrap(input, output, nil)
  
proc vips_rot*(input: ptr VipsImage, output: ptr ptr VipsImage, angle: VipsAngle): cint =
  c_vips_rot(input, output, angle, nil)
  
proc vips_rot90*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_rot90(input, output, nil)
  
proc vips_rot180*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_rot180(input, output, nil)
  
proc vips_rot270*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_rot270(input, output, nil)
  
proc vips_rot45*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_rot45(input, output, nil)
  
proc vips_autorot_remove_angle*(image: ptr VipsImage) =
  c_vips_autorot_remove_angle(image)
proc vips_autorot*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_autorot(input, output, nil)
  
proc vips_zoom*(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint =
  c_vips_zoom(input, output, xfac, yfac, nil)
  
proc vips_subsample*(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint =
  c_vips_subsample(input, output, xfac, yfac, nil)
  
proc vips_cast*(input: ptr VipsImage, output: ptr ptr VipsImage, format: VipsBandFormat): cint =
  c_vips_cast(input, output, format, nil)
  
proc vips_cast_uchar*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_uchar(input, output, nil)
  
proc vips_cast_char*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_char(input, output, nil)
  
proc vips_cast_ushort*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_ushort(input, output, nil)
  
proc vips_cast_short*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_short(input, output, nil)
  
proc vips_cast_uint*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_uint(input, output, nil)
  
proc vips_cast_int*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_int(input, output, nil)
  
proc vips_cast_float*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_float(input, output, nil)
  
proc vips_cast_double*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_double(input, output, nil)
  
proc vips_cast_complex*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_complex(input, output, nil)
  
proc vips_cast_dpcomplex*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_cast_dpcomplex(input, output, nil)
  
proc vips_scale*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_scale(input, output, nil)
  
proc vips_msb*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_msb(input, output, nil)
  
proc vips_byteswap*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_byteswap(input, output, nil)
  
proc vips_bandjoin*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint =
  c_vips_bandjoin(input, output, n, nil)
  
proc vips_bandjoin2*(in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandjoin2(in1, in2, output, nil)
  
proc vips_bandjoin_const*(input: ptr VipsImage, output: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_bandjoin_const(input, output, c, n, nil)
  
proc vips_bandjoin_const1*(input: ptr VipsImage, output: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_bandjoin_const1(input, output, c, nil)
  
proc vips_bandrank*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint =
  c_vips_bandrank(input, output, n, nil)
  
proc vips_bandfold*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandfold(input, output, nil)
  
proc vips_bandunfold*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandunfold(input, output, nil)
  
proc vips_bandbool*(input: ptr VipsImage, output: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint =
  c_vips_bandbool(input, output, boolean, nil)
  
proc vips_bandand*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandand(input, output, nil)
  
proc vips_bandor*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandor(input, output, nil)
  
proc vips_bandeor*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandeor(input, output, nil)
  
proc vips_bandmean*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_bandmean(input, output, nil)
  
proc vips_recomb*(input: ptr VipsImage, output: ptr ptr VipsImage, m: ptr VipsImage): cint =
  c_vips_recomb(input, output, m, nil)
  
proc vips_ifthenelse*(cond, in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_ifthenelse(cond, in1, in2, output, nil)
  
proc vips_switch*(tests: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint =
  c_vips_switch(tests, output, n, nil)
  
proc vips_flatten*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_flatten(input, output, nil)
  
proc vips_addalpha*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_addalpha(input, output, nil)
  
proc vips_premultiply*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_premultiply(input, output, nil)
  
proc vips_unpremultiply*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_unpremultiply(input, output, nil)
  
proc vips_composite*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint, mode: ptr cint): cint =
  c_vips_composite(input, output, n, mode, nil)
  
proc vips_composite2*(base, overlay: ptr VipsImage, output: ptr ptr VipsImage, mode: VipsBlendMode): cint =
  c_vips_composite2(base, overlay, output, mode, nil)
  
proc vips_falsecolour*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_falsecolour(input, output, nil)
  
proc vips_gamma*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_gamma(input, output, nil)
