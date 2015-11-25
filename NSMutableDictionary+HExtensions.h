//
//  NSMutableDictionary+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (HExtensions)

- (void)setObject:(id)anObject forNonNullKey:(id<NSCopying>)aKey;

@end
