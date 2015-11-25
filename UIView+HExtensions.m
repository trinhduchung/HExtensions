//
//  UIView+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "UIView+HExtensions.h"

@implementation UIView (HExtensions)

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && (firstItem = %@ || secondItem = %@)", attribute, self, self];
    NSArray *constraintArray = [self.superview constraints];
    
    if (attribute == NSLayoutAttributeWidth || attribute == NSLayoutAttributeHeight) {
        constraintArray = [self constraints];
    }
    
    NSArray *fillteredArray = [constraintArray filteredArrayUsingPredicate:predicate];
    if(fillteredArray.count == 0) {
        return nil;
    } else {
        return fillteredArray.firstObject;
    }
}

- (NSLayoutConstraint *)leftConstraint {
    return [self constraintForAttribute:NSLayoutAttributeLeft];
}

- (NSLayoutConstraint *)rightConstraint {
    return [self constraintForAttribute:NSLayoutAttributeRight];
}

- (NSLayoutConstraint *)topConstraint {
    return [self constraintForAttribute:NSLayoutAttributeTop];
}

- (NSLayoutConstraint *)bottomConstraint {
    return [self constraintForAttribute:NSLayoutAttributeBottom];
}

- (NSLayoutConstraint *)leadingConstraint {
    return [self constraintForAttribute:NSLayoutAttributeLeading];
}

- (NSLayoutConstraint *)trailingConstraint {
    return [self constraintForAttribute:NSLayoutAttributeTrailing];
}

- (NSLayoutConstraint *)widthConstraint {
    return [self constraintForAttribute:NSLayoutAttributeWidth];
}

- (NSLayoutConstraint *)heightConstraint {
    return [self constraintForAttribute:NSLayoutAttributeHeight];
}

- (NSLayoutConstraint *)centerXConstraint {
    return [self constraintForAttribute:NSLayoutAttributeCenterX];
}

- (NSLayoutConstraint *)centerYConstraint {
    return [self constraintForAttribute:NSLayoutAttributeCenterY];
}

- (NSLayoutConstraint *)baseLineConstraint {
    return [self constraintForAttribute:NSLayoutAttributeBaseline];
}

@end
