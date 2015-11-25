//
//  UIViewController+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "UIViewController+HExtensions.h"
#import "NSObject+HExtensions.h"

@implementation UIViewController (HExtensions)

- (void)addChildViewController:(UIViewController *)childVC containerView:(UIView *)containerView {
    [self addChildViewController:childVC];
    [containerView addSubview:childVC.view];
    [childVC didMoveToParentViewController:self];
}

@end

@implementation UIViewController (Storyboard)

+ (instancetype)instantiateFromStoryboardNamed:(NSString *)name {
    return [self instantiateFromStoryboardNamed:name viewControllerStoryboardID:[self className]];
}

+ (instancetype)instantiateFromStoryboardNamed:(NSString *)name viewControllerStoryboardID:(NSString *)VCStoryboardID {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    
    return [storyboard instantiateViewControllerWithIdentifier:VCStoryboardID];
}

@end
