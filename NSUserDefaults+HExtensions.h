//
//  NSUserDefaults+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/25/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (HExtensions)
+ (void)saveObject:(id)object forKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
@end
