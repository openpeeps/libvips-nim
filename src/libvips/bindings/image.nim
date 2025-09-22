# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim
import ./basic, ./types

type
  VipsDemandStyle* = enum
    VIPS_DEMAND_STYLE_ERROR = -1,
    VIPS_DEMAND_STYLE_SMALLTILE,
    VIPS_DEMAND_STYLE_FATSTRIP,
    VIPS_DEMAND_STYLE_THINSTRIP,
    VIPS_DEMAND_STYLE_ANY

  VipsImageType* = enum
    VIPS_IMAGE_ERROR = -1,
    VIPS_IMAGE_NONE,
    VIPS_IMAGE_SETBUF,
    VIPS_IMAGE_SETBUF_FOREIGN,
    VIPS_IMAGE_OPENIN,
    VIPS_IMAGE_MMAPIN,
    VIPS_IMAGE_MMAPINRW,
    VIPS_IMAGE_OPENOUT,
    VIPS_IMAGE_PARTIAL

  VipsCoding* = enum
    VIPS_CODING_ERROR = -1,
    VIPS_CODING_NONE = 0,
    VIPS_CODING_LABQ = 2,
    VIPS_CODING_RAD = 6,
    VIPS_CODING_LAST = 7

  VipsAccess* = enum
    VIPS_ACCESS_RANDOM,
    VIPS_ACCESS_SEQUENTIAL,
    VIPS_ACCESS_SEQUENTIAL_UNBUFFERED,
    VIPS_ACCESS_LAST

  VipsBandFormat* = enum
    VIPS_FORMAT_NOTSET = -1,
    VIPS_FORMAT_UCHAR = 0,
    VIPS_FORMAT_CHAR = 1,
    VIPS_FORMAT_USHORT = 2,
    VIPS_FORMAT_SHORT = 3,
    VIPS_FORMAT_UINT = 4,
    VIPS_FORMAT_INT = 5,
    VIPS_FORMAT_FLOAT = 6,
    VIPS_FORMAT_COMPLEX = 7,
    VIPS_FORMAT_DOUBLE = 8,
    VIPS_FORMAT_DPCOMPLEX = 9,
    VIPS_FORMAT_LAST = 10

  VipsInterpretation* = enum
    VIPS_INTERPRETATION_ERROR = -1,
    VIPS_INTERPRETATION_MULTIBAND = 0,
    VIPS_INTERPRETATION_B_W = 1,
    VIPS_INTERPRETATION_HISTOGRAM = 10,
    VIPS_INTERPRETATION_XYZ = 12,
    VIPS_INTERPRETATION_LAB = 13,
    VIPS_INTERPRETATION_CMYK = 15,
    VIPS_INTERPRETATION_LABQ = 16,
    VIPS_INTERPRETATION_RGB = 17,
    VIPS_INTERPRETATION_CMC = 18,
    VIPS_INTERPRETATION_LCH = 19,
    VIPS_INTERPRETATION_LABS = 21,
    VIPS_INTERPRETATION_sRGB = 22,
    VIPS_INTERPRETATION_YXY = 23,
    VIPS_INTERPRETATION_FOURIER = 24,
    VIPS_INTERPRETATION_RGB16 = 25,
    VIPS_INTERPRETATION_GREY16 = 26,
    VIPS_INTERPRETATION_MATRIX = 27,
    VIPS_INTERPRETATION_scRGB = 28,
    VIPS_INTERPRETATION_HSV = 29,
    VIPS_INTERPRETATION_LAST = 30

# Opaque pointer types for external structs
type
  # VipsImage* = object
  VipsImageClass* = object
  VipsProgress* = object
  VipsRect* = object
  # VipsSource* = object
  # VipsTarget* = object
  # GValue* = object

# Function pointer types
type
  VipsStartFn* = proc(outImg: ptr VipsImage, a: pointer, b: pointer): pointer {.cdecl.}
  VipsGenerateFn* = proc(outRegion: ptr VipsRegion, seq: pointer, a: pointer, b: pointer, stop: ptr gboolean): cint {.cdecl.}
  VipsStopFn* = proc(seq: pointer, a: pointer, b: pointer): cint {.cdecl.}


