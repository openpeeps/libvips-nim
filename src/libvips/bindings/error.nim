# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

{.push cdecl, importc, header: "vips/error.h".}
proc vips_error_buffer*(): cstring
proc vips_error_buffer_copy*(): cstring
proc vips_error_clear*()

proc vips_error_freeze*()
proc vips_error_thaw*()

proc vips_error*(domain: cstring, fmt: cstring)
proc vips_verror*(domain: cstring, fmt: cstring, ap: pointer)
proc vips_error_system*(err: int, domain: cstring, fmt: cstring)
proc vips_verror_system*(err: int, domain: cstring, fmt: cstring, ap: pointer)
proc vips_error_g*(error: pointer)
proc vips_g_error*(error: pointer)

proc vips_error_exit*(fmt: cstring) {.importc, cdecl, noreturn, varargs.}

proc vips_check_uncoded*(domain: cstring, im: pointer): int
proc vips_check_coding*(domain: cstring, im: pointer, coding: int): int
proc vips_check_coding_known*(domain: cstring, im: pointer): int
proc vips_check_coding_noneorlabq*(domain: cstring, im: pointer): int
proc vips_check_coding_same*(domain: cstring, im1: pointer, im2: pointer): int
proc vips_check_mono*(domain: cstring, im: pointer): int
proc vips_check_bands*(domain: cstring, im: pointer, bands: int): int
proc vips_check_bands_1or3*(domain: cstring, im: pointer): int
proc vips_check_bands_atleast*(domain: cstring, im: pointer, bands: int): int
proc vips_check_bands_1orn*(domain: cstring, im1: pointer, im2: pointer): int
proc vips_check_bands_1orn_unary*(domain: cstring, im: pointer, n: int): int
proc vips_check_bands_same*(domain: cstring, im1: pointer, im2: pointer): int
proc vips_check_bandno*(domain: cstring, im: pointer, bandno: int): int

proc vips_check_int*(domain: cstring, im: pointer): int
proc vips_check_uint*(domain: cstring, im: pointer): int
proc vips_check_uintorf*(domain: cstring, im: pointer): int
proc vips_check_noncomplex*(domain: cstring, im: pointer): int
proc vips_check_complex*(domain: cstring, im: pointer): int
proc vips_check_twocomponents*(domain: cstring, im: pointer): int
proc vips_check_format*(domain: cstring, im: pointer, fmt: int): int
proc vips_check_u8or16*(domain: cstring, im: pointer): int
proc vips_check_8or16*(domain: cstring, im: pointer): int
proc vips_check_u8or16orf*(domain: cstring, im: pointer): int
proc vips_check_format_same*(domain: cstring, im1: pointer, im2: pointer): int
proc vips_check_size_same*(domain: cstring, im1: pointer, im2: pointer): int
proc vips_check_oddsquare*(domain: cstring, im: pointer): int
proc vips_check_vector_length*(domain: cstring, n: int, len: int): int
proc vips_check_vector*(domain: cstring, n: int, im: pointer): int
proc vips_check_hist*(domain: cstring, im: pointer): int
proc vips_check_matrix*(domain: cstring, im: pointer, `out`: ptr pointer): int
proc vips_check_separable*(domain: cstring, im: pointer): int

proc vips_check_precision_intfloat*(domain: cstring, precision: int): int
{.pop.}