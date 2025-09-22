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


# Function declarations
{.push cdecl, header: "vips/arithmetic.h".}
proc c_vips_add(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_add", varargs.}
proc c_vips_sum(input: ptr ptr VipsImage, res: ptr ptr VipsImage, n: cint): cint {.importc: "vips_sum", varargs.}
proc c_vips_subtract(in1: ptr VipsImage, in2: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_subtract", varargs.}
proc c_vips_multiply(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_multiply", varargs.}
proc c_vips_divide(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_divide", varargs.}
proc c_vips_linear(input: ptr VipsImage, res: ptr ptr VipsImage, a: ptr cdouble, b: ptr cdouble, n: cint): cint {.importc: "vips_linear", varargs.}
proc c_vips_linear1(input: ptr VipsImage, res: ptr ptr VipsImage, a: cdouble, b: cdouble): cint {.importc: "vips_linear1", varargs.}
proc c_vips_remainder(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_remainder", varargs.}
proc c_vips_remainder_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_remainder_const", varargs.}
proc c_vips_remainder_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_remainder_const1", varargs.}
proc c_vips_abs(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_abs", varargs.}
proc c_vips_sign(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_sign", varargs.}
proc c_vips_clamp(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_clamp", varargs.}
proc c_vips_maxpair(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_maxpair", varargs.}
proc c_vips_minpair(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_minpair", varargs.}
proc c_vips_round(input: ptr VipsImage, res: ptr ptr VipsImage, round: VipsOperationRound): cint {.importc: "vips_round", varargs.}
proc c_vips_floor(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_floor", varargs.}
proc c_vips_ceil(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_ceil", varargs.}
proc c_vips_rint(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_rint", varargs.}

proc c_vips_invert(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.cdecl, importc: "vips_invert", varargs.}
proc c_vips_math(input: ptr VipsImage, res: ptr ptr VipsImage, math: VipsOperationMath): cint {.importc: "vips_math", varargs.}
proc c_vips_sin(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_sin", varargs.}
proc c_vips_cos(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_cos", varargs.}
proc c_vips_tan(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_tan", varargs.}
proc c_vips_asin(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_asin", varargs.}
proc c_vips_acos(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_acos", varargs.}
proc c_vips_atan(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_atan", varargs.}
proc c_vips_exp(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_exp", varargs.}
proc c_vips_exp10(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_exp10", varargs.}
proc c_vips_log(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_log", varargs.}
proc c_vips_log10(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_log10", varargs.}
proc c_vips_sinh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_sinh", varargs.}
proc c_vips_cosh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_cosh", varargs.}
proc c_vips_tanh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_tanh", varargs.}
proc c_vips_asinh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_asinh", varargs.}
proc c_vips_acosh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_acosh", varargs.}
proc c_vips_atanh(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_atanh", varargs.}

proc c_vips_complex(input: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex): cint {.importc: "vips_complex", varargs.}
proc c_vips_polar(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_polar", varargs.}
proc c_vips_rect(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_rect", varargs.}
proc c_vips_conj(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_conj", varargs.}

proc c_vips_complex2(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex2): cint {.importc: "vips_complex2", varargs.}
proc c_vips_cross_phase(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_cross_phase", varargs.}

proc c_vips_complexget(input: ptr VipsImage, res: ptr ptr VipsImage, get: VipsOperationComplexget): cint {.importc: "vips_complexget", varargs.}
proc c_vips_real(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_real", varargs.}
proc c_vips_imag(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_imag", varargs.}

proc c_vips_complexform(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_complexform", varargs.}

proc c_vips_relational(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational): cint {.importc: "vips_relational", varargs.}
proc c_vips_equal(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_equal", varargs.}
proc c_vips_notequal(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_notequal", varargs.}
proc c_vips_less(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_less", varargs.}
proc c_vips_lesseq(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_lesseq", varargs.}
proc c_vips_more(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_more", varargs.}
proc c_vips_moreeq(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_moreeq", varargs.}
proc c_vips_relational_const(input: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational, c: ptr cdouble, n: cint): cint {.importc: "vips_relational_const", varargs.}
proc c_vips_equal_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_equal_const", varargs.}
proc c_vips_notequal_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_notequal_const", varargs.}
proc c_vips_less_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_less_const", varargs.}
proc c_vips_lesseq_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_lesseq_const", varargs.}
proc c_vips_more_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_more_const", varargs.}
proc c_vips_moreeq_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_moreeq_const", varargs.}
proc c_vips_relational_const1(input: ptr VipsImage, res: ptr ptr VipsImage, relational: VipsOperationRelational, c: cdouble): cint {.importc: "vips_relational_const1", varargs.}
proc c_vips_equal_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_equal_const1", varargs.}
proc c_vips_notequal_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_notequal_const1", varargs.}
proc c_vips_less_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_less_const1", varargs.}
proc c_vips_lesseq_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_lesseq_const1", varargs.}
proc c_vips_more_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_more_const1", varargs.}
proc c_vips_moreeq_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_moreeq_const1", varargs.}

proc c_vips_boolean(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint {.importc: "vips_boolean", varargs.}
proc c_vips_andimage(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_andimage", varargs.}
proc c_vips_orimage(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_orimage", varargs.}
proc c_vips_eorimage(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_eorimage", varargs.}
proc c_vips_lshift(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_lshift", varargs.}
proc c_vips_rshift(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_rshift", varargs.}

proc c_vips_boolean_const(input: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean, c: ptr cdouble, n: cint): cint {.importc: "vips_boolean_const", varargs.}
proc c_vips_andimage_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_andimage_const", varargs.}
proc c_vips_orimage_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_orimage_const", varargs.}
proc c_vips_eorimage_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_eorimage_const", varargs.}
proc c_vips_lshift_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_lshift_const", varargs.}
proc c_vips_rshift_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_rshift_const", varargs.}
proc c_vips_boolean_const1(input: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean, c: cdouble): cint {.importc: "vips_boolean_const1", varargs.}
proc c_vips_andimage_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_andimage_const1", varargs.}
proc c_vips_orimage_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_orimage_const1", varargs.}
proc c_vips_eorimage_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_eorimage_const1", varargs.}
proc c_vips_lshift_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_lshift_const1", varargs.}
proc c_vips_rshift_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_rshift_const1", varargs.}

proc c_vips_math2(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2): cint {.importc: "vips_math2", varargs.}
proc c_vips_pow(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_pow", varargs.}
proc c_vips_wop(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_wop", varargs.}
proc c_vips_atan2(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_atan2", varargs.}
proc c_vips_math2_const(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: ptr cdouble, n: cint): cint {.importc: "vips_math2_const", varargs.}
proc c_vips_pow_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_pow_const", varargs.}
proc c_vips_wop_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_wop_const", varargs.}
proc c_vips_atan2_const(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint {.importc: "vips_atan2_const", varargs.}
proc c_vips_math2_const1(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: cdouble): cint {.importc: "vips_math2_const1", varargs.}
proc c_vips_pow_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_pow_const1", varargs.}
proc c_vips_wop_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_wop_const1", varargs.}
proc c_vips_atan2_const1(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint {.importc: "vips_atan2_const1", varargs.}

proc c_vips_avg(input: ptr VipsImage, res: ptr cdouble): cint {.importc: "vips_avg", varargs.}
proc c_vips_deviate(input: ptr VipsImage, res: ptr cdouble): cint {.importc: "vips_deviate", varargs.}
proc c_vips_min(input: ptr VipsImage, res: ptr cdouble): cint {.importc: "vips_min", varargs.}
proc c_vips_max(input: ptr VipsImage, res: ptr cdouble): cint {.importc: "vips_max", varargs.}
proc c_vips_stats(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_stats", varargs.}
proc c_vips_measure(input: ptr VipsImage, res: ptr ptr VipsImage, h: cint, v: cint): cint {.importc: "vips_measure", varargs.}
proc c_vips_find_trim(input: ptr VipsImage, left: ptr cint, top: ptr cint, width: ptr cint, height: ptr cint): cint {.importc: "vips_find_trim", varargs.}
proc c_vips_getpoint(input: ptr VipsImage, vector: ptr ptr cdouble, n: ptr cint, x: cint, y: cint): cint {.importc: "vips_getpoint", varargs.}
proc c_vips_hist_find(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_hist_find", varargs.}
proc c_vips_hist_find_ndim(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_hist_find_ndim", varargs.}
proc c_vips_hist_find_indexed(input: ptr VipsImage, index: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_hist_find_indexed", varargs.}
proc c_vips_hough_line(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_hough_line", varargs.}
proc c_vips_hough_circle(input: ptr VipsImage, res: ptr ptr VipsImage): cint {.importc: "vips_hough_circle", varargs.}
proc c_vips_project(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint {.importc: "vips_project", varargs.}
proc c_vips_profile(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint {.importc: "vips_profile", varargs.}
{.pop.}


# safe wrappers
proc vips_add*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_add(left, right, res, nil)
proc vips_sum*(input: ptr ptr VipsImage, res: ptr ptr VipsImage, n: cint): cint =
  c_vips_sum(input, res, n, nil)
proc vips_subtract*(in1: ptr VipsImage, in2: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_subtract(in1, in2, res, nil)
proc vips_multiply*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_multiply(left, right, res, nil)
proc vips_divide*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_divide(left, right, res, nil)
proc vips_linear*(input: ptr VipsImage, res: ptr ptr VipsImage, a: ptr cdouble, b: ptr cdouble, n: cint): cint =
  c_vips_linear(input, res, a, b, n, nil)
proc vips_linear1*(input: ptr VipsImage, res: ptr ptr VipsImage, a: cdouble, b: cdouble): cint =
  c_vips_linear1(input, res, a, b, nil)
proc vips_remainder*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_remainder(left, right, res, nil)
proc vips_remainder_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_remainder_const(input, res, c, n, nil)
proc vips_remainder_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_remainder_const1(input, res, c, nil)
proc vips_abs*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_abs(input, res, nil)
proc vips_sign*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_sign(input, res, nil)
proc vips_clamp*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_clamp(input, res, nil)
proc vips_maxpair*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_maxpair(left, right, res, nil)
proc vips_minpair*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_minpair(left, right, res, nil)
proc vips_round*(input: ptr VipsImage, res: ptr ptr VipsImage, round: VipsOperationRound): cint =
  c_vips_round(input, res, round, nil)
proc vips_floor*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_floor(input, res, nil)
proc vips_ceil*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_ceil(input, res, nil)
proc vips_rint*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_rint(input, res, nil)
proc vips_invert*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_invert(input, output, nil)
proc vips_math*(input: ptr VipsImage, res: ptr ptr VipsImage, math: VipsOperationMath): cint =
  c_vips_math(input, res, math, nil)
proc vips_sin*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_sin(input, res, nil)
proc vips_cos*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_cos(input, res, nil)
proc vips_tan*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_tan(input, res, nil)
proc vips_asin*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_asin(input, res, nil)
proc vips_acos*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_acos(input, res, nil)
proc vips_atan*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_atan(input, res, nil)
proc vips_exp*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_exp(input, res, nil)
proc vips_exp10*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_exp10(input, res, nil)
proc vips_log*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_log(input, res, nil)
proc vips_log10*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_log10(input, res, nil)
proc vips_sinh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_sinh(input, res, nil)
proc vips_cosh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_cosh(input, res, nil)
proc vips_tanh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_tanh(input, res, nil)
proc vips_asinh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_asinh(input, res, nil)
proc vips_acosh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_acosh(input, res, nil)
proc vips_atanh*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_atanh(input, res, nil)
proc vips_complex*(input: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex): cint =
  c_vips_complex(input, res, cmplx, nil)
proc vips_polar*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_polar(input, res, nil)
proc vips_rect*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_rect(input, res, nil)
proc vips_conj*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_conj(input, res, nil)
proc vips_complex2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, cmplx: VipsOperationComplex2): cint =
  c_vips_complex2(left, right, res, cmplx, nil)
proc vips_cross_phase*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_cross_phase(left, right, res, nil)
proc vips_complexget*(input: ptr VipsImage, res: ptr ptr VipsImage, get: VipsOperationComplexget): cint =
  c_vips_complexget(input, res, get, nil)
proc vips_real*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_real(input, res, nil)
proc vips_imag*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_imag(input, res, nil)
proc vips_complexform*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_complexform(left, right, res, nil)
proc vips_equal*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_equal(left, right, res, nil)
proc vips_notequal*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_notequal(left, right, res, nil)
proc vips_less*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_less(left, right, res, nil)
proc vips_lesseq*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_lesseq(left, right, res, nil)
proc vips_more*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_more(left, right, res, nil)
proc vips_moreeq*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_moreeq(left, right, res, nil)
proc vips_equal_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_equal_const(input, res, c, n, nil)
proc vips_notequal_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_notequal_const(input, res, c, n, nil)
proc vips_less_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_less_const(input, res, c, n, nil)
proc vips_lesseq_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_lesseq_const(input, res, c, n, nil)
proc vips_more_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_more_const(input, res, c, n, nil)
proc vips_moreeq_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_moreeq_const(input, res, c, n, nil)
proc vips_notequal_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_notequal_const1(input, res, c, nil)
proc vips_less_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_less_const1(input, res, c, nil)
proc vips_lesseq_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_lesseq_const1(input, res, c, nil)
proc vips_more_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_more_const1(input, res, c, nil)
proc vips_moreeq_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_moreeq_const1(input, res, c, nil)
proc vips_boolean*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean): cint =
  c_vips_boolean(left, right, res, boolean, nil)
proc vips_andimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_andimage(left, right, res, nil)
proc vips_orimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_orimage(left, right, res, nil)
proc vips_eorimage*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_eorimage(left, right, res, nil)
proc vips_lshift*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_lshift(left, right, res, nil)
proc vips_rshift*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_rshift(left, right, res, nil)
proc vips_orimage_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_orimage_const(input, res, c, n, nil)
proc vips_eorimage_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_eorimage_const(input, res, c, n, nil)
proc vips_lshift_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_lshift_const(input, res, c, n, nil)
proc vips_rshift_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_rshift_const(input, res, c, n, nil)
proc vips_boolean_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, boolean: VipsOperationBoolean, c: cdouble): cint =
  c_vips_boolean_const1(input, res, boolean, c, nil)
proc vips_andimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_andimage_const1(input, res, c, nil)
proc vips_orimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_orimage_const1(input, res, c, nil)
proc vips_eorimage_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_eorimage_const1(input, res, c, nil)
proc vips_lshift_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_lshift_const1(input, res, c, nil)
proc vips_rshift_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_rshift_const1(input, res, c, nil)
proc vips_math2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2): cint =
  c_vips_math2(left, right, res, math2, nil)
proc vips_pow*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_pow(left, right, res, nil)
proc vips_wop*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_wop(left, right, res, nil)
proc vips_atan2*(left: ptr VipsImage, right: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_atan2(left, right, res, nil)
proc vips_math2_const*(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: ptr cdouble, n: cint): cint =
  c_vips_math2_const(input, res, math2, c, n, nil)
proc vips_pow_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_pow_const(input, res, c, n, nil)
proc vips_wop_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_wop_const(input, res, c, n, nil)
proc vips_atan2_const*(input: ptr VipsImage, res: ptr ptr VipsImage, c: ptr cdouble, n: cint): cint =
  c_vips_atan2_const(input, res, c, n, nil)
proc vips_math2_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, math2: VipsOperationMath2, c: cdouble): cint =
  c_vips_math2_const1(input, res, math2, c, nil)
proc vips_pow_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_pow_const1(input, res, c, nil)
proc vips_wop_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_wop_const1(input, res, c, nil)
proc vips_atan2_const1*(input: ptr VipsImage, res: ptr ptr VipsImage, c: cdouble): cint =
  c_vips_atan2_const1(input, res, c, nil)
proc vips_avg*(input: ptr VipsImage, res: ptr cdouble): cint =
  c_vips_avg(input, res, nil)
proc vips_deviate*(input: ptr VipsImage, res: ptr cdouble): cint =
  c_vips_deviate(input, res, nil)
proc vips_min*(input: ptr VipsImage, res: ptr cdouble): cint =
  c_vips_min(input, res, nil)
proc vips_max*(input: ptr VipsImage, res: ptr cdouble): cint =
  c_vips_max(input, res, nil)
proc vips_stats*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_stats(input, res, nil)
proc vips_measure*(input: ptr VipsImage, res: ptr ptr VipsImage, h: cint, v: cint): cint =
  c_vips_measure(input, res, h, v, nil)
proc vips_find_trim*(input: ptr VipsImage, left: ptr cint, top: ptr cint, width: ptr cint, height: ptr cint): cint =
  c_vips_find_trim(input, left, top, width, height, nil)
proc vips_getpoint*(input: ptr VipsImage, vector: ptr ptr cdouble, n: ptr cint, x: cint, y: cint): cint =
  c_vips_getpoint(input, vector, n, x, y, nil)
proc vips_hist_find*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_hist_find(input, res, nil)
proc vips_hist_find_ndim*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_hist_find_ndim(input, res, nil)
proc vips_hist_find_indexed*(input: ptr VipsImage, index: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_hist_find_indexed(input, index, res, nil)
proc vips_hough_line*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_hough_line(input, res, nil)
proc vips_hough_circle*(input: ptr VipsImage, res: ptr ptr VipsImage): cint =
  c_vips_hough_circle(input, res, nil)
proc vips_project*(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint =
  c_vips_project(input, columns, rows, nil)
proc vips_profile*(input: ptr VipsImage, columns: ptr ptr VipsImage, rows: ptr ptr VipsImage): cint =
  c_vips_profile(input, columns, rows, nil)