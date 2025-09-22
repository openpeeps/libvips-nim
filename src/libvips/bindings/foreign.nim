# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./image, ./basic

# Opaque types
type
  VipsOperation* = object
    # ...opaque...
  VipsOperationClass* = object
    # ...opaque...
  VipsForeign* = object
    # ...opaque...
  VipsForeignClass* = object
    # ...opaque...
  VipsForeignLoad* = object
    # ...opaque...
  VipsForeignLoadClass* = object
    # ...opaque...
  VipsForeignSave* = object
    # ...opaque...
  VipsForeignSaveClass* = object
    # ...opaque...
  # VipsImage, VipsSource, VipsTarget, VipsArrayDouble are imported from ./types

# Enums
type
  VipsForeignFlags* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_NONE = 0,
    VIPS_FOREIGN_PARTIAL = 1,
    VIPS_FOREIGN_BIGENDIAN = 2,
    VIPS_FOREIGN_SEQUENTIAL = 4,
    VIPS_FOREIGN_ALL = 7

  VipsFailOn* {.size: sizeof(cint).} = enum
    VIPS_FAIL_ON_NONE,
    VIPS_FAIL_ON_TRUNCATED,
    VIPS_FAIL_ON_ERROR,
    VIPS_FAIL_ON_WARNING,
    VIPS_FAIL_ON_LAST

  VipsForeignSaveable* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_SAVEABLE_ANY = 0,
    VIPS_FOREIGN_SAVEABLE_MONO = 1,
    VIPS_FOREIGN_SAVEABLE_RGB = 2,
    VIPS_FOREIGN_SAVEABLE_CMYK = 4,
    VIPS_FOREIGN_SAVEABLE_ALPHA = 8,
    VIPS_FOREIGN_SAVEABLE_ALL = 15

  VipsForeignCoding* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_CODING_NONE = 1,
    VIPS_FOREIGN_CODING_LABQ = 2,
    VIPS_FOREIGN_CODING_RAD = 4,
    VIPS_FOREIGN_CODING_ALL = 7

  VipsForeignKeep* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_KEEP_NONE = 0,
    VIPS_FOREIGN_KEEP_EXIF = 1,
    VIPS_FOREIGN_KEEP_XMP = 2,
    VIPS_FOREIGN_KEEP_IPTC = 4,
    VIPS_FOREIGN_KEEP_ICC = 8,
    VIPS_FOREIGN_KEEP_OTHER = 16,
    VIPS_FOREIGN_KEEP_ALL = 31

  VipsForeignSubsample* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_SUBSAMPLE_AUTO,
    VIPS_FOREIGN_SUBSAMPLE_ON,
    VIPS_FOREIGN_SUBSAMPLE_OFF,
    VIPS_FOREIGN_SUBSAMPLE_LAST

  VipsForeignWebpPreset* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_WEBP_PRESET_DEFAULT,
    VIPS_FOREIGN_WEBP_PRESET_PICTURE,
    VIPS_FOREIGN_WEBP_PRESET_PHOTO,
    VIPS_FOREIGN_WEBP_PRESET_DRAWING,
    VIPS_FOREIGN_WEBP_PRESET_ICON,
    VIPS_FOREIGN_WEBP_PRESET_TEXT,
    VIPS_FOREIGN_WEBP_PRESET_LAST

  VipsForeignTiffCompression* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_TIFF_COMPRESSION_NONE,
    VIPS_FOREIGN_TIFF_COMPRESSION_JPEG,
    VIPS_FOREIGN_TIFF_COMPRESSION_DEFLATE,
    VIPS_FOREIGN_TIFF_COMPRESSION_PACKBITS,
    VIPS_FOREIGN_TIFF_COMPRESSION_CCITTFAX4,
    VIPS_FOREIGN_TIFF_COMPRESSION_LZW,
    VIPS_FOREIGN_TIFF_COMPRESSION_WEBP,
    VIPS_FOREIGN_TIFF_COMPRESSION_ZSTD,
    VIPS_FOREIGN_TIFF_COMPRESSION_JP2K,
    VIPS_FOREIGN_TIFF_COMPRESSION_LAST

  VipsForeignTiffPredictor* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_TIFF_PREDICTOR_NONE = 1,
    VIPS_FOREIGN_TIFF_PREDICTOR_HORIZONTAL = 2,
    VIPS_FOREIGN_TIFF_PREDICTOR_FLOAT = 3,
    VIPS_FOREIGN_TIFF_PREDICTOR_LAST

  VipsForeignTiffResunit* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_TIFF_RESUNIT_CM,
    VIPS_FOREIGN_TIFF_RESUNIT_INCH,
    VIPS_FOREIGN_TIFF_RESUNIT_LAST

  VipsForeignPpmFormat* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_PPM_FORMAT_PBM,
    VIPS_FOREIGN_PPM_FORMAT_PGM,
    VIPS_FOREIGN_PPM_FORMAT_PPM,
    VIPS_FOREIGN_PPM_FORMAT_PFM,
    VIPS_FOREIGN_PPM_FORMAT_PNM,
    VIPS_FOREIGN_PPM_FORMAT_LAST

  VipsForeignPdfPageBox* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_PDF_PAGE_BOX_MEDIA,
    VIPS_FOREIGN_PDF_PAGE_BOX_CROP,
    VIPS_FOREIGN_PDF_PAGE_BOX_TRIM,
    VIPS_FOREIGN_PDF_PAGE_BOX_BLEED,
    VIPS_FOREIGN_PDF_PAGE_BOX_ART,
    VIPS_FOREIGN_PDF_PAGE_BOX_LAST

  VipsForeignPngFilter* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_PNG_FILTER_NONE = 0x08,
    VIPS_FOREIGN_PNG_FILTER_SUB = 0x10,
    VIPS_FOREIGN_PNG_FILTER_UP = 0x20,
    VIPS_FOREIGN_PNG_FILTER_AVG = 0x40,
    VIPS_FOREIGN_PNG_FILTER_PAETH = 0x80,
    VIPS_FOREIGN_PNG_FILTER_ALL = 0xF8

  VipsForeignDzLayout* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_DZ_LAYOUT_DZ,
    VIPS_FOREIGN_DZ_LAYOUT_ZOOMIFY,
    VIPS_FOREIGN_DZ_LAYOUT_GOOGLE,
    VIPS_FOREIGN_DZ_LAYOUT_IIIF,
    VIPS_FOREIGN_DZ_LAYOUT_IIIF3,
    VIPS_FOREIGN_DZ_LAYOUT_LAST

  VipsForeignDzDepth* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_DZ_DEPTH_ONEPIXEL,
    VIPS_FOREIGN_DZ_DEPTH_ONETILE,
    VIPS_FOREIGN_DZ_DEPTH_ONE,
    VIPS_FOREIGN_DZ_DEPTH_LAST

  VipsForeignDzContainer* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_DZ_CONTAINER_FS,
    VIPS_FOREIGN_DZ_CONTAINER_ZIP,
    VIPS_FOREIGN_DZ_CONTAINER_SZI,
    VIPS_FOREIGN_DZ_CONTAINER_LAST

  VipsForeignHeifCompression* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_HEIF_COMPRESSION_HEVC = 1,
    VIPS_FOREIGN_HEIF_COMPRESSION_AVC = 2,
    VIPS_FOREIGN_HEIF_COMPRESSION_JPEG = 3,
    VIPS_FOREIGN_HEIF_COMPRESSION_AV1 = 4,
    VIPS_FOREIGN_HEIF_COMPRESSION_LAST

  VipsForeignHeifEncoder* {.size: sizeof(cint).} = enum
    VIPS_FOREIGN_HEIF_ENCODER_AUTO,
    VIPS_FOREIGN_HEIF_ENCODER_AOM,
    VIPS_FOREIGN_HEIF_ENCODER_RAV1E,
    VIPS_FOREIGN_HEIF_ENCODER_SVT,
    VIPS_FOREIGN_HEIF_ENCODER_X265,
    VIPS_FOREIGN_HEIF_ENCODER_LAST

