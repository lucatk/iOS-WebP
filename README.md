#iOS-WebP

Most apps nowadays enhance user experience with the use of images, and one of the issues I've noticed with that is the amount of time it takes to load an image. (_Not everyone has the luxury of a fast connection_)

Google's WebP image format offers better compression compared to PNG or JPEG, allowing apps to send/retrieve images with smaller file sizes, reducing request times and hopefully provide a better user experience.

![alt demo](http://i.imgur.com/V4fBG1h.png "Demo Screenshot")

#Getting Started

###The CocoaPods Way
```ruby
pod 'iOS-WebP', '0.2'
```

###The Manual Way
Include the 3 files inside the `iOS-WebP` folder into your project:
* `UIImage+WebP.h`
* `UIImage+WebP.m`
* `WebP.framework`

#Usage
Don't forget to `#import "UIImage+WebP.h"` or `#import <UIImage+WebP.h>` if you're using cocoapods.
There are 3 methods in `iOS-WebP`, converting images __to__ WebP format, converting images __from__ WebP format, and setting an image's transparency.
```objc
+ (void)imageToWebP:(UIImage *)image quality:(CGFloat)quality alpha:(CGFloat)alpha preset:(WebPPreset)preset
    completionBlock:(void (^)(NSData *result))completionBlock
       failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)imageFromWebP:(NSString *)filePath
      completionBlock:(void (^)(UIImage *result))completionBlock
         failureBlock:(void (^)(NSError *error))failureBlock;

- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
```

Encoding and decoding of images are done in the background thread and results returned in the completion block on the main thread so as not to lock the main thread, allowing the UI to be updated as needed.

#### Converting To WebP

```objc
// quality value is [0, 100]
// alpha value is [0, 1]
[UIImage imageToWebP:[UIImage imageNamed:@"demo.jpg"] quality:quality alpha:alpha preset:WEBP_PRESET_DEFAULT completionBlock:^(NSData *result) {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *webPPath = [paths[0] stringByAppendingPathComponent:@"image.webp"];
  if (![webPData writeToFile:webPPath atomically:YES]) {
    NSLog(@"Failed to save file");
  }
} failureBlock:^(NSError *error) {
  NSLog(@"%@", error.localizedDescription);
}];
```

######WebPPreset possible values

```objc
typedef enum WebPPreset {
  WEBP_PRESET_DEFAULT = 0,  // default preset.
  WEBP_PRESET_PICTURE,      // digital picture, like portrait, inner shot
  WEBP_PRESET_PHOTO,        // outdoor photograph, with natural lighting
  WEBP_PRESET_DRAWING,      // hand or line drawing, with high-contrast details
  WEBP_PRESET_ICON,         // small-sized colorful images
  WEBP_PRESET_TEXT          // text-like
} WebPPreset;
```

#### Converting From WebP

```objc
[UIImage imageFromWebP:@"/path/to/file" completionBlock:^(UIImage *result) {
  UIImageView *myImageView = [[UIImageView alloc] initWithImage:result];
}failureBlock:^(NSError *error) {
  NSLog(@"%@", error.localizedDescription);
}];
```

#### Setting Image Transparency

```objc
//alpha value is [0, 1]
UIImage *transparencyImage = [[UIImage imageNamed:image.jpg] imageByApplyingAlpha:0.5];
```

Credit
========
* Based off [WebP-iOS-example](https://github.com/carsonmcdonald/WebP-iOS-example "WebP-iOS-example") by Carson McDonald
* `imageByApplyingAlpha:alpha` function contributed by [shmidt](https://github.com/shmidt)