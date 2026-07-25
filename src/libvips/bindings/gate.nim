# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

var vips__thread_profile*: cint # gboolean

template VIPS_GATE_START*(NAME: cstring) =
  if vips__thread_profile != 0:
    vips__thread_gate_start(NAME)

template VIPS_GATE_STOP*(NAME: cstring) =
  if vips__thread_profile != 0:
    vips__thread_gate_stop(NAME)

template VIPS_GATE_MALLOC*(SIZE: gint64) =
  if vips__thread_profile != 0:
    vips__thread_malloc_free(SIZE)

template VIPS_GATE_FREE*(SIZE: gint64) =
  if vips__thread_profile != 0:
    vips__thread_malloc_free(-SIZE)

proc vips_profile_set*(profile: cint) {.cdecl, importc.}
proc vips__thread_profile_attach*(thread_name: cstring) {.cdecl, importc.}
proc vips__thread_profile_detach*() {.cdecl, importc.}
proc vips__thread_profile_stop*() {.cdecl, importc.}
proc vips__thread_gate_start*(gate_name: cstring) {.cdecl, importc.}
proc vips__thread_gate_stop*(gate_name: cstring) {.cdecl, importc.}
proc vips__thread_malloc_free*(size: gint64) {.cdecl, importc.}