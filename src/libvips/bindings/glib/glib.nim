type
  GObject* = object
    # Opaque type, actual fields are not exposed

{.push cdecl, importc, header: "glib-object.h".}
proc g_object_unref*(obj: pointer)
{.pop.}
