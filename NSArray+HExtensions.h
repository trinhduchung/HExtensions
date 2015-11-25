//
//  NSArray+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HExtensions)
- (NSArray *)reverse;
- (NSArray *)shuffle;
- (id)randomObject;
- (NSArray *)minus:(NSArray *)anotherArray;
- (NSArray *)uniques;
+ (NSArray *)flatten:(NSArray *)arraysOfArray;
- (NSArray *)groupedBy:(NSInteger)number;
@end

@interface NSArray (Sort)
- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending;
- (NSArray *)localizedCompare;
- (NSArray *)compare;
@end

@interface NSArray (Operator)
- (NSInteger)sum;
@end

@interface NSArray (Enumeration)
- (void)each:(void (^)(id object))block;
- (void)eachWithIndex:(void (^)(id object, NSUInteger index))block;
- (NSArray *)map:(id (^)(id object))block;
- (NSArray *)filter:(BOOL (^)(id object))block;
- (NSArray *)reject:(BOOL (^)(id object))block;
- (id)detect:(BOOL (^)(id object))block;
- (id)reduce:(id (^)(id accumulator, id object))block;
- (id)reduce:(id)initial withBlock:(id (^)(id accumulator, id object))block;
@end