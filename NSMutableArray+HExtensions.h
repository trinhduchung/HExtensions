//
//  NSMutableArray+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (HExtensions)

/**
 *  Add an object to an array with nil checking.
 *
 *  @param anObject the object would like to add to the array
 *
 *  @return YES if the object added to the array successfully. NO if that object is nil.
 */
- (BOOL)addObjectWithCheckingNil:(id)anObject;

/**
 *  Add an array to an array with nil checking.
 *
 *  @param anObject the array would like to add to the array
 *
 *  @return YES if the array added to the array successfully. NO if that array is nil.
 */
- (BOOL)addObjectsFromArrayWithCheckingNil:(NSArray *)otherArray;

@end
