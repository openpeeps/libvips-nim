<p align="center">
  Nim bindings for the libvips image processing library.<br>
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

## Getting Started

### Resize and sharpen

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.resize(0.5).sharpen().save("output.jpg")
```

### Create thumbnails

```nim
import libvips/api

initVips:
  let thumb = thumbnailFromFile("input.jpg", 300)
  thumb.save("thumb.jpg")
```

Thumbnails can also be created from buffers:

```nim
import libvips/api

initVips:
  let bytes = readFile("photo.jpg")
  let thumb = thumbnailFromBuffer(bytes, 300)
  thumb.save("thumb.jpg")
```

### Rotate, crop, and apply filters

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let result = img.rotate(90).crop(100, 100, 400, 400).blur(2.0).invert()
  result.save("processed.jpg")
```

### Smart crop

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.smartCrop(300, 300).save("smart.jpg")
  img.smartCrop(300, 300, VIPS_INTERESTING_ENTROPY).save("entropy.jpg")
```

### Gravity crop

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.gravityCrop(400, 400, VIPS_COMPASS_DIRECTION_NORTH).save("north.jpg")
  img.gravityCrop(400, 400, VIPS_COMPASS_DIRECTION_SOUTH_EAST).save("se.jpg")
```

### Colourspace conversion

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.toGrayscale().save("grey.jpg")
  img.toCMYK().save("cmyk.tif")
  img.toLAB().save("lab.tif")
  img.toHSV().save("hsv.tif")
```

### Composite with blend modes

```nim
import libvips/api

initVips:
  let base = openImage("background.jpg")
  let overlay = openImage("overlay.png")
  base.blendOver(overlay).save("over.jpg")
  base.blendMultiply(overlay).save("multiply.jpg")
  base.blendScreen(overlay).save("screen.jpg")
```

### Conditional composition (ifThenElse)

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let threshold = img.bandMean()
  let bright = img.linear1(1.2, 0)
  let dark = img.linear1(0.8, 0)
  let result = threshold.ifThenElse(bright, dark)
  result.save("adjusted.jpg")
```

### Band recombination

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  # Convert to grayscale using perceptual weights
  let grey = img.recomb([
    [0.299, 0.587, 0.114],
    [0.299, 0.587, 0.114],
    [0.299, 0.587, 0.114]
  ])
  grey.save("grey_recomb.jpg")
```

### Join images

```nim
import libvips/api

initVips:
  let left = openImage("left.jpg")
  let right = openImage("right.jpg")
  left.joinHorizontal(right).save("panorama.jpg")
  left.joinVertical(right).save("stacked.jpg")
```

### Replicate (tile) an image

```nim
import libvips/api

initVips:
  let tile = openImage("tile.jpg")
  tile.replicate(4, 4).save("tiled.jpg")
```

### Zoom and subsample

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.zoom(2, 2).save("zoomed.jpg")    # nearest-neighbor upscale
  img.subsample(2, 2).save("down.jpg") # nearest-neighbor downsample
```

### Watermark with alignment

```nim
import libvips/api

initVips:
  let img = openImage("photo.jpg")
  let wm = openImage("watermark.png").resize(0.3)
  img.watermark(wm, VAlignBottom, HAlignRight).save("watermarked.jpg")
```

### Embed with padding

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.embed(50, 50, 400, 400, VIPS_EXTEND_REPEAT).save("padded.jpg")
  img.embed(100, 50, 600, 400, VIPS_EXTEND_WHITE).save("white_pad.jpg")
```

### Save to a specific format

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.savePNG("output.png")
  img.saveWebP("output.webp", quality=80)
  img.saveJPEG("output.jpg", quality=85)
  img.saveTIFF("output.tif")
  img.saveHEIF("output.heif", quality=60)
  img.saveJXL("output.jxl", quality=80)
```

### Save as GIF

```nim
import libvips/api

initVips:
  let img = openImage("input.png")
  img.saveGIF("output.gif")
```

### Load a GIF

