//
//  NSString+HExtensions.h
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HExtensions)
- (NSString *)firstLetter;
- (BOOL)contains:(NSString*)string;
- (BOOL)isValidEmail;
- (NSString*)add:(NSString*)string;
- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (NSString*)safeSubstringToIndex:(NSUInteger)index;
- (NSUInteger)wordCount;
@end

@interface NSObject (JSON)
- (NSString *)toJSON;
@end

@interface NSString (URL)
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString:(BOOL)decodePlusAsSpace;
@end

@interface NSString (Base64)
- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;
@end

@interface NSData (Base64)
- (NSString *)UTF8String;
@end

@interface NSString (Crypto)
- (NSString *)md5;
- (NSString *)sha1;
@end
