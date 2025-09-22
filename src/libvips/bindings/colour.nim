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

# Low-level C procs (private)
{.push cdecl, header: "vips/vips.h".}
proc c_vips_colourspace(img: ptr VipsImage, `out`: ptr ptr VipsImage, space: VipsInterpretation): cint {.importc: "vips_colourspace", varargs.}
proc c_vips_LabQ2sRGB(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LabQ2sRGB", varargs.}
proc c_vips_rad2float(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_rad2float", varargs.}
proc c_vips_float2rad(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_float2rad", varargs.}
proc c_vips_LabS2LabQ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LabS2LabQ", varargs.}
proc c_vips_LabQ2LabS(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LabQ2LabS", varargs.}
proc c_vips_LabQ2Lab(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LabQ2Lab", varargs.}
proc c_vips_Lab2LabQ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_Lab2LabQ", varargs.}
proc c_vips_LCh2Lab(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LCh2Lab", varargs.}
proc c_vips_Lab2LCh(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_Lab2LCh", varargs.}
proc c_vips_Lab2XYZ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_Lab2XYZ", varargs.}
proc c_vips_XYZ2Lab(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_XYZ2Lab", varargs.}
proc c_vips_XYZ2scRGB(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_XYZ2scRGB", varargs.}
proc c_vips_scRGB2sRGB(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_scRGB2sRGB", varargs.}
proc c_vips_scRGB2BW(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_scRGB2BW", varargs.}
proc c_vips_sRGB2scRGB(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_sRGB2scRGB", varargs.}
proc c_vips_scRGB2XYZ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_scRGB2XYZ", varargs.}
proc c_vips_HSV2sRGB(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_HSV2sRGB", varargs.}
proc c_vips_sRGB2HSV(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_sRGB2HSV", varargs.}
proc c_vips_LCh2CMC(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LCh2CMC", varargs.}
proc c_vips_CMC2LCh(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_CMC2LCh", varargs.}
proc c_vips_XYZ2Yxy(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_XYZ2Yxy", varargs.}
proc c_vips_Yxy2XYZ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_Yxy2XYZ", varargs.}
proc c_vips_LabS2Lab(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_LabS2Lab", varargs.}
proc c_vips_Lab2LabS(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_Lab2LabS", varargs.}
proc c_vips_CMYK2XYZ(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_CMYK2XYZ", varargs.}
proc c_vips_XYZ2CMYK(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_XYZ2CMYK", varargs.}
proc c_vips_profile_load(name: cstring, profile: ptr ptr VipsBlob): cint {.importc: "vips_profile_load", varargs.}
proc c_vips_icc_present(): cint {.importc: "vips_icc_present", varargs.}
proc c_vips_icc_transform(img: ptr VipsImage, `out`: ptr ptr VipsImage, `output_profile`: cstring): cint {.importc: "vips_icc_transform", varargs.}
proc c_vips_icc_import(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_icc_import", varargs.}
proc c_vips_icc_export(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_icc_export", varargs.}
proc c_vips_dE76(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_dE76", varargs.}
proc c_vips_dE00(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_dE00", varargs.}
proc c_vips_dECMC(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint {.importc: "vips_dECMC", varargs.}
{.pop.}

{.push cdecl, importc, header: "vips/colour.h".}
proc vips_colourspace_issupported*(image: ptr VipsImage): bool
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



# Safe wrappers (exported)
proc vips_colourspace*(img: ptr VipsImage, `out`: ptr ptr VipsImage, space: VipsInterpretation): cint =
  c_vips_colourspace(img, `out`, space)

proc vips_LabQ2sRGB*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LabQ2sRGB(img, `out`)

proc vips_rad2float*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_rad2float(img, `out`)

proc vips_float2rad*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_float2rad(img, `out`)

proc vips_LabS2LabQ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LabS2LabQ(img, `out`)

proc vips_LabQ2LabS*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LabQ2LabS(img, `out`)

proc vips_LabQ2Lab*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LabQ2Lab(img, `out`)

proc vips_Lab2LabQ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_Lab2LabQ(img, `out`)

proc vips_LCh2Lab*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LCh2Lab(img, `out`)

proc vips_Lab2LCh*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_Lab2LCh(img, `out`)

proc vips_Lab2XYZ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_Lab2XYZ(img, `out`)

proc vips_XYZ2Lab*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_XYZ2Lab(img, `out`)

proc vips_XYZ2scRGB*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_XYZ2scRGB(img, `out`)

proc vips_scRGB2sRGB*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_scRGB2sRGB(img, `out`)

proc vips_scRGB2BW*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_scRGB2BW(img, `out`)

proc vips_sRGB2scRGB*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_sRGB2scRGB(img, `out`)

proc vips_scRGB2XYZ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_scRGB2XYZ(img, `out`)

proc vips_HSV2sRGB*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_HSV2sRGB(img, `out`)

proc vips_sRGB2HSV*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_sRGB2HSV(img, `out`)

proc vips_LCh2CMC*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LCh2CMC(img, `out`)

proc vips_CMC2LCh*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_CMC2LCh(img, `out`)

proc vips_XYZ2Yxy*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_XYZ2Yxy(img, `out`)

proc vips_Yxy2XYZ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_Yxy2XYZ(img, `out`)

proc vips_LabS2Lab*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_LabS2Lab(img, `out`)

proc vips_Lab2LabS*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_Lab2LabS(img, `out`)

proc vips_CMYK2XYZ*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_CMYK2XYZ(img, `out`)

proc vips_XYZ2CMYK*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_XYZ2CMYK(img, `out`)

proc vips_profile_load*(name: cstring, profile: ptr ptr VipsBlob): cint =
  c_vips_profile_load(name, profile)

proc vips_icc_present*(): cint =
  c_vips_icc_present()

proc vips_icc_transform*(img: ptr VipsImage, `out`: ptr ptr VipsImage, `output_profile`: cstring): cint =
  c_vips_icc_transform(img, `out`, `output_profile`)

proc vips_icc_import*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_icc_import(img, `out`)

proc vips_icc_export*(img: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_icc_export(img, `out`)

proc vips_dE76*(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_dE76(left, right, `out`)

proc vips_dE00*(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_dE00(left, right, `out`)

proc vips_dECMC*(left: ptr VipsImage, right: ptr VipsImage, `out`: ptr ptr VipsImage): cint =
  c_vips_dECMC(left, right, `out`)