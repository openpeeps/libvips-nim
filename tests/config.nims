switch("path", "$projectDir/../src")

when defined(osx):
  switch("passC", "-I/opt/local/include -I/opt/local/include/glib-2.0/ -I/opt/local/lib/glib-2.0/include")
  switch("passL", "-L/opt/local/lib -lvips -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lpthread")
elif defined(linux):
  let cflags = staticExec("pkg-config --cflags vips")
  let libs = staticExec("pkg-config --libs vips")
  switch("passC", cflags)
  switch("passL", libs)
elif defined(windows):
  switch("passC", "-IC:/msys64/mingw64/include -IC:/msys64/mingw64/include/glib-2.0 -IC:/msys64/mingw64/lib/glib-2.0/include")
  switch("passL", "-LC:/msys64/mingw64/lib -lvips-cpp -lvips -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lpthread")