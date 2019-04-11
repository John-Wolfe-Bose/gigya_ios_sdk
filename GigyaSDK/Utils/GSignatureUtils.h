//
//  GigyaSignatureUtils.h
//  GigyaSDK
//
//  Created by Shmuel, Sagi on 17/02/2019.
//  Copyright © 2019 Gigya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Gigya+Internal.h"

@interface GSignatureUtils : NSObject
+ (NSString *)oauth1Signature:(NSString*) requestURL
                      session:(GSSession*) session
                   parameters:(NSMutableDictionary*) parameters;

+ (NSString *)oauth1SignatureBaseString:(NSString *)requestURL
                             parameters:(NSMutableDictionary*) parameters;

@end

