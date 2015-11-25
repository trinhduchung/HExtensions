//
//  NSNull+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSNull+HExtensions.h"

@implementation NSNull (HExtensions)

- (NSUInteger)length { return 0; }

- (NSInteger)integerValue { return 0; };

- (int)intValue { return 0; };

- (float)floatValue { return 0; };

- (NSString *)description { return @""; }

- (NSArray *)componentsSeparatedByString:(NSString *)separator { return @[]; }

- (id)objectForKey:(id)key { return nil; }

- (id)objectForKeyedSubscript:(id)key { return nil; }

- (BOOL)boolValue { return NO; }

@end
