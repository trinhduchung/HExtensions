//
//  NSString+HExtensions.m
//  Libs
//
//  Created by HungTD7 on 11/24/15.
//  Copyright © 2015 HungTD7. All rights reserved.
//

#import "NSString+HExtensions.h"
#import <CommonCrypto/CommonDigest.h>

#define kMaxEmailLength     254

@implementation NSString (HExtensions)

- (NSString *)firstLetter {
    if (!self.length || self.length == 1) {
        return self;
    } else {
        return [self substringToIndex:1];
    }
}

- (BOOL)contains:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

//http://stackoverflow.com/questions/386294/what-is-the-maximum-length-of-a-valid-email-address
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL validEmail = [emailTest evaluateWithObject:self];
    if(validEmail && self.length <= kMaxEmailLength)
        return YES;
    
    return NO;
}

- (NSString *)add:(NSString *)string {
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

- (BOOL)containsOnlyLetters {
    NSCharacterSet *blockedCharacters = [[NSCharacterSet letterCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (BOOL)containsOnlyNumbers {
    NSCharacterSet *numbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    
    return ([self rangeOfCharacterFromSet:numbers].location == NSNotFound);
}

- (BOOL)containsOnlyNumbersAndLetters {
    NSCharacterSet *blockedCharacters = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
    return ([self rangeOfCharacterFromSet:blockedCharacters].location == NSNotFound);
}

- (NSString *)safeSubstringToIndex:(NSUInteger)index {
    if(index >= self.length)
        index = self.length - 1;
    
    return [self substringToIndex:index];
}

- (NSUInteger)wordCount {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet:whiteSpace intoString:nil]) {
        count++;
    }
    
    return count;
}

@end

@implementation NSObject (JSON)

- (NSString *)toJSON {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:self options:0 error:nil] encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (URL)

- (NSString *)URLEncodedString {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8 ));
}

- (NSString *)URLDecodedString:(BOOL)decodePlusAsSpace {
    NSString *string = self;
    if (decodePlusAsSpace) {
        string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    }
    
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (Base64)

- (NSString *)base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
}

- (NSString *)base64DecodedString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:(NSDataBase64DecodingOptions)0];
    
    return [data UTF8String];
}

@end

@implementation NSData (Base64)

- (NSString *)UTF8String {
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end

@implementation NSString (Crypto)

- (NSString *)md5 {
    NSData *stringBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    if (CC_MD5([stringBytes bytes], (CC_LONG)[stringBytes length], result)) {
        NSMutableString *returnString = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
        for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
            [returnString appendFormat:@"%02x", result[i]];
        }
        
        return [NSString stringWithString:returnString];
    } else {
        return nil;
    }
}

- (NSString *)sha1 {
    NSData *stringBytes = [self dataUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    if (CC_SHA1([stringBytes bytes], (CC_LONG)[stringBytes length], result)) {
        NSMutableString *returnString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
        for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
            [returnString appendFormat:@"%02x", result[i]];
        }
        
        return [NSString stringWithString:returnString];
    } else {
        return nil;
    }
}

@end
