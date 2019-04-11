#import "GSWeChatProvider.h"

@interface GSWeChatProvider ()

@property (nonatomic, copy) GSNativeLoginHandler handler;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSString *reverseAuthParam;
@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) ACAccountType *accountType;
@property (nonatomic, strong) NSArray *accounts;

@end

@implementation GSWeChatProvider

#pragma mark - Init methods
+ (GSWeChatProvider *)instance
{
    static dispatch_once_t onceToken;
    static GSWeChatProvider *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[GSWeChatProvider alloc] init];
    });
    
    return instance;
}

#pragma mark - GSLoginProvider methods

+ (BOOL)isAppConfiguredForProvider
{
    id plistAppId = [[NSBundle mainBundle] infoDictionary][@"WeChatAppID"];
    return ([plistAppId length] > 0 && NSClassFromString(@"WXApi"));
}

- (BOOL)isLoggedIn
{
    return NO;
}

- (BOOL)shouldFallbackToWebLoginOnProviderError
{
    return YES;
}

- (NSString *)name
{
    return @"wechat";
}

#pragma mark - Login flow

- (void)startNativeLoginForMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
                   viewController:(UIViewController *)viewController
                completionHandler:(GSNativeLoginHandler)handler
{
    self.handler = handler;
    self.viewController = viewController;
    
    
    id plistAppId = [[NSBundle mainBundle] infoDictionary][@"WeChatAppID"];
    [WXApi registerApp:plistAppId];
    SendAuthReq *request = [SendAuthReq new];
    request.scope = @"snsapi_userinfo";
    request.state = @"wechat_sdk_demo_test";
    [WXApi sendAuthReq: request viewController: viewController delegate: nil];
}


#pragma mark WXApiDelegate

- (void)onResp:(BaseResp *)resp {
    NSError *error = nil;
    NSDictionary *result = nil;
    if (resp.errCode != 0) {
        error = [NSError errorWithDomain:GSGigyaSDKDomain
                                    code:resp.errCode
                                userInfo:@{NSLocalizedDescriptionKey: resp.errStr}];
    } else {
        SendAuthResp *response = (SendAuthResp *)resp;
        NSString *accessToken = response.code;
        result = @{ @"x_providerToken": accessToken };
    }
    [self finishWithAuthData:result error:error];
}

#pragma mark handleOpenURL

- (BOOL)handleOpenURL:(NSURL *)url
          application:(UIApplication *)application
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


- (void)finishWithAuthData:(NSDictionary *)authData error:(NSError *)error
{
    if (self.handler) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.handler(authData, error);
        });
    }
}


@end
