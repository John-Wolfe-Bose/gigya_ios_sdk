//
//  GigyaSignatureUtils.m
//  GigyaSDK
//
//  Created by Shmuel, Sagi on 17/02/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

#import "GSignatureUtils.h"
#import <CommonCrypto/CommonHMAC.h>

@implementation GSignatureUtils

#pragma mark - OAuth1 Signature

+ (NSString *)oauth1Signature:(NSString*) requestURL
                    session:(GSSession*) session
                    parameters:(NSMutableDictionary*) parameters
{
    // Sign the base string with the secret - http://oauth.net/core/1.0 - section 9.2
    NSData *baseStringData = [[self oauth1SignatureBaseString: requestURL parameters: parameters] dataUsingEncoding:NSUTF8StringEncoding];
    NSData *secretData = [NSData GSDataFromBase64String: session.secret];
    unsigned char result[20];
    CCHmac(kCCHmacAlgSHA1, [secretData bytes], [secretData length], [baseStringData bytes], [baseStringData length], result);
    
    // Return the signature string
    NSData *data = [NSData dataWithBytes:result length:20];
    return [data GSBase64SEncodedString];
}

+ (NSString *)oauth1SignatureBaseString:(NSString *)requestURL
                             parameters:(NSMutableDictionary*) parameters
{
    // http://oauth.net/core/1.0 - 9.1 Signature Base String
    // Base string components
    NSString *method = @"POST";
    NSURL *url = [NSURL URLWithString:requestURL];
    NSString *params = [parameters GSURLQueryString];
    
    NSString *baseString = [NSString stringWithFormat:@"%@&%@&%@", method, [url.description GSURLEncodedString], [params GSURLEncodedString]];
    GSLog(@"Calculating signature with base string:\n%@", baseString);
    
    return baseString;
}

@end
