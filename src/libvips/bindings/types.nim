# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./basic

type
  GType* = culong      # GLib's GType is usually an unsigned long
  GMutex* = object     # Opaque struct, size depends on platform
    dummy: array[8, byte] # 8 bytes is typical for pthread mutex on most platforms
  GValue* = object
    dummy: array[24, byte] # GLib's GValue is typically 24 bytes on 64-bit platforms
  GObject* = object

  gboolean* = cint
  guint64* = uint64
  guint32* = uint32

  VipsThing* = object
    i*: cint

  VipsArea* = object
    data*: pointer
    length*: csize_t
    n*: cint
    count*: cint
    lock*: ptr GMutex
    free_fn*: VipsCallbackFn
    client*: pointer
    typ*: GType
    sizeof_type*: csize_t

  VipsSaveString* = object
    s*: cstring

  VipsRefString* = object
    area*: VipsArea

  VipsBlob* = object
    area*: VipsArea

  VipsArrayDouble* = object
    area*: VipsArea

  VipsArrayInt* = object
    area*: VipsArea

  VipsArrayImage* = object
    area*: VipsArea

{.push cdecl, importc, header: "vips/types.h".}
# Function declarations
proc vips_thing_get_type*(): GType
proc vips_thing_new*(i: cint): ptr VipsThing

proc vips_area_copy*(area: ptr VipsArea): ptr VipsArea
proc vips_area_free_cb*(mem: pointer, area: ptr VipsArea): cint
proc vips_area_unref*(area: ptr VipsArea)
proc vips_area_new*(free_fn: VipsCallbackFn, data: pointer): ptr VipsArea
proc vips_area_new_array*(typ: GType, sizeof_type: csize_t, n: cint): ptr VipsArea
proc vips_area_new_array_object*(n: cint): ptr VipsArea
proc vips_area_get_data*(area: ptr VipsArea, length: ptr csize_t, n: ptr cint, typ: ptr GType, sizeof_type: ptr csize_t): pointer

proc vips_blob_new*(free_fn: VipsCallbackFn, data: pointer, length: csize_t): ptr VipsBlob
proc vips_blob_copy*(data: pointer, length: csize_t): ptr VipsBlob
proc vips_blob_get*(blob: ptr VipsBlob, length: ptr csize_t): pointer
proc vips_blob_set*(blob: ptr VipsBlob, free_fn: VipsCallbackFn, data: pointer, length: csize_t)
proc vips_blob_get_type*(): GType

proc vips_array_double_new*(array: ptr cdouble, n: cint): ptr VipsArrayDouble
proc vips_array_double_newv*(n: cint): ptr VipsArrayDouble {.varargs, cdecl, importc.}
proc vips_array_double_get*(array: ptr VipsArrayDouble, n: ptr cint): ptr cdouble
proc vips_array_double_get_type*(): GType

proc vips_array_int_new*(array: ptr cint, n: cint): ptr VipsArrayInt
proc vips_array_int_newv*(n: cint): ptr VipsArrayInt {.varargs, cdecl, importc.}
proc vips_array_int_get*(array: ptr VipsArrayInt, n: ptr cint): ptr cint
proc vips_array_int_get_type*(): GType

proc vips_array_image_get_type*(): GType

proc vips_ref_string_new*(str: cstring): ptr VipsRefString
proc vips_ref_string_get*(refstr: ptr VipsRefString, length: ptr csize_t): cstring
proc vips_ref_string_get_type*(): GType

proc vips_save_string_get_type*(): GType

proc vips_value_set_area*(value: ptr GValue, free_fn: VipsCallbackFn, data: pointer)
proc vips_value_get_area*(value: ptr GValue, length: ptr csize_t): pointer
proc vips_value_get_save_string*(value: ptr GValue): cstring
proc vips_value_set_save_string*(value: ptr GValue, str: cstring)
proc vips_value_set_save_stringf*(value: ptr GValue, fmt: cstring): void {.varargs, cdecl, importc.}
proc vips_value_get_ref_string*(value: ptr GValue, length: ptr csize_t): cstring
proc vips_value_set_ref_string*(value: ptr GValue, str: cstring)
proc vips_value_get_blob*(value: ptr GValue, length: ptr csize_t): pointer
proc vips_value_set_blob*(value: ptr GValue, free_fn: VipsCallbackFn, data: pointer, length: csize_t)
proc vips_value_set_blob_free*(value: ptr GValue, data: pointer, length: csize_t)
proc vips_value_set_array*(value: ptr GValue, n: cint, typ: GType, sizeof_type: csize_t)
proc vips_value_get_array*(value: ptr GValue, n: ptr cint, typ: ptr GType, sizeof_type: ptr csize_t): pointer
proc vips_value_get_array_double*(value: ptr GValue, n: ptr cint): ptr cdouble
proc vips_value_set_array_double*(value: ptr GValue, array: ptr cdouble, n: cint)
proc vips_value_get_array_int*(value: ptr GValue, n: ptr cint): ptr cint
proc vips_value_set_array_int*(value: ptr GValue, array: ptr cint, n: cint)
proc vips_value_get_array_object*(value: ptr GValue, n: ptr cint): ptr ptr GObject
proc vips_value_set_array_object*(value: ptr GValue, n: cint)
{.pop.}

# Macro constants for GTypes
# let
#   VIPS_TYPE_THING* = vips_thing_get_type()
#   VIPS_TYPE_AREA* = vips_area_get_type()
#   VIPS_TYPE_SAVE_STRING* = vips_save_string_get_type()
#   VIPS_TYPE_REF_STRING* = vips_ref_string_get_type()
#   VIPS_TYPE_BLOB* = vips_blob_get_type()
#   VIPS_TYPE_ARRAY_DOUBLE* = vips_array_double_get_type()
#   VIPS_TYPE_ARRAY_INT* = vips_array_int_get_type()
#   VIPS_TYPE_ARRAY_IMAGE* = vips_array_image_get_type()