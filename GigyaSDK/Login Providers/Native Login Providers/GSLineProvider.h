#import <Foundation/Foundation.h>
#import "Gigya.h"
#import "GSNativeLoginProvider.h"
#import "LineSDK/LineSDK.h"

@interface GSLineProvider : GSNativeLoginProvider <LineSDKLoginDelegate>

@end