# Raw varargs imports
proc c_vips_image_new_from_file(name: cstring): ptr VipsImage {.cdecl, importc: "vips_image_new_from_file", varargs.}
proc c_vips_image_write_to_file(img: ptr VipsImage, fname: cstring): cint {.cdecl, importc: "vips_image_write_to_file", varargs.}
proc c_vips_image_new_from_buffer(buf: pointer, len: csize_t, option_string: cstring): ptr VipsImage {.cdecl, importc: "vips_image_new_from_buffer", varargs.}
proc c_vips_image_new_from_source(source: ptr VipsSource, option_string: cstring): ptr VipsImage {.cdecl, importc: "vips_image_new_from_source", varargs.}
proc c_vips_image_write_to_buffer(img: ptr VipsImage, suffix: cstring, buf: ptr pointer, size: ptr csize_t): cint {.cdecl, importc: "vips_image_write_to_buffer", varargs.}
proc c_vips_image_write_to_target(img: ptr VipsImage, suffix: cstring, target: ptr VipsTarget): cint {.cdecl, importc: "vips_image_write_to_target", varargs.}
proc c_vips_system(cmd_format: cstring): cint {.cdecl, importc: "vips_system", varargs.}
proc c_vips_array_image_newv(n: cint): ptr VipsArrayImage {.cdecl, importc: "vips_array_image_newv", varargs.}

# Safe, exported wrappers
proc vips_image_new_from_file*(fname: cstring): ptr VipsImage =
  c_vips_image_new_from_file(fname, nil)

proc vips_image_write_to_file*(img: ptr VipsImage, fname: cstring): cint =
  c_vips_image_write_to_file(img, fname, nil)

proc vips_image_new_from_buffer*(buf: pointer, len: csize_t, option_string: cstring): ptr VipsImage =
  c_vips_image_new_from_buffer(buf, len, option_string, nil)

proc vips_image_new_from_source*(source: ptr VipsSource, option_string: cstring): ptr VipsImage =
  c_vips_image_new_from_source(source, option_string, nil)

proc vips_image_write_to_buffer*(img: ptr VipsImage, suffix: cstring, buf: ptr pointer, size: ptr csize_t): cint =
  c_vips_image_write_to_buffer(img, suffix, buf, size, nil)

proc vips_image_write_to_target*(img: ptr VipsImage, suffix: cstring, target: ptr VipsTarget): cint =
  c_vips_image_write_to_target(img, suffix, target, nil)

proc vips_system*(cmd_format: cstring): cint =
  c_vips_system(cmd_format, nil)

proc vips_array_image_newv*(n: cint): ptr VipsArrayImage =
  c_vips_array_image_newv(n, nil)

