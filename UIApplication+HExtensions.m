//
//  UIApplication+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "UIApplication+HExtensions.h"

@implementation UIApplication (HExtensions)

- (NSString *)name {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)version {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)build {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    return [infoDictionary objectForKey:@"CFBundleVersion"];
}

- (NSString *)bundleIdentifier {
    return [NSBundle mainBundle].bundleIdentifier;
}

@end
