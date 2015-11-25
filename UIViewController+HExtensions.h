//
//  UIViewController+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HExtensions)
- (void)addChildViewController:(UIViewController *)childVC containerView:(UIView *)containerView;
@end

@interface UIViewController (Storyboard)
+ (instancetype)instantiateFromStoryboardNamed:(NSString *)name;
+ (instancetype)instantiateFromStoryboardNamed:(NSString *)name viewControllerStoryboardID:(NSString *)VCStoryboardID;
@end
