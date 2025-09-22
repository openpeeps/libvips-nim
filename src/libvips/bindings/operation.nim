# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./glib/glib
import ./types, ./basic, ./buf
import "object.nim"

type
  VipsOperationFlags* {.size: sizeof(cint).} = enum
    VIPS_OPERATION_NONE = 0,
    VIPS_OPERATION_SEQUENTIAL = 1,
    VIPS_OPERATION_SEQUENTIAL_UNBUFFERED = 2, # Deprecated
    VIPS_OPERATION_NOCACHE = 4,
    VIPS_OPERATION_DEPRECATED = 8,
    VIPS_OPERATION_UNTRUSTED = 16,
    VIPS_OPERATION_BLOCKED = 32,
    VIPS_OPERATION_REVALIDATE = 64

  VipsOperationBuildFn* = proc(`object`: ptr VipsObject): gboolean {.cdecl.}

  VipsOperation* = object
    parent_instance*: VipsObject
    hash*: guint
    found_hash*: gboolean
    pixels*: cint

  VipsOperationClass* = object
    parent_class*: VipsObjectClass
    usage*: proc(cls: ptr VipsOperationClass, buf: ptr VipsBuf) {.cdecl.}
    get_flags*: proc(operation: ptr VipsOperation): VipsOperationFlags {.cdecl.}
    flags*: VipsOperationFlags
    invalidate*: proc(operation: ptr VipsOperation) {.cdecl.}

# Macros for GObject type checks are not directly translatable to Nim.
# Use the underlying C API if needed.

# Function declarations
{.push cdecl, importc, header: "vips/vips.h".}
proc vips_operation_get_type*(): GType
proc vips_operation_get_flags*(operation: ptr VipsOperation): VipsOperationFlags
proc vips_operation_class_print_usage*(operation_class: ptr VipsOperationClass)
proc vips_operation_invalidate*(operation: ptr VipsOperation)
proc vips_operation_call_valist*(operation: ptr VipsOperation, ap: va_list): cint
proc vips_operation_new*(name: cstring): ptr VipsOperation
proc vips_call_required_optional*(operation: ptr ptr VipsOperation, required: va_list, optional: va_list): cint
proc vips_call_options*(group: ptr GOptionGroup, operation: ptr VipsOperation)
proc vips_call_argv*(operation: ptr VipsOperation, argc: cint, argv: cstringArray): cint
proc vips_cache_drop_all*()
proc vips_cache_operation_buildp*(operation: ptr ptr VipsOperation): cint
proc vips_cache_operation_build*(operation: ptr VipsOperation): ptr VipsOperation
proc vips_cache_print*()
proc vips_cache_set_max*(max: cint)
proc vips_cache_set_max_mem*(max_mem: csize_t)
proc vips_cache_get_max*(): cint
proc vips_cache_get_size*(): cint
proc vips_cache_get_max_mem*(): csize_t
proc vips_cache_get_max_files*(): cint
proc vips_cache_set_max_files*(max_files: cint)
proc vips_cache_set_dump*(dump: gboolean)
proc vips_cache_set_trace*(trace: gboolean)
proc vips_concurrency_set*(concurrency: cint)
proc vips_concurrency_get*(): cint
proc vips_operation_block_set*(name: cstring, state: gboolean)
{.pop.}

proc c_vips_call(operation_name: cstring): cint {.cdecl, importc: "vips_call", header: "vips/vips.h", varargs.}
proc c_vips_call_split(operation_name: cstring, optional: va_list): cint {.cdecl, importc: "vips_call_split", header: "vips/vips.h", varargs.}
proc c_vips_call_split_option_string(operation_name: cstring, option_string: cstring, optional: va_list): cint {.cdecl, importc: "vips_call_split_option_string", header: "vips/vips.h", varargs.}

# Safe, exported wrappers
proc vips_call*(operation_name: cstring): cint =
  c_vips_call(operation_name, nil)

proc vips_call_split*(operation_name: cstring, optional: va_list): cint =
  c_vips_call_split(operation_name, optional, nil)

proc vips_call_split_option_string*(operation_name: cstring, option_string: cstring, optional: va_list): cint =
  c_vips_call_split_option_string(operation_name, option_string, optional, nil)