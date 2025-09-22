# Nim bindings for Libvips
# 
# Official Repository: https://github.com/libvips/libvips/
#
# (c) 2025 George Lemon | MIT License
#          Made by Humans from OpenPeeps
#          https://github.com/openpeeps/libvips-nim

import basic, header, image, conversion,
    resample, convolution, colour, foreign,

    arithmetic, error

export basic, header, image, conversion,
    resample, convolution, colour, foreign,

    arithmetic, error

{.push cdecl, importc, header: "vips/vips.h".}

proc vips_max_coord_get*(): cint
proc vips_init*(argv0: cstring): cint
proc vips_get_argv0*(): cstring
proc vips_get_prgname*(): cstring
proc vips_shutdown*()
proc vips_thread_shutdown*()

proc vips_add_option_entries*(option_group: pointer)

proc vips_leak_set*(leak: bool)
proc vips_block_untrusted_set*(state: bool)

proc vips_version_string*(): cstring
proc vips_version*(flag: cint): cint

proc vips_guess_prefix*(argv0, env_name: cstring): cstring
proc vips_guess_libdir*(argv0, env_name: cstring): cstring

{.pop.}