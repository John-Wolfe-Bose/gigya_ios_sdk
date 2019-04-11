#import <Foundation/Foundation.h>
#import "Gigya.h"
#import "GSNativeLoginProvider.h"
#import "WXApi.h"
#import "WXApiObject.h"

@interface GSWeChatProvider : GSNativeLoginProvider <WXApiDelegate>

@end