{.push cdecl, importc, header: "vips/vips.h".} # should be `vips/header.h` but the compiler complains about missing types
proc vips_image_get_type*(): culong
proc vips_progress_set*(progress: gboolean)
proc vips_image_invalidate_all*(image: ptr VipsImage)
proc vips_image_minimise_all*(image: ptr VipsImage)
proc vips_image_is_sequential*(image: ptr VipsImage): gboolean
proc vips_image_set_progress*(image: ptr VipsImage, progress: gboolean)
proc vips_image_iskilled*(image: ptr VipsImage): gboolean
proc vips_image_set_kill*(image: ptr VipsImage, kill: gboolean)
proc vips_filename_get_filename*(vips_filename: cstring): cstring
proc vips_filename_get_options*(vips_filename: cstring): cstring
proc vips_image_new*(): ptr VipsImage
proc vips_image_new_memory*(): ptr VipsImage
proc vips_image_memory*(): ptr VipsImage
proc vips_image_new_from_file_RW*(filename: cstring): ptr VipsImage
proc vips_image_new_from_file_raw*(filename: cstring, xsize, ysize, bands: cint, offset: guint64): ptr VipsImage
proc vips_image_new_from_memory*(data: pointer, size: csize_t, width, height, bands: cint, format: VipsBandFormat): ptr VipsImage
proc vips_image_new_from_memory_copy*(data: pointer, size: csize_t, width, height, bands: cint, format: VipsBandFormat): ptr VipsImage
proc vips_image_new_matrix*(width, height: cint): ptr VipsImage
proc vips_image_new_matrixv*(width, height: cint, args: varargs[cdouble]): ptr VipsImage
proc vips_image_new_matrix_from_array*(width, height: cint, array: ptr cdouble, size: cint): ptr VipsImage
proc vips_image_matrix_from_array*(width, height: cint, array: ptr cdouble, size: cint): ptr VipsImage
proc vips_image_new_from_image*(image: ptr VipsImage, c: ptr cdouble, n: cint): ptr VipsImage
proc vips_image_new_from_image1*(image: ptr VipsImage, c: cdouble): ptr VipsImage
proc vips_image_set_delete_on_close*(image: ptr VipsImage, delete_on_close: gboolean)
proc vips_get_disc_threshold*(): guint64
proc vips_image_new_temp_file*(format: cstring): ptr VipsImage
proc vips_image_write*(image: ptr VipsImage, outImg: ptr VipsImage): cint
proc vips_image_write_to_memory*(img: ptr VipsImage, size: ptr csize_t): pointer
proc vips_image_decode_predict*(img: ptr VipsImage, bands: ptr cint, format: ptr VipsBandFormat): cint
proc vips_image_decode*(img: ptr VipsImage, outImg: ptr ptr VipsImage): cint
proc vips_image_encode*(img: ptr VipsImage, outImg: ptr ptr VipsImage, coding: VipsCoding): cint
proc vips_image_isMSBfirst*(img: ptr VipsImage): gboolean
proc vips_image_isfile*(img: ptr VipsImage): gboolean
proc vips_image_ispartial*(img: ptr VipsImage): gboolean
proc vips_image_hasalpha*(img: ptr VipsImage): gboolean
proc vips_image_copy_memory*(img: ptr VipsImage): ptr VipsImage
proc vips_image_wio_input*(img: ptr VipsImage): cint
proc vips_image_pio_input*(img: ptr VipsImage): cint
proc vips_image_pio_output*(img: ptr VipsImage): cint
proc vips_image_inplace*(img: ptr VipsImage): cint
proc vips_image_write_prepare*(img: ptr VipsImage): cint
proc vips_image_write_line*(img: ptr VipsImage, ypos: cint, linebuffer: ptr VipsPel): cint
proc vips_band_format_isint*(format: VipsBandFormat): gboolean
proc vips_band_format_isuint*(format: VipsBandFormat): gboolean
proc vips_band_format_is8bit*(format: VipsBandFormat): gboolean
proc vips_band_format_isfloat*(format: VipsBandFormat): gboolean
proc vips_band_format_iscomplex*(format: VipsBandFormat): gboolean
proc vips_array_image_new*(array: ptr ptr VipsImage, n: cint): ptr VipsArrayImage
proc vips_array_image_new_from_string*(str: cstring, flags: VipsAccess): ptr VipsArrayImage
proc vips_array_image_empty*(): ptr VipsArrayImage
proc vips_array_image_append*(array: ptr VipsArrayImage, image: ptr VipsImage): ptr VipsArrayImage
proc vips_array_image_get*(array: ptr VipsArrayImage, n: ptr cint): ptr ptr VipsImage
proc vips_value_get_array_image*(value: ptr GValue, n: ptr cint): ptr ptr VipsImage
proc vips_value_set_array_image*(value: ptr GValue, n: cint)
proc vips_reorder_prepare_many*(image: ptr VipsImage, regions: ptr ptr VipsRegion, r: ptr VipsRect): cint
proc vips_reorder_margin_hint*(image: ptr VipsImage, margin: cint)
proc vips_image_free_buffer*(image: ptr VipsImage, buffer: pointer)
{.pop.}