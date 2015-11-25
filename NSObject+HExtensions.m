//
//  NSObject+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSObject+HExtensions.h"

@implementation NSObject (HExtensions)

+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [[self class] className];
}

@end
