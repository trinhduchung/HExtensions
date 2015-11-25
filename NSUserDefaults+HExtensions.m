//
//  NSUserDefaults+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSUserDefaults+HExtensions.h"

@implementation NSUserDefaults (HExtensions)

+ (void)saveObject:(id)object forKey:(NSString *)key {
    NSUserDefaults *userDefaults = [self standardUserDefaults];
    [userDefaults setObject:object forKey:key];
    [userDefaults synchronize];
}

+ (void)deleteObjectForKey:(NSString *)key {
    NSUserDefaults *userDefaults = [self standardUserDefaults];
    [userDefaults removeObjectForKey:key];
    [userDefaults synchronize];
}

+ (id)objectForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    
    return [[self standardUserDefaults] objectForKey:key];
}

@end
