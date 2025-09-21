# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import math

const
  VIPS_PI* = 3.14159265358979323846
  VIPS_PATH_MAX* = 4096

template VIPS_RAD*(R: float): float = ((R) / 360.0) * 2.0 * VIPS_PI
template VIPS_DEG*(A: float): float = ((A) / (2.0 * VIPS_PI)) * 360.0

template VIPS_MAX*(A, B: untyped): untyped = (if (A) > (B): (A) else: (B))
template VIPS_MIN*(A, B: untyped): untyped = (if (A) < (B): (A) else: (B))
template VIPS_CLIP*(A, V, B: untyped): untyped = VIPS_MAX((A), VIPS_MIN((B), (V)))
template VIPS_ABS*(X: SomeNumber): SomeNumber = (if (X) >= 0: (X) else: -(X))
template VIPS_ROUND_INT*(R: float): int = (if (R) > 0: int((R) + 0.5) else: int((R) - 0.5))
template VIPS_ROUND_UINT*(R: float): int = int((R) + 0.5)
template VIPS_ROUND_DOWN*(N, P: int): int = (N) - ((N) mod (P))
template VIPS_ROUND_UP*(N, P: int): int = VIPS_ROUND_DOWN((N) + (P) - 1, (P))

when defined(gcc) or defined(clang):
  template VIPS_ISNAN*(V: float): bool = isnan(V)
  template VIPS_FLOOR*(V: float): float = floor(V)
  template VIPS_CEIL*(V: float): float = ceil(V)
  template VIPS_RINT*(V: float): float = rint(V)
  template VIPS_ROUND*(V: float): float = round(V)
  template VIPS_FABS*(V: float): float = fabs(V)
  template VIPS_FMAX*(A, B: float): float = max(A, B)
  template VIPS_FMIN*(A, B: float): float = min(A, B)
else:
  template VIPS_ISNAN*(V: float): bool = isnan(V)
  template VIPS_FLOOR*(V: float): float = floor(V)
  template VIPS_CEIL*(V: float): float = ceil(V)
  template VIPS_RINT*(V: float): float = rint(V)
  template VIPS_ROUND*(V: float): float = round(V)
  template VIPS_FABS*(V: float): float = VIPS_ABS(V)
  template VIPS_FMAX*(A, B: float): float = VIPS_MAX(A, B)
  template VIPS_FMIN*(A, B: float): float = VIPS_MIN(A, B)

type
  VipsToken* {.size: sizeof(cint).} = enum
    VIPS_TOKEN_LEFT = 1,
    VIPS_TOKEN_RIGHT,
    VIPS_TOKEN_STRING,
    VIPS_TOKEN_EQUALS,
    VIPS_TOKEN_COMMA

# Function declarations
proc vips_enum_string*(enm: GType, value: cint): cstring {.cdecl, importc.}
proc vips_enum_nick*(enm: GType, value: cint): cstring {.cdecl, importc.}
proc vips_enum_from_nick*(domain: cstring, typ: GType, str: cstring): cint {.cdecl, importc.}
proc vips_flags_from_nick*(domain: cstring, typ: GType, nick: cstring): cint {.cdecl, importc.}

proc vips_slist_equal*(l1, l2: ptr GSList): cint {.cdecl, importc.}
proc vips_slist_map2*(list: ptr GSList, fn: VipsSListMap2Fn, a, b: pointer): pointer {.cdecl, importc.}
proc vips_slist_map2_rev*(list: ptr GSList, fn: VipsSListMap2Fn, a, b: pointer): pointer {.cdecl, importc.}
proc vips_slist_map4*(list: ptr GSList, fn: VipsSListMap4Fn, a, b, c, d: pointer): pointer {.cdecl, importc.}
proc vips_slist_fold2*(list: ptr GSList, start: pointer, fn: VipsSListFold2Fn, a, b: pointer): pointer {.cdecl, importc.}
proc vips_slist_filter*(list: ptr GSList, fn: VipsSListMap2Fn, a, b: pointer): ptr GSList {.cdecl, importc.}
proc vips_slist_free_all*(list: ptr GSList) {.cdecl, importc.}
proc vips_map_equal*(a, b: pointer): pointer {.cdecl, importc.}
proc vips_hash_table_map*(hash: pointer, fn: VipsSListMap2Fn, a, b: pointer): pointer {.cdecl, importc.}

