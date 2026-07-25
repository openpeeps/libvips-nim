# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import strutils, os, macros
import ./basic, ./types, ./object

{.pragma: cdecl, cdecl.}
{.pragma: importc, importc.}
{.passL: "-lvips".}

type
  GType* = culong
  # gboolean* = cint
  gint64* = int64
  # size_t* = culong
  VipsObjectClass* = object
  GByteArray* = object
  GString* = object
  GInputStream* = object
  GInputStreamClass* = object
  GSeekable* = object
  GFileInfo* = object

  VipsConnection* = object
    parent_object*: VipsObject
    descriptor*: cint
    tracked_descriptor*: cint
    close_descriptor*: cint
    filename*: cstring

  VipsConnectionClass* = object
    parent_class*: VipsObjectClass

  VipsSource* = object
    parent_object*: VipsConnection
    decode*: gboolean
    have_tested_seek*: gboolean
    is_pipe*: gboolean
    read_position*: gint64
    length*: gint64
    data*: pointer
    header_bytes*: ptr GByteArray
    sniff*: ptr GByteArray
    blob*: ptr VipsBlob
    mmap_baseaddr*: pointer
    mmap_length*: size_t

  VipsSourceClass* = object
    parent_class*: VipsConnectionClass
    read*: proc(self: ptr VipsSource, buf: pointer, len: size_t): gint64 {.cdecl.}
    seek*: proc(self: ptr VipsSource, offset: gint64, whence: cint): gint64 {.cdecl.}

  VipsSourceCustom* = object
    parent_object*: VipsSource

  VipsSourceCustomClass* = object
    parent_class*: VipsSourceClass
    read*: proc(self: ptr VipsSourceCustom, buf: pointer, len: gint64): gint64 {.cdecl.}
    seek*: proc(self: ptr VipsSourceCustom, offset: gint64, whence: cint): gint64 {.cdecl.}

  VipsGInputStream* = object
    parent_instance*: GInputStream
    source*: ptr VipsSource

  VipsGInputStreamClass* = object
    parent_class*: GInputStreamClass

  VipsSourceGInputStream* = object
    parent_instance*: VipsSource
    stream*: ptr GInputStream
    seekable*: ptr GSeekable
    info*: ptr GFileInfo

  VipsSourceGInputStreamClass* = object
    parent_class*: VipsSourceClass

  VipsTarget* = object
    parent_object*: VipsConnection
    memory*: gboolean
    ended*: gboolean
    memory_buffer*: ptr GString
    blob*: ptr VipsBlob
    output_buffer*: array[0..8499, cuchar]
    write_point*: cint
    position*: gint64
    delete_on_close*: gboolean
    delete_on_close_filename*: cstring

  VipsTargetClass* = object
    parent_class*: VipsConnectionClass
    write*: proc(self: ptr VipsTarget, data: pointer, len: size_t): gint64 {.cdecl.}
    finish*: proc(self: ptr VipsTarget) {.cdecl.}
    read*: proc(self: ptr VipsTarget, buf: pointer, len: size_t): gint64 {.cdecl.}
    seek*: proc(self: ptr VipsTarget, offset: gint64, whence: cint): gint64 {.cdecl.}
    end*: proc(self: ptr VipsTarget): cint {.cdecl.}

  VipsTargetCustom* = object
    parent_object*: VipsTarget

  VipsTargetCustomClass* = object
    parent_class*: VipsTargetClass
    write*: proc(self: ptr VipsTargetCustom, data: pointer, len: gint64): gint64 {.cdecl.}
    finish*: proc(self: ptr VipsTargetCustom) {.cdecl.}
    read*: proc(self: ptr VipsTargetCustom, buf: pointer, len: gint64): gint64 {.cdecl.}
    seek*: proc(self: ptr VipsTargetCustom, offset: gint64, whence: cint): gint64 {.cdecl.}
    end*: proc(self: ptr VipsTargetCustom): cint {.cdecl.}

# Constants
const
  VIPS_TARGET_BUFFER_SIZE* = 8500
  VIPS_TARGET_CUSTOM_BUFFER_SIZE* = 4096

# Function bindings
proc vips_connection_get_type*(): GType {.importc, cdecl.}
proc vips_connection_filename*(connection: ptr VipsConnection): cstring {.importc, cdecl.}
proc vips_connection_nick*(connection: ptr VipsConnection): cstring {.importc, cdecl.}
proc vips_pipe_read_limit_set*(limit: gint64) {.importc, cdecl.}

