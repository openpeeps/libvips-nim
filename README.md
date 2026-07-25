<p align="center">
  👑 Nim bindings for the libvips image processing library.<br>
  <a href="https://github.com/libvips/libvips">libvips</a> is a fast image processing library with low memory needs.
</p>

<p align="center">
  <code>nimble install libvips</code>
</p>

<p align="center">
  <a href="https://openpeeps.github.io/libvips-nim/">API reference</a><br>
  <img src="https://github.com/openpeeps/libvips-nim/workflows/test/badge.svg" alt="Github Actions">  <img src="https://github.com/openpeeps/libvips-nim/workflows/docs/badge.svg" alt="Github Actions">
</p>


## A lightning fast image processing and resizing library for Nim 

This package wraps the core functionality of [libvips](https://github.com/libvips/libvips) image processing library by exposing all image operations on first-class types in Nim language.

Libvips is generally 4-8x faster than other graphics processors such as GraphicsMagick and ImageMagick. Check the benchmark: [Speed and Memory Use](https://github.com/libvips/libvips/wiki/Speed-and-memory-use)

The intent for this is to enable developers to build extremely fast image processors in Nim language, which is suited well for concurrent requests.

## Examples

```nim
import libvips/api

## Resize an image and save as JPEG
initVips:
  let img = openImage("input.jpg")
  img.resize(0.5).sharpen().save("output.jpg")

## Create a thumbnail from a file
initVips:
  let thumb = thumbnailFromFile("input.jpg", 300)
  thumb.save("thumb.jpg")

## Rotate, crop, and apply filters
initVips:
  let img = openImage("input.jpg")
  let result = img.rotate(90).crop(100, 100, 400, 400).blur(2.0).invert()
  result.save("processed.jpg")

## Colourspace conversion
initVips:
  let img = openImage("input.jpg")
  img.toGrayscale().save("grey.jpg")
  img.toCMYK().save("cmyk.tif")

## Composite with blend modes
initVips:
  let base = openImage("background.jpg")
  let overlay = openImage("overlay.png")
  base.blendOver(overlay).save("over.jpg")
  base.blendMultiply(overlay).save("multiply.jpg")

## Watermark with alignment
initVips:
  let img = openImage("photo.jpg")
  let wm = openImage("watermark.png").resize(0.3)
  img.watermark(wm, VAlignBottom, HAlignRight).save("watermarked.jpg")

## Save to a specific format
initVips:
  let img = openImage("input.jpg")
  img.savePNG("output.png")
  img.saveWebP("output.webp", quality=80)
  img.saveJPEG("output.jpg", quality=85)

## Image analysis
initVips:
  let img = openImage("input.jpg")
  echo img.avg()         ## average pixel value
  echo img.min()         ## minimum pixel value
  echo img.max()         ## maximum pixel value
  echo img.deviate()     ## standard deviation

## Edge detection
initVips:
  let img = openImage("input.jpg")
  img.sobel().scale().castUchar().save("edges.jpg")
  img.canny().scale().castUchar().save("canny.jpg")

## Open in-memory buffers
initVips:
  let bytes = readFile("input.jpg")
  let img = openBuffer(bytes)
  img.resize(0.5).save("output.jpg")
```

### ❤ Contributions & Support
- 🐛 Found a bug? [Create a new Issue](https://github.com/openpeeps/libvips-nim/issues)
- 👋 Wanna help? [Fork it!](https://github.com/openpeeps/libvips-nim/fork)

### 🎩 License
MIT license. [Made by Humans from OpenPeeps](https://github.com/openpeeps).<br>
Copyright OpenPeeps & Contributors &mdash; All rights reserved.
