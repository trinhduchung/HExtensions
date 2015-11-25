//
//  UINavigationController+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (HExtensions)
+ (UIViewController *)topViewController;
+ (UIViewController *)topViewController:(UIViewController *)rootViewController;
@end
