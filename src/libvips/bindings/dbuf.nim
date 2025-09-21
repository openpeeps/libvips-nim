# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

type
  VipsDbuf* = object
    ## All fields are private.
    data*: ptr uint8
    allocated_size*: csize
    data_size*: csize
    write_point*: csize

# Function declarations
proc vips_dbuf_init*(dbuf: ptr VipsDbuf) {.cdecl, importc.}
proc vips_dbuf_minimum_size*(dbuf: ptr VipsDbuf, size: csize): cint {.cdecl, importc.}
proc vips_dbuf_allocate*(dbuf: ptr VipsDbuf, size: csize): cint {.cdecl, importc.}
proc vips_dbuf_read*(dbuf: ptr VipsDbuf, data: ptr uint8, size: csize): csize {.cdecl, importc.}
proc vips_dbuf_get_write*(dbuf: ptr VipsDbuf, size: ptr csize): ptr uint8 {.cdecl, importc.}
proc vips_dbuf_write*(dbuf: ptr VipsDbuf, data: ptr uint8, size: csize): cint {.cdecl, importc.}
proc vips_dbuf_writef*(dbuf: ptr VipsDbuf, fmt: cstring): cint {.varargs, cdecl, importc.}
proc vips_dbuf_write_amp*(dbuf: ptr VipsDbuf, str: cstring): cint {.cdecl, importc.}
proc vips_dbuf_reset*(dbuf: ptr VipsDbuf) {.cdecl, importc.}
proc vips_dbuf_destroy*(dbuf: ptr VipsDbuf) {.cdecl, importc.}
proc vips_dbuf_seek*(dbuf: ptr VipsDbuf, offset: coff_t, whence: cint): cint {.cdecl, importc.}
proc vips_dbuf_truncate*(dbuf: ptr VipsDbuf) {.cdecl, importc.}
proc vips_dbuf_tell*(dbuf: ptr VipsDbuf): coff_t {.cdecl, importc.}
proc vips_dbuf_string*(dbuf: ptr VipsDbuf, size: ptr csize): ptr uint8 {.cdecl, importc.}
proc vips_dbuf_steal*(dbuf: ptr VipsDbuf, size: ptr csize): ptr uint8 {.cdecl, importc.}