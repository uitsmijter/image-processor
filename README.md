# Image Processor
Resizes images and generate different formats from original images

## Overview
```
Resize images in various formats: 

        -i |         input folder
        -o |         output folder
        -s |         sizes to generate

 Formats generated: jpeg, webp, avif
```

Using different image file formats like JPEG, WebP, and AVIF for the web is important 
because each format has its own set of advantages and disadvantages, and the choice of 
format depends on various factors including the content of the image, the target audience,
and the performance requirements of your website. Here's why you might consider using 
these different formats:

1. JPEG (Joint Photographic Experts Group):
   - JPEG is a widely supported and highly compatible image format that has been around 
     for a long time.
   - It is excellent for photographs and images with many colors and gradients.
   - JPEG offers good compression with a minimal loss of image quality, making it suitable 
     for a wide range of web images.
   - It is the standard format for photographic images and works well in most situations.

2. WebP:
   - WebP is a modern image format developed by Google. It provides better compression 
     than JPEG while maintaining similar image quality.
   - WebP is particularly effective for images with large areas of uniform color, such as 
     logos, icons, and graphics.
   - It supports both lossless and lossy compression, allowing you to choose the level of 
     compression that suits your needs.
   - WebP images load faster, saving bandwidth and improving web page performance.

3. AVIF (AV1 Image File Format):
   - AVIF is an emerging image format based on the AV1 video codec, which offers even 
     better compression than WebP and JPEG while maintaining high image quality.
   - It is especially efficient for images with a lot of detail, textures, and gradients.
   - AVIF supports both lossless and lossy compression and can provide smaller file sizes 
     compared to WebP in many cases.
   - However, support for AVIF is still evolving, and not all web browsers may fully 
     support it at the time of your development.

When deciding which format to use, consider the following factors:

1. Browser Support: Check the current browser support for each format. As of my last 
   update in September 2021, WebP had good support in most modern browsers, while AVIF 
   was gaining traction. However, it's essential to check for the latest browser support 
   statistics.

2. Content Type: Consider the type of content you are displaying. Photographs may work 
   well with JPEG, while icons and graphics may benefit from WebP or AVIF.

3. Compression Needs: Evaluate the level of compression required. If you need the smallest 
   file size possible without significant quality loss, WebP and AVIF are strong choices.

4. Performance Goals: If improving website performance and reducing loading times are 
   essential, consider using formats like WebP or AVIF, which typically result in smaller 
   file sizes compared to JPEG.

5. Fallbacks: Provide fallbacks for older browsers that do not support newer image 
   formats. You can use the `<picture>` element or feature detection to serve appropriate 
   formats to different browsers.

In summary, using a combination of image formats like JPEG, WebP, and AVIF allows you to 
optimize your web images for different scenarios, providing a better user experience and 
improved performance across a wide range of devices and browsers. Keep in mind that the 
landscape of web technologies may have evolved since my last update, so it's essential to 
stay up-to-date with the latest best practices and browser support information.

## Installation

Pull the latest docker image from the registry: 
```shell
docker pull ghcr.io/uitsmijter/image-processor:latest
```

## Usage

You need two directories, one with the original images the other (empty) directory 
is for the generated images.

For example the original images are located in `./graphics` and the generated once should 
be placed in `./public`. From the original images you want to have 4 different sizes with 
a width of 3840px, 1920px, 1280px and 640px

```shell
docker run \
  -ti \ 
  --rm \
  -v ${PWD}/graphics:/processor/source \
  -v ${PWD}/public:/processor/target
  ghcr.io/uitsmijter/image-processor:latest -i /processor/source -o /processor/target -s "3840 1920 1280 640"
```

Use the newly generated images in your html source-set: 
```html
<picture>
  <source srcset="./3840/image.avif 3840w, ./1920/image.avif 1920w, ./1280/image.avif 1280w, ./640/image.avif 640w" type="image/avif">
  <source srcset="./3840/image.webp 3840w, ./1920/image.webp 1920w, ./1280/image.webp 1280w, ./640/image.webp 640w" type="image/webp">
  <source srcset="./3840/image.jpeg 3840w, ./1920/image.jpeg 1920w, ./1280/image.jpeg 1280w, ./640/image.jpeg 640w" type="image/jpeg">
  <img src="image.jpg" alt="Description">
</picture>
```