# Function declarations
proc vips_foreign_get_type*(): culong {.importc, cdecl.}
proc vips_foreign_map*(base: cstring, fn: pointer, a: pointer, b: pointer): pointer {.importc, cdecl.}

proc vips_foreign_load_get_type*(): culong {.importc, cdecl.}
proc vips_foreign_find_load*(filename: cstring): cstring {.importc, cdecl.}
proc vips_foreign_find_load_buffer*(data: pointer, size: csize_t): cstring {.importc, cdecl.}
proc vips_foreign_find_load_source*(source: ptr VipsSource): cstring {.importc, cdecl.}
proc vips_foreign_flags*(loader, filename: cstring): VipsForeignFlags {.importc, cdecl.}
proc vips_foreign_is_a*(loader, filename: cstring): bool {.importc, cdecl.}
proc vips_foreign_is_a_buffer*(loader: cstring, data: pointer, size: csize_t): bool {.importc, cdecl.}
proc vips_foreign_is_a_source*(loader: cstring, source: ptr VipsSource): bool {.importc, cdecl.}
proc vips_foreign_load_invalidate*(image: ptr VipsImage) {.importc, cdecl.}

proc vips_foreign_save_get_type*(): culong {.importc, cdecl.}
proc vips_foreign_find_save*(filename: cstring): cstring {.importc, cdecl.}
proc vips_foreign_get_suffixes*(): ptr cstring {.importc, cdecl.}
proc vips_foreign_find_save_buffer*(suffix: cstring): cstring {.importc, cdecl.}
proc vips_foreign_find_save_target*(suffix: cstring): cstring {.importc, cdecl.}

