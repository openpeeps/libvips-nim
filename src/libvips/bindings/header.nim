# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./basic, ./image

const
  VIPS_META_EXIF_NAME* = "exif-data"
  VIPS_META_XMP_NAME* = "xmp-data"
  VIPS_META_IPTC_NAME* = "iptc-data"
  VIPS_META_PHOTOSHOP_NAME* = "photoshop-data"
  VIPS_META_ICC_NAME* = "icc-profile-data"
  VIPS_META_IMAGEDESCRIPTION* = "image-description"
  VIPS_META_RESOLUTION_UNIT* = "resolution-unit"
  VIPS_META_BITS_PER_SAMPLE* = "bits-per-sample"
  VIPS_META_PALETTE* = "palette"
  VIPS_META_LOADER* = "vips-loader"
  VIPS_META_SEQUENTIAL* = "vips-sequential"
  VIPS_META_ORIENTATION* = "orientation"
  VIPS_META_PAGE_HEIGHT* = "page-height"
  VIPS_META_N_PAGES* = "n-pages"
  VIPS_META_N_SUBIFDS* = "n-subifds"
  VIPS_META_CONCURRENCY* = "concurrency"
  VIPS_META_TILE_WIDTH* = "tile-width"
  VIPS_META_TILE_HEIGHT* = "tile-height"

# Function pointer types
type
  VipsImageMapFn* = proc(image: ptr VipsImage, name: cstring, value: ptr GValue, a: pointer): pointer {.cdecl.}

# Function declarations
{.push cdecl, importc, header: "vips/image.h".}
proc vips_format_sizeof*(format: VipsBandFormat): uint64
proc vips_format_sizeof_unsafe*(format: VipsBandFormat): uint64

proc vips_interpretation_max_alpha*(interpretation: VipsInterpretation): cdouble

proc vips_image_get_width*(image: ptr VipsImage): cint
proc vips_image_get_height*(image: ptr VipsImage): cint
proc vips_image_get_bands*(image: ptr VipsImage): cint
proc vips_image_get_format*(image: ptr VipsImage): VipsBandFormat
proc vips_image_get_format_max*(format: VipsBandFormat): cdouble
proc vips_image_guess_format*(image: ptr VipsImage): VipsBandFormat
proc vips_image_get_coding*(image: ptr VipsImage): VipsCoding
proc vips_image_get_interpretation*(image: ptr VipsImage): VipsInterpretation
proc vips_image_guess_interpretation*(image: ptr VipsImage): VipsInterpretation
proc vips_image_get_xres*(image: ptr VipsImage): cdouble
proc vips_image_get_yres*(image: ptr VipsImage): cdouble
proc vips_image_get_xoffset*(image: ptr VipsImage): cint
proc vips_image_get_yoffset*(image: ptr VipsImage): cint
proc vips_image_get_filename*(image: ptr VipsImage): cstring
proc vips_image_get_mode*(image: ptr VipsImage): cstring
proc vips_image_get_scale*(image: ptr VipsImage): cdouble
proc vips_image_get_offset*(image: ptr VipsImage): cdouble
proc vips_image_get_page_height*(image: ptr VipsImage): cint
proc vips_image_get_n_pages*(image: ptr VipsImage): cint
proc vips_image_get_n_subifds*(image: ptr VipsImage): cint
proc vips_image_get_orientation*(image: ptr VipsImage): cint
proc vips_image_get_orientation_swap*(image: ptr VipsImage): bool
proc vips_image_get_concurrency*(image: ptr VipsImage, default_concurrency: cint): cint
proc vips_image_get_tile_width*(image: ptr VipsImage): cint
proc vips_image_get_tile_height*(image: ptr VipsImage): cint
proc vips_image_get_data*(image: ptr VipsImage): pointer

proc vips_image_init_fields*(image: ptr VipsImage,
  xsize, ysize, bands: cint,
  format: VipsBandFormat, coding: VipsCoding,
  interpretation: VipsInterpretation,
  xres, yres: cdouble)

proc vips_image_set*(image: ptr VipsImage, name: cstring, value: ptr GValue)
proc vips_image_get*(image: ptr VipsImage, name: cstring, value_copy: ptr GValue): cint
proc vips_image_get_as_string*(image: ptr VipsImage, name: cstring, res: ptr cstring): cint
proc vips_image_get_typeof*(image: ptr VipsImage, name: cstring): GType
proc vips_image_remove*(image: ptr VipsImage, name: cstring): bool
proc vips_image_map*(image: ptr VipsImage, fn: VipsImageMapFn, a: pointer): pointer
proc vips_image_get_fields*(image: ptr VipsImage): ptr cstringArray

proc vips_image_set_area*(image: ptr VipsImage, name: cstring, free_fn: VipsCallbackFn, data: pointer)
proc vips_image_get_area*(image: ptr VipsImage, name: cstring, data: ptr pointer): cint
proc vips_image_set_blob*(image: ptr VipsImage, name: cstring, free_fn: VipsCallbackFn, data: pointer, length: csize_t)
proc vips_image_set_blob_copy*(image: ptr VipsImage, name: cstring, data: pointer, length: csize_t)
proc vips_image_get_blob*(image: ptr VipsImage, name: cstring, data: ptr pointer, length: ptr csize_t): cint

proc vips_image_get_int*(image: ptr VipsImage, name: cstring, res: ptr cint): cint
proc vips_image_set_int*(image: ptr VipsImage, name: cstring, i: cint)
proc vips_image_get_double*(image: ptr VipsImage, name: cstring, res: ptr cdouble): cint
proc vips_image_set_double*(image: ptr VipsImage, name: cstring, d: cdouble)
proc vips_image_get_string*(image: ptr VipsImage, name: cstring, res: ptr cstring): cint
proc vips_image_set_string*(image: ptr VipsImage, name, str: cstring)
proc vips_image_print_field*(image: ptr VipsImage, name: cstring)
proc vips_image_get_image*(image: ptr VipsImage, name: cstring, res: ptr ptr VipsImage): cint
proc vips_image_set_image*(image: ptr VipsImage, name: cstring, im: ptr VipsImage)
proc vips_image_set_array_int*(image: ptr VipsImage, name: cstring, array: ptr cint, n: cint)
proc vips_image_get_array_int*(image: ptr VipsImage, name: cstring, res: ptr ptr cint, n: ptr cint): cint
proc vips_image_get_array_double*(image: ptr VipsImage, name: cstring, res: ptr ptr cdouble, n: ptr cint): cint
proc vips_image_set_array_double*(image: ptr VipsImage, name: cstring, array: ptr cdouble, n: cint)

proc vips_image_history_printf*(image: ptr VipsImage, format: cstring) {.varargs, cdecl, importc.}
proc vips_image_history_args*(image: ptr VipsImage, name: cstring, argc: cint, argv: ptr cstring): cint
proc vips_image_get_history*(image: ptr VipsImage): cstring
{.pop.}