```nim
import libvips/api

initVips:
  let gif = loadGIF("animation.gif")
  gif.save("frame.png")
```

### Save to buffer

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let jpegBuf = img.saveJPEG(quality=90)
  let pngBuf = img.savePNG(compression=9)
  let webpBuf = img.saveWebP(quality=80)
  discard jpegBuf
```

### Open in-memory buffers

```nim
import libvips/api

initVips:
  let bytes = readFile("input.jpg")
  let img = openBuffer(bytes)
  img.resize(0.5).save("output.jpg")
```

## Analysis

### Basic statistics

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  echo img.avg()         ## average pixel value
  echo img.min()         ## minimum pixel value
  echo img.max()         ## maximum pixel value
  echo img.deviate()     ## standard deviation
```

### Detailed per-band statistics

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let s = img.stats()
  for band in s:
    echo "min=", band[0], " max=", band[1], " mean=", band[4]
```

### Find trim bounds

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let (left, top, width, height) = img.findTrim()
  echo "content starts at (", left, ",", top, ") size ", width, "x", height
```

### Get pixel value

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let pixel = img.getPoint(100, 200)
  echo "R=", pixel[0], " G=", pixel[1], " B=", pixel[2]
```

### Histogram and equalisation

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.histogram().save("hist.jpg")
  let data = img.histogramData(bins=64)
  echo "bins: ", data.len
  let cum = img.cumulativeHistogram(bins=64)
  echo "cumulative: ", cum[^1]
  img.equalize().save("equalized.jpg")
```

## Colour Analysis

### Dominant colours

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  let colors = img.dominantColors(count=5, accuracy=10)
  for c in colors:
    echo "RGB(", c.r, ", ", c.g, ", ", c.b, ") count=", c.count
```

### Colour difference (Delta E)

```nim
import libvips/api

initVips:
  let img1 = openImage("photo1.jpg")
  let img2 = openImage("photo2.jpg")
  echo "dE76: ", img1.deltaE(img2, dE76)
  echo "dE00: ", img1.deltaE(img2, dE00)
  echo "dECMC: ", img1.deltaE(img2, dECMC)
```

## Edge Detection

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.sobel().scale().castUchar().save("sobel.jpg")
  img.scharr().scale().castUchar().save("scharr.jpg")
  img.prewitt().scale().castUchar().save("prewitt.jpg")
  img.canny().scale().castUchar().save("canny.jpg")
```

## Gamma correction

```nim
import libvips/api

initVips:
  let img = openImage("input.jpg")
  img.gamma(2.2).save("gamma_22.jpg")
  img.gamma(0.5).save("bright.jpg")
```

## Metadata

```nim
import libvips/api

initVips:
  let img = openImage("photo.jpg")
  echo img.getMetadata("image-description")
  echo img.getMetadataInt("orientation")
  img.setMetadata("image-description", "My photo")
```

### Strip metadata

```nim
import libvips/api

initVips:
  let img = openImage("photo.jpg")
  img.stripMetadata().save("clean.jpg")
```

## Cache and Performance Tuning

```nim
import libvips/api

initVips:
  setConcurrency(8)
  setCache(maxImages=100, maxMemory=50_000_000)
  echo "threads: ", getConcurrency()
```

## Accelerated mode

```nim
import libvips/api

init_vips_accelerated(4):
  let img = openImage("input.jpg")
  img.resize(0.5).save("output.jpg")
```

## Method chaining

All operations return a new `Image`, so you can chain them fluently:

```nim
import libvips/api

initVips:
  let result = openImage("input.jpg")
    .resize(800)
    .sharpen()
    .gamma(2.2)
    .toSRGB()
  result.save("final.jpg")
```

### Contributions & Support
- Found a bug? [Create a new Issue](https://github.com/openpeeps/libvips-nim/issues)
- Want to help? [Fork it!](https://github.com/openpeeps/libvips-nim/fork)

### License
MIT license. [Made by Humans from OpenPeeps](https://github.com/openpeeps).<br>
Copyright OpenPeeps & Contributors. All rights reserved.
