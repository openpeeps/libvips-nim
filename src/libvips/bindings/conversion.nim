# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types

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
{.push cdecl, importc, header: "vips/conversion.h".}
proc vips_copy*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_tilecache*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_linecache*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_sequential*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_copy_file*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_embed*(input: ptr VipsImage, output: ptr ptr VipsImage, x, y, width, height: cint): cint {.varargs.}
proc vips_gravity*(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsCompassDirection, width, height: cint): cint {.varargs.}
proc vips_flip*(input: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint {.varargs.}
proc vips_insert*(main, sub: ptr VipsImage, output: ptr ptr VipsImage, x, y: cint): cint {.varargs.}
proc vips_join*(in1, in2: ptr VipsImage, output: ptr ptr VipsImage, direction: VipsDirection): cint {.varargs.}
proc vips_arrayjoin*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.varargs.}
proc vips_extract_area*(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint {.varargs.}
proc vips_crop*(input: ptr VipsImage, output: ptr ptr VipsImage, left, top, width, height: cint): cint {.varargs.}
proc vips_smartcrop*(input: ptr VipsImage, output: ptr ptr VipsImage, width, height: cint): cint {.varargs.}
proc vips_extract_band*(input: ptr VipsImage, output: ptr ptr VipsImage, band: cint): cint {.varargs.}
proc vips_replicate*(input: ptr VipsImage, output: ptr ptr VipsImage, across, down: cint): cint {.varargs.}
proc vips_grid*(input: ptr VipsImage, output: ptr ptr VipsImage, tile_height, across, down: cint): cint {.varargs.}
proc vips_transpose3d*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_wrap*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_rot*(input: ptr VipsImage, output: ptr ptr VipsImage, angle: VipsAngle): cint {.varargs.}
proc vips_rot90*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_rot180*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_rot270*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_rot45*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_autorot_remove_angle*(image: ptr VipsImage) {.cdecl, importc.}
proc vips_autorot*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_zoom*(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint {.varargs.}
proc vips_subsample*(input: ptr VipsImage, output: ptr ptr VipsImage, xfac, yfac: cint): cint {.varargs.}
proc vips_cast*(input: ptr VipsImage, output: ptr ptr VipsImage, format: VipsBandFormat): cint {.varargs.}
proc vips_cast_uchar*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_char*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_ushort*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_short*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_uint*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_int*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_float*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_double*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_complex*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_cast_dpcomplex*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_scale*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_msb*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_byteswap*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandjoin*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.varargs.}
proc vips_bandjoin2*(in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandjoin_const*(input: ptr VipsImage, output: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.varargs.}
proc vips_bandjoin_const1*(input: ptr VipsImage, output: ptr ptr VipsImage, c: cdouble): cint {.varargs.}
proc vips_bandrank*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.varargs.}
proc vips_bandfold*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandunfold*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandbool*(input: ptr VipsImage, output: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint {.varargs.}
proc vips_bandand*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandor*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandeor*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_bandmean*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_recomb*(input: ptr VipsImage, output: ptr ptr VipsImage, m: ptr VipsImage): cint {.varargs.}
proc vips_ifthenelse*(cond, in1, in2: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_switch*(tests: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint): cint {.varargs.}
proc vips_flatten*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_addalpha*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_premultiply*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_unpremultiply*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_composite*(input: ptr ptr VipsImage, output: ptr ptr VipsImage, n: cint, mode: ptr cint): cint {.varargs.}
proc vips_composite2*(base, overlay: ptr VipsImage, output: ptr ptr VipsImage, mode: VipsBlendMode): cint {.varargs.}
proc vips_falsecolour*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
proc vips_gamma*(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.varargs.}
{.pop.}