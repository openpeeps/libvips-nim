# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./basic, ./image

type
  VipsOperationMath* = enum
    VIPS_OPERATION_MATH_SIN,
    VIPS_OPERATION_MATH_COS,
    VIPS_OPERATION_MATH_TAN,
    VIPS_OPERATION_MATH_ASIN,
    VIPS_OPERATION_MATH_ACOS,
    VIPS_OPERATION_MATH_ATAN,
    VIPS_OPERATION_MATH_LOG,
    VIPS_OPERATION_MATH_LOG10,
    VIPS_OPERATION_MATH_EXP,
    VIPS_OPERATION_MATH_EXP10,
    VIPS_OPERATION_MATH_SINH,
    VIPS_OPERATION_MATH_COSH,
    VIPS_OPERATION_MATH_TANH,
    VIPS_OPERATION_MATH_ASINH,
    VIPS_OPERATION_MATH_ACOSH,
    VIPS_OPERATION_MATH_ATANH,
    VIPS_OPERATION_MATH_LAST

  VipsOperationMath2* = enum
    VIPS_OPERATION_MATH2_POW,
    VIPS_OPERATION_MATH2_WOP,
    VIPS_OPERATION_MATH2_ATAN2,
    VIPS_OPERATION_MATH2_LAST

  VipsOperationRound* = enum
    VIPS_OPERATION_ROUND_RINT,
    VIPS_OPERATION_ROUND_CEIL,
    VIPS_OPERATION_ROUND_FLOOR,
    VIPS_OPERATION_ROUND_LAST

  VipsOperationRelational* = enum
    VIPS_OPERATION_RELATIONAL_EQUAL,
    VIPS_OPERATION_RELATIONAL_NOTEQ,
    VIPS_OPERATION_RELATIONAL_LESS,
    VIPS_OPERATION_RELATIONAL_LESSEQ,
    VIPS_OPERATION_RELATIONAL_MORE,
    VIPS_OPERATION_RELATIONAL_MOREEQ,
    VIPS_OPERATION_RELATIONAL_LAST

  VipsOperationBoolean* = enum
    VIPS_OPERATION_BOOLEAN_AND,
    VIPS_OPERATION_BOOLEAN_OR,
    VIPS_OPERATION_BOOLEAN_EOR,
    VIPS_OPERATION_BOOLEAN_LSHIFT,
    VIPS_OPERATION_BOOLEAN_RSHIFT,
    VIPS_OPERATION_BOOLEAN_LAST

  VipsOperationComplex* = enum
    VIPS_OPERATION_COMPLEX_POLAR,
    VIPS_OPERATION_COMPLEX_RECT,
    VIPS_OPERATION_COMPLEX_CONJ,
    VIPS_OPERATION_COMPLEX_LAST

  VipsOperationComplex2* = enum
    VIPS_OPERATION_COMPLEX2_CROSS_PHASE,
    VIPS_OPERATION_COMPLEX2_LAST

  VipsOperationComplexget* = enum
    VIPS_OPERATION_COMPLEXGET_REAL,
    VIPS_OPERATION_COMPLEXGET_IMAG,
    VIPS_OPERATION_COMPLEXGET_LAST


proc c_vips_invert(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.cdecl, importc: "vips_invert", varargs.}
proc vips_invert*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_invert(input, output, nil)

# Function declarations
{.push cdecl, importc, header: "vips/arithmetic.h".}
proc vips_add*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_sum*(input: ptr ptr VipsImage, res: ptr ptr VipsImage, n: cint): cint
proc vips_subtract*(in1: ptr VipsImage, in2: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_multiply*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_divide*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_linear*(input: ptr VipsImage, res: ptr ptr VipsImage, a: ptr cdouble, b: ptr cdouble, n: cint): cint
proc vips_linear1*(input: ptr VipsImage, res: ptr ptr VipsImage, a: cdouble, b: cdouble): cint
proc vips_remainder*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_remainder_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_remainder_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
# proc vips_invert*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_abs*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_sign*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_clamp*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_maxpair*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_minpair*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_round*(input: ptr VipsImage, res: ptr ptr VipsImage, round: VipsOperationRound): cint
proc vips_floor*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_ceil*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_rint*(input: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_math*(input: ptr VipsImage, res: ptr ptr VipsImage, math: VipsOperationMath): cint
proc vips_sin*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_cos*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_tan*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_asin*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_acos*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_atan*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_exp*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_exp10*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_log*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_log10*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_sinh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_cosh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_tanh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_asinh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_acosh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_atanh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_complex*(input: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex): cint
proc vips_polar*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_rect*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_conj*(input: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_complex2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex2): cint
proc vips_cross_phase*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_complexget*(input: ptr VipsImage, res: ptr ptr VipsImage, get: VipsOperationComplexget): cint
proc vips_real*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_imag*(input: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_complexform*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_relational*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational): cint
proc vips_equal*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_notequal*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_less*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_lesseq*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_more*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_moreeq*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_relational_const*(input: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational, c: ptr cdouble, n: cint): cint
proc vips_equal_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_notequal_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_less_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_lesseq_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_more_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_moreeq_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_relational_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational, c: cdouble): cint
proc vips_equal_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_notequal_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_less_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_lesseq_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_more_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_moreeq_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint

proc vips_boolean*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint
proc vips_andimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_orimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_eorimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_lshift*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_rshift*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint

proc vips_boolean_const*(input: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean, c: ptr cdouble, n: cint): cint
proc vips_andimage_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_orimage_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_eorimage_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_lshift_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_rshift_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_boolean_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean, c: cdouble): cint
proc vips_andimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_orimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_eorimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_lshift_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_rshift_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint

proc vips_math2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2): cint
proc vips_pow*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_wop*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_atan2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_math2_const*(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: ptr cdouble, n: cint): cint
proc vips_pow_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_wop_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_atan2_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint
proc vips_math2_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: cdouble): cint
proc vips_pow_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_wop_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint
proc vips_atan2_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint

proc vips_avg*(input: ptr VipsImage, res: ptr cdouble): cint
proc vips_deviate*(input: ptr VipsImage, res: ptr cdouble): cint
proc vips_min*(input: ptr VipsImage, res: ptr cdouble): cint
proc vips_max*(input: ptr VipsImage, res: ptr cdouble): cint
proc vips_stats*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_measure*(input: ptr VipsImage, res: ptr ptr VipsImage, h: cint, v: cint): cint
proc vips_find_trim*(input: ptr VipsImage, left: ptr cint, top: ptr cint, width: ptr cint, height: ptr cint): cint
proc vips_getpoint*(input: ptr VipsImage, vector: ptr ptr cdouble, n: ptr cint, x: cint, y: cint): cint
proc vips_hist_find*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_hist_find_ndim*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_hist_find_indexed*(input: ptr VipsImage, index: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_hough_line*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_hough_circle*(input: ptr VipsImage, res: ptr ptr VipsImage): cint
proc vips_project*(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint
proc vips_profile*(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint
{.pop.}