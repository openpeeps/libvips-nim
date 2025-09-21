switch("path", "$projectDir/../src")

when defined(osx):
  switch("passC", "-I/opt/local/include -I/opt/local/include/glib-2.0/ -I/opt/local/lib/glib-2.0/include")
  switch("passL", "-L/opt/local/lib -lvips -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lpthread")
elif defined(linux):
  switch("passC", "-I/usr/local/include -I/usr/local/include/glib-2.0 -I/usr/local/lib/glib-2.0/include")
  switch("passL", "-L/usr/local/lib -lvips -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lpthread")
elif defined(windows):
  switch("passC", "-IC:/msys64/mingw64/include -IC:/msys64/mingw64/include/glib-2.0 -IC:/msys64/mingw64/lib/glib-2.0/include")
  switch("passL", "-LC:/msys64/mingw64/lib -lvips-cpp -lvips -lgobject-2.0 -lglib-2.0 -lgmodule-2.0 -lpthread")