//
//  UIGestureRecognizer+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>
//https://www.cocoanetics.com/2012/06/associated-objects/
@interface UIGestureRecognizer (HExtensions)

- (instancetype)initWithGestureActionBlock:(void(^)(UIGestureRecognizer *gesture))actionBlock;

@end
