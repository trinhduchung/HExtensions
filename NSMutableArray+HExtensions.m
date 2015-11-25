//
//  NSMutableArray+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSMutableArray+HExtensions.h"

@implementation NSMutableArray (HExtensions)


- (BOOL)addObjectWithCheckingNil:(id)anObject {
    if (anObject) {
        [self addObject:anObject];
        
        return YES;
    }
    
    return NO;
}

- (BOOL)addObjectsFromArrayWithCheckingNil:(NSArray *)otherArray {
    if (otherArray) {
        [self addObjectsFromArray:otherArray];
        
        return YES;
    }
    
    return NO;
}

@end
