import ./types, ./glib/glib

type
  VipsBuf* = object
    # All fields are private in C, but exposed here for FFI.
    base*: cstring
    mx*: cint
    i*: cint
    full*: gboolean
    lasti*: cint
    dynamic*: gboolean

# Macro VIPS_BUF_STATIC(TEXT) not directly translatable; use Nim's static array if needed.

{.push cdecl, importc, header: "vips/buf.h".}
proc vips_buf_rewind*(buf: ptr VipsBuf)
proc vips_buf_destroy*(buf: ptr VipsBuf)
proc vips_buf_init*(buf: ptr VipsBuf)
proc vips_buf_set_static*(buf: ptr VipsBuf, base: cstring, mx: cint)
proc vips_buf_set_dynamic*(buf: ptr VipsBuf, mx: cint)
proc vips_buf_init_static*(buf: ptr VipsBuf, base: cstring, mx: cint)
proc vips_buf_init_dynamic*(buf: ptr VipsBuf, mx: cint)
proc vips_buf_appendns*(buf: ptr VipsBuf, str: cstring, sz: cint): gboolean
proc vips_buf_appends*(buf: ptr VipsBuf, str: cstring): gboolean
proc vips_buf_vappendf*(buf: ptr VipsBuf, fmt: cstring, ap: va_list): gboolean
proc vips_buf_appendc*(buf: ptr VipsBuf, ch: char): gboolean
proc vips_buf_appendgv*(buf: ptr VipsBuf, value: ptr GValue): gboolean
proc vips_buf_append_size*(buf: ptr VipsBuf, n: csize_t): gboolean
proc vips_buf_removec*(buf: ptr VipsBuf, ch: char): gboolean
proc vips_buf_change*(buf: ptr VipsBuf, o: cstring, n: cstring): gboolean
proc vips_buf_is_empty*(buf: ptr VipsBuf): gboolean
proc vips_buf_is_full*(buf: ptr VipsBuf): gboolean
proc vips_buf_all*(buf: ptr VipsBuf): cstring
proc vips_buf_firstline*(buf: ptr VipsBuf): cstring
proc vips_buf_appendg*(buf: ptr VipsBuf, g: cdouble): gboolean
proc vips_buf_appendd*(buf: ptr VipsBuf, d: cint): gboolean
proc vips_buf_len*(buf: ptr VipsBuf): cint
{.pop.}

proc vips_buf_appendf*(buf: ptr VipsBuf,
      fmt: cstring): gboolean {.cdecl, importc: "c_vips_buf_appendf", header: "vips/buf.h", varargs.}