proc vips_iscasepostfix*(a, b: cstring): cint {.cdecl, importc.}
proc vips_isprefix*(a, b: cstring): cint {.cdecl, importc.}
proc vips_break_token*(str: cstring, brk: cstring): cstring {.cdecl, importc.}
proc vips_filename_suffix_match*(path: cstring, suffixes: ptr cstring): cint {.cdecl, importc.}
proc vips_file_length*(fd: cint): gint64 {.cdecl, importc.}
proc vips__write*(fd: cint, buf: pointer, count: csize): cint {.cdecl, importc.}
proc vips__open*(filename: cstring, flags: cint, mode: cint): cint {.cdecl, importc.}
proc vips__open_read*(filename: cstring): cint {.cdecl, importc.}
proc vips__fopen*(filename, mode: cstring): ptr FILE {.cdecl, importc.}
proc vips__file_open_read*(filename, fallback_dir: cstring, text_mode: cint): ptr FILE {.cdecl, importc.}
proc vips__file_open_write*(filename: cstring, text_mode: cint): ptr FILE {.cdecl, importc.}
proc vips__file_read*(fp: ptr FILE, name: cstring, length_out: ptr csize): cstring {.cdecl, importc.}
proc vips__file_read_name*(name, fallback_dir: cstring, length_out: ptr csize): cstring {.cdecl, importc.}
proc vips__file_write*(data: pointer, size, nmemb: csize, stream: ptr FILE): cint {.cdecl, importc.}
proc vips__get_bytes*(filename: cstring, buf: ptr uint8, len: gint64): gint64 {.cdecl, importc.}
proc vips__fgetc*(fp: ptr FILE): cint {.cdecl, importc.}
proc vips__gvalue_ref_string_new*(text: cstring): ptr GValue {.cdecl, importc.}
proc vips__gslist_gvalue_free*(list: ptr GSList) {.cdecl, importc.}
proc vips__gslist_gvalue_copy*(list: ptr GSList): ptr GSList {.cdecl, importc.}
proc vips__gslist_gvalue_merge*(a: ptr GSList, b: ptr GSList): ptr GSList {.cdecl, importc.}
proc vips__gslist_gvalue_get*(list: ptr GSList): cstring {.cdecl, importc.}
proc vips__seek_no_error*(fd: cint, pos: gint64, whence: cint): gint64 {.cdecl, importc.}
proc vips__seek*(fd: cint, pos: gint64, whence: cint): gint64 {.cdecl, importc.}
proc vips__ftruncate*(fd: cint, pos: gint64): cint {.cdecl, importc.}
proc vips_existsf*(name: cstring): cint {.varargs, cdecl, importc.}
proc vips_isdirf*(name: cstring): cint {.varargs, cdecl, importc.}
proc vips_mkdirf*(name: cstring): cint {.varargs, cdecl, importc.}
proc vips_rmdirf*(name: cstring): cint {.varargs, cdecl, importc.}
proc vips_rename*(old_name, new_name: cstring): cint {.cdecl, importc.}
proc vips__token_get*(buffer: cstring, token: ptr VipsToken, str: cstring, size: cint): cstring {.cdecl, importc.}
proc vips__token_must*(buffer: cstring, token: ptr VipsToken, str: cstring, size: cint): cstring {.cdecl, importc.}
proc vips__token_need*(buffer: cstring, need_token: VipsToken, str: cstring, size: cint): cstring {.cdecl, importc.}
proc vips__token_segment*(p: cstring, token: ptr VipsToken, str: cstring, size: cint): cstring {.cdecl, importc.}
proc vips__token_segment_need*(p: cstring, need_token: VipsToken, str: cstring, size: cint): cstring {.cdecl, importc.}
proc vips__find_rightmost_brackets*(p: cstring): cstring {.cdecl, importc.}
proc vips__filename_split8*(name, filename, option_string: cstring) {.cdecl, importc.}
proc vips_ispoweroftwo*(p: cint): cint {.cdecl, importc.}
proc vips_amiMSBfirst*(): cint {.cdecl, importc.}
proc vips__temp_name*(format: cstring): cstring {.cdecl, importc.}
proc vips__change_suffix*(name, out: cstring, mx: cint, new_suff: cstring, olds: ptr cstring, nolds: cint) {.cdecl, importc.}
proc vips_realpath*(path: cstring): cstring {.cdecl, importc.}
proc vips__random*(seed: uint32): uint32 {.cdecl, importc.}
proc vips__random_add*(seed: uint32, value: cint): uint32 {.cdecl, importc.}
proc vips__icc_dir*(): cstring {.cdecl, importc.}
proc vips__windows_prefix*(): cstring {.cdecl, importc.}
proc vips__get_iso8601*(): cstring {.cdecl, importc.}
proc vips_strtod*(str: cstring, out: ptr cdouble): cint {.cdecl, importc.}