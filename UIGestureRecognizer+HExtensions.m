//
//  UIGestureRecognizer+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "UIGestureRecognizer+HExtensions.h"
#import <objc/runtime.h>

static void *kActionHandlerTapBlockKey;

@implementation UIGestureRecognizer (HExtensions)

- (instancetype)initWithGestureActionBlock:(void (^)(UIGestureRecognizer *))actionBlock {
    self = [self initWithTarget:self action:@selector(__handleActionForGesture:)];
    
    if (self) {
        objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, actionBlock, OBJC_ASSOCIATION_RETAIN);
    }
    
    return self;
}

- (void)__handleActionForGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}

@end
