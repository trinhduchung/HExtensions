//
//  UIView+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HExtensions)

@end

@interface UIView (AutoLayout)
- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute;
- (NSLayoutConstraint *)leftConstraint;
- (NSLayoutConstraint *)rightConstraint;
- (NSLayoutConstraint *)topConstraint;
- (NSLayoutConstraint *)bottomConstraint;
- (NSLayoutConstraint *)leadingConstraint;
- (NSLayoutConstraint *)trailingConstraint;
- (NSLayoutConstraint *)widthConstraint;
- (NSLayoutConstraint *)heightConstraint;
- (NSLayoutConstraint *)centerXConstraint;
- (NSLayoutConstraint *)centerYConstraint;
- (NSLayoutConstraint *)baseLineConstraint;
@end