proc vips_source_get_type*(): GType {.importc, cdecl.}
proc vips_source_new_from_descriptor*(descriptor: cint): ptr VipsSource {.importc, cdecl.}
proc vips_source_new_from_file*(filename: cstring): ptr VipsSource {.importc, cdecl.}
proc vips_source_new_from_blob*(blob: ptr VipsBlob): ptr VipsSource {.importc, cdecl.}
proc vips_source_new_from_target*(target: ptr VipsTarget): ptr VipsSource {.importc, cdecl.}
proc vips_source_new_from_memory*(data: pointer, size: size_t): ptr VipsSource {.importc, cdecl.}
proc vips_source_new_from_options*(options: cstring): ptr VipsSource {.importc, cdecl.}
proc vips_source_minimise*(source: ptr VipsSource) {.importc, cdecl.}
proc vips_source_unminimise*(source: ptr VipsSource): cint {.importc, cdecl.}
proc vips_source_decode*(source: ptr VipsSource): cint {.importc, cdecl.}
proc vips_source_read*(source: ptr VipsSource, data: pointer, length: size_t): gint64 {.importc, cdecl.}
proc vips_source_is_mappable*(source: ptr VipsSource): gboolean {.importc, cdecl.}
proc vips_source_is_file*(source: ptr VipsSource): gboolean {.importc, cdecl.}
proc vips_source_map*(source: ptr VipsSource, length: ptr size_t): pointer {.importc, cdecl.}
proc vips_source_map_blob*(source: ptr VipsSource): ptr VipsBlob {.importc, cdecl.}
proc vips_source_seek*(source: ptr VipsSource, offset: gint64, whence: cint): gint64 {.importc, cdecl.}
proc vips_source_rewind*(source: ptr VipsSource): cint {.importc, cdecl.}
proc vips_source_sniff_at_most*(source: ptr VipsSource, data: ptr ptr cuchar, length: size_t): gint64 {.importc, cdecl.}
proc vips_source_sniff*(source: ptr VipsSource, length: size_t): ptr cuchar {.importc, cdecl.}
proc vips_source_length*(source: ptr VipsSource): gint64 {.importc, cdecl.}

proc vips_source_custom_get_type*(): GType {.importc, cdecl.}
proc vips_source_custom_new*(): ptr VipsSourceCustom {.importc, cdecl.}

proc vips_g_input_stream_get_type*(): GType {.importc, cdecl.}
proc vips_g_input_stream_new_from_source*(source: ptr VipsSource): ptr GInputStream {.importc, cdecl.}

proc vips_source_g_input_stream_get_type*(): GType {.importc, cdecl.}
proc vips_source_g_input_stream_new*(stream: ptr GInputStream): ptr VipsSourceGInputStream {.importc, cdecl.}

proc vips_target_get_type*(): GType {.importc, cdecl.}
proc vips_target_new_to_descriptor*(descriptor: cint): ptr VipsTarget {.importc, cdecl.}
proc vips_target_new_to_file*(filename: cstring): ptr VipsTarget {.importc, cdecl.}
proc vips_target_new_to_memory*(): ptr VipsTarget {.importc, cdecl.}
proc vips_target_new_temp*(target: ptr VipsTarget): ptr VipsTarget {.importc, cdecl.}
proc vips_target_write*(target: ptr VipsTarget, data: pointer, length: size_t): cint {.importc, cdecl.}
proc vips_target_read*(target: ptr VipsTarget, buffer: pointer, length: size_t): gint64 {.importc, cdecl.}
proc vips_target_seek*(target: ptr VipsTarget, offset: gint64, whence: cint): gint64 {.importc, cdecl.}
proc vips_target_end*(target: ptr VipsTarget): cint {.importc, cdecl.}
proc vips_target_steal*(target: ptr VipsTarget, length: ptr size_t): ptr cuchar {.importc, cdecl.}
proc vips_target_steal_text*(target: ptr VipsTarget): cstring {.importc, cdecl.}
proc vips_target_putc*(target: ptr VipsTarget, ch: cint): cint {.importc, cdecl.}
proc vips_target_writes*(target: ptr VipsTarget, str: cstring): cint {.importc, cdecl.}
proc vips_target_writef*(target: ptr VipsTarget, fmt: cstring): cint {.importc, cdecl, varargs.}
proc vips_target_write_amp*(target: ptr VipsTarget, str: cstring): cint {.importc, cdecl.}

proc vips_target_custom_get_type*(): GType {.importc, cdecl.}
proc vips_target_custom_new*(): ptr VipsTargetCustom {.importc, cdecl.}

# Macros as Nim templates
template VIPS_TARGET_PUTC*(S, C: untyped): untyped =
  (if (S).write_point < VIPS_TARGET_BUFFER_SIZE:
    (S).output_buffer[(S).write_point] = C.cuchar
    inc((S).write_point)
    0
  else:
    vips_target_putc(S, C)
  )

