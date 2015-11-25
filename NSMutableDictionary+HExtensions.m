//
//  NSMutableDictionary+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSMutableDictionary+HExtensions.h"

@implementation NSMutableDictionary (HExtensions)

- (void)setObject:(id)anObject forNonNullKey:(id<NSCopying>)aKey {
    if (!aKey)
        return;
    
    [self setObject:anObject forKey:aKey];
}

@end