proc vips_vipsload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_vipsload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_vipssave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_vipssave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_openslideload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_openslideload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_jpegload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jpegload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jpegload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jpegsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}
proc vips_jpegsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_jpegsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_jpegsave_mime*(input: ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_webpload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_webpload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_webpload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_webpsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}
proc vips_webpsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_webpsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_webpsave_mime*(input: ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_tiffload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_tiffload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_tiffload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_tiffsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_tiffsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_tiffsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_openexrload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_fitsload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_fitsload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_fitssave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}

proc vips_analyzeload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_rawload*(filename: cstring, res: ptr ptr VipsImage, width, height, bands: cint): cint {.importc, cdecl, varargs.}
proc vips_rawsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_rawsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_rawsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_csvload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_csvload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_csvsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_csvsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_matrixload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_matrixload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_matrixsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_matrixsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}
proc vips_matrixprint*(input: ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_magickload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_magickload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_magickload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_magicksave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_magicksave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}

proc vips_pngload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_pngload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_pngload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_pngsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}
proc vips_pngsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_pngsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}

proc vips_ppmload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_ppmload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_ppmload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_ppmsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_ppmsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_matload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_radload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_radload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_radload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_radsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_radsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_radsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_pdfload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_pdfload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_pdfload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_svgload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_svgload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_svgload_string*(str: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_svgload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_gifload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_gifload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_gifload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_gifsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_gifsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_gifsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_dcrawload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_dcrawload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_dcrawload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_uhdrload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_uhdrload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_uhdrload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}

proc vips_uhdrsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_uhdrsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_uhdrsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_heifload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_heifload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_heifload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_heifsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_heifsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_heifsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_niftiload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_niftiload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_niftisave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}

proc vips_jp2kload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jp2kload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jp2kload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jp2ksave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_jp2ksave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_jp2ksave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_jxlload_source*(source: ptr VipsSource, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jxlload_buffer*(buf: pointer, len: csize_t, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jxlload*(filename: cstring, res: ptr ptr VipsImage): cint {.importc, cdecl, varargs.}
proc vips_jxlsave*(input: ptr VipsImage, filename: cstring): cint {.importc, cdecl, varargs.}
proc vips_jxlsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_jxlsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}

proc vips_dzsave*(input: ptr VipsImage, name: cstring): cint {.importc, cdecl, varargs.}
proc vips_dzsave_buffer*(input: ptr VipsImage, buf: ptr pointer, len: ptr csize_t): cint {.importc, cdecl, varargs.}
proc vips_dzsave_target*(input: ptr VipsImage, target: ptr VipsTarget): cint {.importc, cdecl, varargs.}