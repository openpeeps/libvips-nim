import ./types, ./basic, ./image

type
  VipsTextWrap* {.size: sizeof(cint).} = enum
    VIPS_TEXT_WRAP_WORD,
    VIPS_TEXT_WRAP_CHAR,
    VIPS_TEXT_WRAP_WORD_CHAR,
    VIPS_TEXT_WRAP_NONE,
    VIPS_TEXT_WRAP_LAST

  VipsSdfShape* {.size: sizeof(cint).} = enum
    VIPS_SDF_SHAPE_CIRCLE,
    VIPS_SDF_SHAPE_BOX,
    VIPS_SDF_SHAPE_ROUNDED_BOX,
    VIPS_SDF_SHAPE_LINE,
    VIPS_SDF_SHAPE_LAST

{.push cdecl, header: "vips/vips.h".}
proc c_vips_black(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_black", varargs.}
proc c_vips_xyz(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_xyz", varargs.}
proc c_vips_grey(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_grey", varargs.}
proc c_vips_gaussmat(output: ptr ptr VipsImage, sigma, min_ampl: cdouble): cint {.importc: "vips_gaussmat", varargs.}
proc c_vips_logmat(output: ptr ptr VipsImage, sigma, min_ampl: cdouble): cint {.importc: "vips_logmat", varargs.}
proc c_vips_text(output: ptr ptr VipsImage, text: cstring): cint {.importc: "vips_text", varargs.}
proc c_vips_gaussnoise(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_gaussnoise", varargs.}
proc c_vips_eye(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_eye", varargs.}
proc c_vips_sines(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_sines", varargs.}
proc c_vips_zone(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_zone", varargs.}
proc c_vips_sdf(output: ptr ptr VipsImage, width, height: cint, shape: VipsSdfShape): cint {.importc: "vips_sdf", varargs.}
proc c_vips_identity(output: ptr ptr VipsImage): cint {.importc: "vips_identity", varargs.}
proc c_vips_buildlut(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_buildlut", varargs.}
proc c_vips_invertlut(input: ptr VipsImage, output: ptr ptr VipsImage): cint {.importc: "vips_invertlut", varargs.}
proc c_vips_tonelut(output: ptr ptr VipsImage): cint {.importc: "vips_tonelut", varargs.}
proc c_vips_mask_ideal(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff: cdouble): cint {.importc: "vips_mask_ideal", varargs.}
proc c_vips_mask_ideal_ring(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff, ringwidth: cdouble): cint {.importc: "vips_mask_ideal_ring", varargs.}
proc c_vips_mask_ideal_band(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff_x, frequency_cutoff_y, radius: cdouble): cint {.importc: "vips_mask_ideal_band", varargs.}
proc c_vips_mask_butterworth(output: ptr ptr VipsImage, width, height: cint, order, frequency_cutoff, amplitude_cutoff: cdouble): cint {.importc: "vips_mask_butterworth", varargs.}
proc c_vips_mask_butterworth_ring(output: ptr ptr VipsImage, width, height: cint, order, frequency_cutoff, amplitude_cutoff, ringwidth: cdouble): cint {.importc: "vips_mask_butterworth_ring", varargs.}
proc c_vips_mask_butterworth_band(output: ptr ptr VipsImage, width, height: cint, order, frequency_cutoff_x, frequency_cutoff_y, radius, amplitude_cutoff: cdouble): cint {.importc: "vips_mask_butterworth_band", varargs.}
proc c_vips_mask_gaussian(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff, amplitude_cutoff: cdouble): cint {.importc: "vips_mask_gaussian", varargs.}
proc c_vips_mask_gaussian_ring(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff, amplitude_cutoff, ringwidth: cdouble): cint {.importc: "vips_mask_gaussian_ring", varargs.}
proc c_vips_mask_gaussian_band(output: ptr ptr VipsImage, width, height: cint, frequency_cutoff_x, frequency_cutoff_y, radius, amplitude_cutoff: cdouble): cint {.importc: "vips_mask_gaussian_band", varargs.}
proc c_vips_mask_fractal(output: ptr ptr VipsImage, width, height: cint, fractal_dimension: cdouble): cint {.importc: "vips_mask_fractal", varargs.}
proc c_vips_fractsurf(output: ptr ptr VipsImage, width, height: cint, fractal_dimension: cdouble): cint {.importc: "vips_fractsurf", varargs.}
proc c_vips_worley(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_worley", varargs.}
proc c_vips_perlin(output: ptr ptr VipsImage, width, height: cint): cint {.importc: "vips_perlin", varargs.}
{.pop.}

# Safe wrappers
proc vips_black*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_black(output, width.cint, height.cint, nil)
proc vips_xyz*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_xyz(output, width.cint, height.cint, nil)
proc vips_grey*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_grey(output, width.cint, height.cint, nil)
proc vips_gaussmat*(output: ptr ptr VipsImage, sigma, min_ampl: float): cint =
  c_vips_gaussmat(output, sigma.cdouble, min_ampl.cdouble, nil)
proc vips_logmat*(output: ptr ptr VipsImage, sigma, min_ampl: float): cint =
  c_vips_logmat(output, sigma.cdouble, min_ampl.cdouble, nil)
proc vips_text*(output: ptr ptr VipsImage, text: string): cint =
  c_vips_text(output, text.cstring, nil)
proc vips_gaussnoise*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_gaussnoise(output, width.cint, height.cint, nil)
proc vips_eye*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_eye(output, width.cint, height.cint, nil)
proc vips_sines*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_sines(output, width.cint, height.cint, nil)
proc vips_zone*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_zone(output, width.cint, height.cint, nil)
proc vips_sdf*(output: ptr ptr VipsImage, width, height: int, shape: VipsSdfShape): cint =
  c_vips_sdf(output, width.cint, height.cint, shape, nil)
proc vips_identity*(output: ptr ptr VipsImage): cint =
  c_vips_identity(output, nil)
proc vips_buildlut*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_buildlut(input, output, nil)
proc vips_invertlut*(input: ptr VipsImage, output: ptr ptr VipsImage): cint =
  c_vips_invertlut(input, output, nil)
proc vips_tonelut*(output: ptr ptr VipsImage): cint =
  c_vips_tonelut(output, nil)
proc vips_mask_ideal*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff: float): cint =
  c_vips_mask_ideal(output, width.cint, height.cint, frequency_cutoff.cdouble, nil)
proc vips_mask_ideal_ring*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff, ringwidth: float): cint =
  c_vips_mask_ideal_ring(output, width.cint, height.cint, frequency_cutoff.cdouble, ringwidth.cdouble, nil)
proc vips_mask_ideal_band*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff_x, frequency_cutoff_y, radius: float): cint =
  c_vips_mask_ideal_band(output, width.cint, height.cint, frequency_cutoff_x.cdouble, frequency_cutoff_y.cdouble, radius.cdouble, nil)
proc vips_mask_butterworth*(output: ptr ptr VipsImage, width, height: int, order, frequency_cutoff, amplitude_cutoff: float): cint =
  c_vips_mask_butterworth(output, width.cint, height.cint, order.cdouble, frequency_cutoff.cdouble, amplitude_cutoff.cdouble, nil)
proc vips_mask_butterworth_ring*(output: ptr ptr VipsImage, width, height: int, order, frequency_cutoff, amplitude_cutoff, ringwidth: float): cint =
  c_vips_mask_butterworth_ring(output, width.cint, height.cint, order.cdouble, frequency_cutoff.cdouble, amplitude_cutoff.cdouble, ringwidth.cdouble, nil)
proc vips_mask_butterworth_band*(output: ptr ptr VipsImage, width, height: int, order, frequency_cutoff_x, frequency_cutoff_y, radius, amplitude_cutoff: float): cint =
  c_vips_mask_butterworth_band(output, width.cint, height.cint, order.cdouble, frequency_cutoff_x.cdouble, frequency_cutoff_y.cdouble, radius.cdouble, amplitude_cutoff.cdouble, nil)
proc vips_mask_gaussian*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff, amplitude_cutoff: float): cint =
  c_vips_mask_gaussian(output, width.cint, height.cint, frequency_cutoff.cdouble, amplitude_cutoff.cdouble, nil)
proc vips_mask_gaussian_ring*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff, amplitude_cutoff, ringwidth: float): cint =
  c_vips_mask_gaussian_ring(output, width.cint, height.cint, frequency_cutoff.cdouble, amplitude_cutoff.cdouble, ringwidth.cdouble, nil)
proc vips_mask_gaussian_band*(output: ptr ptr VipsImage, width, height: int, frequency_cutoff_x, frequency_cutoff_y, radius, amplitude_cutoff: float): cint =
  c_vips_mask_gaussian_band(output, width.cint, height.cint, frequency_cutoff_x.cdouble, frequency_cutoff_y.cdouble, radius.cdouble, amplitude_cutoff.cdouble, nil)
proc vips_mask_fractal*(output: ptr ptr VipsImage, width, height: int, fractal_dimension: float): cint =
  c_vips_mask_fractal(output, width.cint, height.cint, fractal_dimension.cdouble, nil)
proc vips_fractsurf*(output: ptr ptr VipsImage, width, height: int, fractal_dimension: float): cint =
  c_vips_fractsurf(output, width.cint, height.cint, fractal_dimension.cdouble, nil)
proc vips_worley*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_worley(output, width.cint, height.cint, nil)
proc vips_perlin*(output: ptr ptr VipsImage, width, height: int): cint =
  c_vips_perlin(output, width.cint, height.cint, nil)
