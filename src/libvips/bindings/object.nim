# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./buf, ./basic

type
  VipsObject* = object
    # ...fields as in C struct...
    parent_instance*: GObject
    constructed*: cint # gboolean
    static_object*: cint # gboolean
    argument_table*: pointer # VipsArgumentTable*
    nickname*: cstring
    description*: cstring
    preclose*: cint # gboolean
    close*: cint # gboolean
    postclose*: cint # gboolean
    local_memory*: csize

  VipsObjectClass* = object
    # ...fields as in C struct...
    parent_class*: GObjectClass
    build*: proc(`obj`: ptr VipsObject): cint {.cdecl.}
    postbuild*: proc(`obj`: ptr VipsObject, data: pointer): cint {.cdecl.}
    summary_class*: proc(cls: ptr VipsObjectClass, buf: ptr VipsBuf) {.cdecl.}
    summary*: proc(`obj`: ptr VipsObject, buf: ptr VipsBuf) {.cdecl.}
    dump*: proc(`obj`: ptr VipsObject, buf: ptr VipsBuf) {.cdecl.}
    sanity*: proc(`obj`: ptr VipsObject, buf: ptr VipsBuf) {.cdecl.}
    rewind*: proc(`obj`: ptr VipsObject) {.cdecl.}
    preclose*: proc(`obj`: ptr VipsObject) {.cdecl.}
    close*: proc(`obj`: ptr VipsObject) {.cdecl.}
    postclose*: proc(`obj`: ptr VipsObject) {.cdecl.}
    new_from_string*: proc(str: cstring): ptr VipsObject {.cdecl.}
    to_string*: proc(`obj`: ptr VipsObject, buf: ptr VipsBuf) {.cdecl.}
    output_needs_arg*: cint # gboolean
    output_to_arg*: proc(`obj`: ptr VipsObject, str: cstring): cint {.cdecl.}
    nickname*: cstring
    description*: cstring
    argument_table*: pointer # VipsArgumentTable*
    argument_table_traverse*: ptr GSList
    argument_table_traverse_gtype*: GType
    deprecated*: cint # gboolean
    # _vips_reserved1*: proc() {.cdecl.}
    # _vips_reserved2*: proc() {.cdecl.}
    # _vips_reserved3*: proc() {.cdecl.}
    # _vips_reserved4*: proc() {.cdecl.}

  VipsArgumentFlags* {.size: sizeof(cint).} = enum
    VIPS_ARGUMENT_NONE = 0,
    VIPS_ARGUMENT_REQUIRED = 1,
    VIPS_ARGUMENT_CONSTRUCT = 2,
    VIPS_ARGUMENT_SET_ONCE = 4,
    VIPS_ARGUMENT_SET_ALWAYS = 8,
    VIPS_ARGUMENT_INPUT = 16,
    VIPS_ARGUMENT_OUTPUT = 32,
    VIPS_ARGUMENT_DEPRECATED = 64,
    VIPS_ARGUMENT_MODIFY = 128,
    VIPS_ARGUMENT_NON_HASHABLE = 256

  VipsArgument* = object
    pspec*: ptr GParamSpec

  VipsArgumentClass* = object
    parent*: VipsArgument
    object_class*: ptr VipsObjectClass
    flags*: VipsArgumentFlags
    priority*: cint
    offset*: uint

  VipsArgumentInstance* = object
    parent*: VipsArgument
    argument_class*: ptr VipsArgumentClass
    `object`*: ptr VipsObject
    assigned*: cint # gboolean
    close_id*: culong
    invalidate_id*: culong

  VipsArgumentTable* = pointer

  VipsArgumentMapFn* = proc(`obj`: ptr VipsObject, pspec: ptr GParamSpec,
    argument_class: ptr VipsArgumentClass, argument_instance: ptr VipsArgumentInstance,
    a: pointer, b: pointer): pointer {.cdecl.}

  VipsArgumentClassMapFn* = proc(object_class: ptr VipsObjectClass, pspec: ptr GParamSpec,
    argument_class: ptr VipsArgumentClass, a: pointer, b: pointer): pointer {.cdecl.}

  VipsObjectSetArguments* = proc(`obj`: ptr VipsObject, a: pointer, b: pointer): pointer {.cdecl.}
  VipsTypeMapFn* = proc(typ: GType, a: pointer): pointer {.cdecl.}
  VipsTypeMap2Fn* = proc(typ: GType, a: pointer, b: pointer): pointer {.cdecl.}
  VipsClassMapFn* = proc(cls: ptr VipsObjectClass, a: pointer): pointer {.cdecl.}

# Macro flag combinations as Nim consts
const
  VIPS_ARGUMENT_REQUIRED_INPUT* = VipsArgumentFlags(
    ord(VIPS_ARGUMENT_INPUT) or ord(VIPS_ARGUMENT_REQUIRED) or ord(VIPS_ARGUMENT_CONSTRUCT)
  )
  VIPS_ARGUMENT_OPTIONAL_INPUT* = VipsArgumentFlags(
    ord(VIPS_ARGUMENT_INPUT) or ord(VIPS_ARGUMENT_CONSTRUCT)
  )
  VIPS_ARGUMENT_REQUIRED_OUTPUT* = VipsArgumentFlags(
    ord(VIPS_ARGUMENT_OUTPUT) or ord(VIPS_ARGUMENT_REQUIRED) or ord(VIPS_ARGUMENT_CONSTRUCT)
  )
  VIPS_ARGUMENT_OPTIONAL_OUTPUT* = VipsArgumentFlags(
    ord(VIPS_ARGUMENT_OUTPUT) or ord(VIPS_ARGUMENT_CONSTRUCT)
  )

