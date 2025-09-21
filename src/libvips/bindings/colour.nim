# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import ./types, ./basic, ./image

# Constants
const
  VIPS_D93_X0* = 89.74
  VIPS_D93_Y0* = 100.0
  VIPS_D93_Z0* = 130.77

  VIPS_D75_X0* = 94.9682
  VIPS_D75_Y0* = 100.0
  VIPS_D75_Z0* = 122.571

  VIPS_D65_X0* = 95.047
  VIPS_D65_Y0* = 100.0
  VIPS_D65_Z0* = 108.8827

  VIPS_D55_X0* = 95.6831
  VIPS_D55_Y0* = 100.0
  VIPS_D55_Z0* = 92.0871

  VIPS_D50_X0* = 96.425
  VIPS_D50_Y0* = 100.0
  VIPS_D50_Z0* = 82.468

  VIPS_A_X0* = 109.8503
  VIPS_A_Y0* = 100.0
  VIPS_A_Z0* = 35.5849

  VIPS_B_X0* = 99.072
  VIPS_B_Y0* = 100.0
  VIPS_B_Z0* = 85.223

  VIPS_C_X0* = 98.07
  VIPS_C_Y0* = 100.0
  VIPS_C_Z0* = 118.23

  VIPS_E_X0* = 100.0
  VIPS_E_Y0* = 100.0
  VIPS_E_Z0* = 100.0

  VIPS_D3250_X0* = 105.659
  VIPS_D3250_Y0* = 100.0
  VIPS_D3250_Z0* = 45.8501

# Enums
type
  VipsIntent* {.size: sizeof(cint).} = enum
    VIPS_INTENT_PERCEPTUAL = 0,
    VIPS_INTENT_RELATIVE,
    VIPS_INTENT_SATURATION,
    VIPS_INTENT_ABSOLUTE,
    VIPS_INTENT_AUTO = 32,
    VIPS_INTENT_LAST

  VipsPCS* {.size: sizeof(cint).} = enum
    VIPS_PCS_LAB,
    VIPS_PCS_XYZ,
    VIPS_PCS_LAST

# Function declarations
{.push cdecl, importc, header: "vips/colour.h".}
proc vips_colourspace_issupported*(image: ptr VipsImage): bool
proc vips_colourspace*(input: ptr VipsImage, output: ptr ptr VipsImage,
                      space: VipsInterpretation): cint

proc vips_LabQ2sRGB*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_rad2float*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_float2rad*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_LabS2LabQ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_LabQ2LabS*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_LabQ2Lab*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_Lab2LabQ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_LCh2Lab*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_Lab2LCh*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_Lab2XYZ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_XYZ2Lab*(input: ptr VipsImage, output: ptr ptr VipsImage): cint

proc vips_XYZ2scRGB*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_scRGB2sRGB*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_scRGB2BW*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_sRGB2scRGB*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_scRGB2XYZ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_HSV2sRGB*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_sRGB2HSV*(input: ptr VipsImage, output: ptr ptr VipsImage): cint

proc vips_LCh2CMC*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_CMC2LCh*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_XYZ2Yxy*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_Yxy2XYZ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_LabS2Lab*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_Lab2LabS*(input: ptr VipsImage, output: ptr ptr VipsImage): cint

proc vips_CMYK2XYZ*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_XYZ2CMYK*(input: ptr VipsImage, output: ptr ptr VipsImage): cint

proc vips_profile_load*(name: cstring, profile: ptr ptr VipsBlob): cint
proc vips_icc_present*(): cint
proc vips_icc_transform*(input: ptr VipsImage, output: ptr ptr VipsImage,
                        output_profile: cstring): cint
proc vips_icc_import*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_icc_export*(input: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_icc_ac2rc*(input: ptr VipsImage, output: ptr ptr VipsImage,
                    profile_filename: cstring): cint
proc vips_icc_is_compatible_profile*(image: ptr VipsImage,
                                    data: pointer, data_length: csize_t): bool
 

proc vips_dE76*(left: ptr VipsImage, right: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_dE00*(left: ptr VipsImage, right: ptr VipsImage, output: ptr ptr VipsImage): cint
proc vips_dECMC*(left: ptr VipsImage, right: ptr VipsImage, output: ptr ptr VipsImage): cint

proc vips_col_Lab2XYZ*(L, a, b: float32, X, Y, Z: ptr float32)
proc vips_col_XYZ2Lab*(X, Y, Z: float32, L, a, b: ptr float32)
proc vips_col_ab2h*(a, b: float64): float64
proc vips_col_ab2Ch*(a, b: float32, C, h: ptr float32)
proc vips_col_Ch2ab*(C, h: float32, a, b: ptr float32)

proc vips_col_L2Lcmc*(L: float32): float32
proc vips_col_C2Ccmc*(C: float32): float32
proc vips_col_Ch2hcmc*(C, h: float32): float32

proc vips_col_make_tables_CMC*()
proc vips_col_Lcmc2L*(Lcmc: float32): float32
proc vips_col_Ccmc2C*(Ccmc: float32): float32
proc vips_col_Chcmc2h*(C, hcmc: float32): float32

proc vips_col_sRGB2scRGB_8*(r, g, b: cint, R, G, B: ptr float32): cint
proc vips_col_sRGB2scRGB_16*(r, g, b: cint, R, G, B: ptr float32): cint
proc vips_col_sRGB2scRGB_8_noclip*(r, g, b: cint, R, G, B: ptr float32): cint
proc vips_col_sRGB2scRGB_16_noclip*(r, g, b: cint, R, G, B: ptr float32): cint

proc vips_col_scRGB2XYZ*(R, G, B: float32, X, Y, Z: ptr float32): cint
proc vips_col_XYZ2scRGB*(X, Y, Z: float32, R, G, B: ptr float32): cint

proc vips_col_scRGB2sRGB_8*(R, G, B: float32, r, g, b, og: ptr cint): cint
proc vips_col_scRGB2sRGB_16*(R, G, B: float32, r, g, b, og: ptr cint): cint
proc vips_col_scRGB2BW_16*(R, G, B: float32, g, og: ptr cint): cint
proc vips_col_scRGB2BW_8*(R, G, B: float32, g, og: ptr cint): cint

proc vips_pythagoras*(L1, a1, b1, L2, a2, b2: float32): float32
proc vips_col_dE00*(L1, a1, b1, L2, a2, b2: float32): float32
{.pop.}