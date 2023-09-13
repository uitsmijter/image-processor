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
Using different sizes of images for your HTML page is important for several reasons:

**Responsive Design**: In web development, it's essential to create responsive websites 
that adapt to various screen sizes and devices. By generating different image sizes, you 
can serve appropriately sized images to different devices. This ensures that your web 
pages load quickly and look good on both desktop computers and mobile devices.

**Optimized Loading**: Large images can significantly impact page loading times, 
especially on slow internet connections or mobile networks. By providing smaller image 
sizes for smaller screens, you reduce the amount of data that needs to be downloaded, 
leading to faster page load times.

**Bandwidth Efficiency**: Generating multiple image sizes allows you to serve images that 
are optimized for different screen resolutions and orientations. This reduces the amount 
of unnecessary data transfer and helps conserve bandwidth, which can be particularly 
important for users on limited data plans.

**Improved User Experience**: Faster-loading pages and optimized images contribute to a 
better user experience. Users are more likely to stay on your site and engage with its 
content if they don't have to wait for large images to load.


Overall, using an image generator to produce different image sizes for your HTML page is 
a best practice in web development. It helps you create a more efficient, user-friendly, 
and responsive website that caters to a wide range of devices and screen sizes.

**Using an image generator to create different sizes is important because it eliminates the 
need to manually edit multiple images.**

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

When deciding which format to use, consider the factor of Browser Support: Check the 
current browser support for each format. WebP had good support in most modern browsers, 
while AVIF was gaining traction. However, it's essential to check for the latest 
browser support statistics.

Provide a fallbacks: Provide fallbacks for older browsers that do not support newer image 
formats. You can use the `<picture>` element or feature detection to serve appropriate 
formats to different browsers.

In summary, using a combination of image formats like JPEG, WebP, and AVIF allows you to 
optimize your web images for different scenarios, providing a better user experience and 
improved performance across a wide range of devices and browsers. Keep in mind that the 
image of web technologies may have evolved since my last update, so it's essential to 
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

In CSS background-tags you can use different formats and sizes this way:
```css
@media screen and (max-width: 640px) {
    .background {
        background-image: -webkit-image-set(
                url("./640/image.avif") 1x,
                url("./640/image.webp") 1x,
                url("./640/image.jpg") 1x,
                url("./1280/image.avif") 2x,
                url("./1280/image.webp") 2x,
                url("./1280/image.jpg") 2x
        );
        background-image: image-set(
                url("./640/image.avif") type("image/avif") 1x,
                url("./640/image.webp") type("image/webp") 1x,
                url("./640/image.jpg") type("image/jpeg") 1x,
                url("./1280/image.avif") type("image/avif") 2x,
                url("./1280/image.webp") type("image/webp") 2x,
                url("./1280/image.jpg") type("image/jpeg") 2x
        );
    }
}

@media screen and (min-width: 640px) {
    .background {
        background-image: -webkit-image-set(
                url("./1920/image.avif") 1x,
                url("./1920/image.webp") 1x,
                url("./1920/image.jpg") 1x,
                url("./3840/image.avif") 2x,
                url("./3840/image.webp") 2x,
                url("./3840/image.jpg") 2x
        );
        background-image: image-set(
                url("./1920/image.avif") type("image/avif") 1x,
                url("./1920/image.webp") type("image/webp") 1x,
                url("./1920/image.jpg") type("image/jpeg") 1x,
                url("./3840/image.avif") type("image/avif") 2x,
                url("./3840/image.webp") type("image/webp") 2x,
                url("./3840/image.jpg") type("image/jpeg") 2x
        );
    }
}

@media screen and (min-width: 1920px) {
    .background {
        background-image: -webkit-image-set(
                url("./3840/image.avif") 1x,
                url("./3840/image.webp") 1x,
                url("./3840/image.jpg") 1x,
                url("./3840/image.avif") 2x,
                url("./3840/image.webp") 2x,
                url("./3840/image.jpg") 2x
        );
        background-image: image-set(
                url("./3840/image.avif") type("image/avif"),
                url("./3840/image.webp") type("image/webp"),
                url("./3840/image.jpg") type("image/jpeg")
        );
    }
}
```

## Contribution

In the interest of fostering an open and welcoming environment, we as contributors and 
maintainers pledge to making participation in our project and our community a 
harassment-free experience for everyone, regardless of age, body size, disability, 
ethnicity, gender identity and expression, level of experience, nationality, personal 
appearance, race, religion, or sexual identity and orientation.