proc vips_object_set_member*(`obj`: ptr VipsObject, pspec: ptr GParamSpec,
      member: ptr ptr GObject, argument: ptr GObject) {.cdecl, importc: "vips__object_set_member", header:" vips/object.h".}

{.push cdecl, importc, header: "vips/object.h".}
proc vips_argument_get_id*(): cint
proc vips_argument_map*(`obj`: ptr VipsObject, fn: VipsArgumentMapFn, a, b: pointer): pointer
proc vips_object_get_args*(`obj`: ptr VipsObject, names: ptr ptr cstringArray, flags: ptr ptr cint, n_args: ptr cint): cint
proc vips_argument_class_map*(object_class: ptr VipsObjectClass, fn: VipsArgumentClassMapFn, a, b: pointer): pointer
proc vips_argument_class_needsstring*(argument_class: ptr VipsArgumentClass): cint
proc vips_object_get_argument*(`obj`: ptr VipsObject, name: cstring, pspec: ptr ptr GParamSpec, argument_class: ptr ptr VipsArgumentClass, argument_instance: ptr ptr VipsArgumentInstance): cint
proc vips_object_argument_isset*(`obj`: ptr VipsObject, name: cstring): cint
proc vips_object_get_argument_flags*(`obj`: ptr VipsObject, name: cstring): VipsArgumentFlags
proc vips_object_get_argument_priority*(`obj`: ptr VipsObject, name: cstring): cint
proc vips_value_is_null*(pspec: ptr GParamSpec, value: ptr GValue): cint
proc vips_object_set_property*(`obj`: ptr GObject, property_id: cuint, value: ptr GValue, pspec: ptr GParamSpec)
proc vips_object_get_property*(`obj`: ptr GObject, property_id: cuint, value: ptr GValue, pspec: ptr GParamSpec)
proc vips_object_preclose*(`obj`: ptr VipsObject)
proc vips_object_build*(`obj`: ptr VipsObject): cint
proc vips_object_summary_class*(klass: ptr VipsObjectClass, buf: ptr VipsBuf)
proc vips_object_summary*(`obj`: ptr VipsObject, buf: ptr VipsBuf)
proc vips_object_dump*(`obj`: ptr VipsObject, buf: ptr VipsBuf)
proc vips_object_print_summary_class*(klass: ptr VipsObjectClass)
proc vips_object_print_summary*(`obj`: ptr VipsObject)
proc vips_object_print_dump*(`obj`: ptr VipsObject)
proc vips_object_print_name*(`obj`: ptr VipsObject)
proc vips_object_sanity*(`obj`: ptr VipsObject): cint
proc vips_object_get_type*(): GType
proc vips_object_class_install_argument*(cls: ptr VipsObjectClass, pspec: ptr GParamSpec, flags: VipsArgumentFlags, priority: cint, offset: cuint)
proc vips_object_set_argument_from_string*(`obj`: ptr VipsObject, name, value: cstring): cint
proc vips_object_argument_needsstring*(`obj`: ptr VipsObject, name: cstring): cint
proc vips_object_get_argument_to_string*(`obj`: ptr VipsObject, name, arg: cstring): cint
proc vips_object_set_required*(`obj`: ptr VipsObject, value: cstring): cint
proc vips_object_new*(typ: GType, set: VipsObjectSetArguments, a, b: pointer): ptr VipsObject
proc vips_object_set_valist*(`obj`: ptr VipsObject, ap: va_list): cint
proc vips_object_set*(`obj`: ptr VipsObject): cint {.varargs, cdecl, importc.}
proc vips_object_set_from_string*(`obj`: ptr VipsObject, str: cstring): cint
proc vips_object_new_from_string*(object_class: ptr VipsObjectClass, p: cstring): ptr VipsObject
proc vips_object_to_string*(`obj`: ptr VipsObject, buf: ptr VipsBuf)
proc vips_object_map*(fn: VipsSListMap2Fn, a, b: pointer): pointer
proc vips_type_map*(base: GType, fn: VipsTypeMap2Fn, a, b: pointer): pointer
proc vips_type_map_all*(base: GType, fn: VipsTypeMapFn, a: pointer): pointer
proc vips_type_depth*(typ: GType): cint
proc vips_type_find*(basename, nickname: cstring): GType
proc vips_nickname_find*(typ: GType): cstring
proc vips_class_map_all*(typ: GType, fn: VipsClassMapFn, a: pointer): pointer
proc vips_class_find*(basename, nickname: cstring): ptr VipsObjectClass
proc vips_object_local_array*(parent: ptr VipsObject, n: cint): ptr ptr VipsObject
proc vips_object_local_cb*(`obj`: ptr VipsObject, `obj2`: ptr GObject)
proc vips_object_set_static*(`obj`: ptr VipsObject, `obj2`: cint)
proc vips_object_print_all*()
proc vips_object_sanity_all*()
proc vips_object_rewind*(`obj`: ptr VipsObject)
proc vips_object_unref_outputs*(`obj`: ptr VipsObject)
proc vips_object_get_description*(`obj`: ptr VipsObject): cstring
{.pop.}