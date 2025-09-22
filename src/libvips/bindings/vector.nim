import ./glib/glib

{.push cdecl, importc, header: "vips/vector.h".}
proc vips_vector_isenabled*(): gboolean
proc vips_vector_set_enabled*(enabled: gboolean)

proc vips_vector_get_builtin_targets*(): gint64
proc vips_vector_get_supported_targets*(): gint64
proc vips_vector_target_name*(target: gint64): cstring
proc vips_vector_disable_targets*(disabled_targets: gint64)
{.pop.}