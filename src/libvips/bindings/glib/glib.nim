type
  GObject* = object
    # Opaque type, actual fields are not exposed

  GObjectClass* = object of RootObj

  GSList* = object
    data*: pointer
    next*: ptr GSList

  GType* = culong      # GLib's GType is usually an unsigned long

  GMutex* = object     # Opaque struct, size depends on platform
    dummy: array[8, byte] # 8 bytes is typical for pthread mutex on most platforms

  GValue* = object
    dummy: array[24, byte] # GLib's GValue is typically 24 bytes on 64-bit platforms
  
  GParamSpec* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  GOptionGroup* = object
    dummy: array[16, byte] # Size can vary; 16 bytes is a common minimum

  gboolean* = cint
  guint* = uint
  guint64* = uint64
  guint32* = uint32
  gint64* = int64
  gint32* = int32

{.push cdecl, importc, header: "glib-object.h".}
proc g_object_unref*(obj: pointer)
{.pop.}
