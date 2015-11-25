//
//  NSArray+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSArray+HExtensions.h"

@implementation NSArray (HExtensions)
- (NSArray *)reverse {
    return [[self reverseObjectEnumerator] allObjects];
}

- (NSArray *)shuffle {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    
    const NSUInteger count = self.count;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        const NSUInteger n = arc4random_uniform((uint32_t)(count - i)) + i;
        if (i != n) {
            [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

- (id)randomObject {
    NSUInteger count = self.count;
    if (count > 0) {
        return self[arc4random() % count];
    }
    
    return nil;
}

- (NSArray *)minus:(NSArray *)anotherArray {
    NSMutableSet *set = [NSMutableSet setWithArray:self];
    NSSet *anotherSet = [NSSet setWithArray:anotherArray];
    
    [set minusSet:anotherSet];
    
    return [set allObjects];
}

- (NSArray *)uniques {
    return [[NSOrderedSet orderedSetWithArray:self] array];
}

+ (NSArray *)flatten:(NSArray *)arraysOfArray {
    NSMutableArray *results = [NSMutableArray array];
    for (NSArray *array in arraysOfArray) {
        [results addObjectsFromArray:array];
    }
    
    return results;
}

- (NSArray *)groupedBy:(NSInteger)number {
    if (number == 0) {
        return @[self];
    }
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSInteger remainCount = self.count;
    NSInteger count = 0;
    
    while (count < self.count) {
        NSRange range = NSMakeRange(count, MIN(number, remainCount));
        
        NSArray *subArray = [self subarrayWithRange:range];
        [results addObject:subArray];
        
        remainCount -= range.length;
        count += range.length;
    }
    
    return results;
}

@end

@implementation NSArray (Sort)

- (NSArray *)arraySortedByKey:(NSString *)key ascending:(BOOL)ascending {
    if (!key || key.length == 0) {
        return @[];
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:key
                                                                     ascending:ascending];
    return [self sortedArrayUsingDescriptors:@[sortDescriptor]];
}

- (NSArray *)compare {
    return [self sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)localizedCompare {
    return [self sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

@end

@implementation NSArray (Operator)

- (NSInteger)sum {
    return [[self valueForKeyPath:@"@sum.self"] integerValue];
}

@end


@implementation NSArray (Enumeration)

- (void)each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (void)eachWithIndex:(void (^)(id, NSUInteger))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj, idx);
    }];
}

- (NSArray *)map:(id (^)(id))block {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    
    for (id object in self) {
        [array addObject:block(object) ? : [NSNull null]];
    }
    
    return array;
}

- (NSArray *)filter:(BOOL (^)(id))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return block(evaluatedObject);
    }]];
}

- (NSArray *)reject:(BOOL (^)(id))block {
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return !block(evaluatedObject);
    }]];
}

- (id)detect:(BOOL (^)(id))block {
    for (id object in self) {
        if (block(object))
            return object;
    }
    
    return nil;
}

- (id)reduce:(id (^)(id, id))block {
    return [self reduce:nil withBlock:block];
}

- (id)reduce:(id)initial withBlock:(id (^)(id, id))block {
    id accumulator = initial;
    
    for(id object in self)
        accumulator = accumulator ? block(accumulator, object) : object;
    
    return accumulator;
}

@end



