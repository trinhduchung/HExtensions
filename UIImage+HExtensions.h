//
//  UIImage+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HExtensions)

@end

@interface UIImage (DataPresentation)
- (NSData *)JPEGdataWithCompressionQuality:(CGFloat)quality;
- (NSData *)PNGdata;
@end

@interface UIImage (Scale)
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)size;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToMaxWidth:(CGFloat)width maxHeight:(CGFloat)height;
@end
