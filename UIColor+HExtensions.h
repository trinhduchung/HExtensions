//
//  UIColor+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark -
#pragma mark Macros

@interface UIColor (HExtensions)
+ (UIColor *)colorWithHex:(CGFloat)hex;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

@end
