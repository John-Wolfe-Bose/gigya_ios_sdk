#import "GSLineProvider.h"
#import "Gigya+Internal.h"

@interface GSLineProvider ()

@property (nonatomic, copy) GSNativeLoginHandler handler;
@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) NSString *reverseAuthParam;
@property (nonatomic, strong) NSString *consumerKey;
@property (nonatomic, strong) ACAccountType *accountType;
@property (nonatomic, strong) NSArray *accounts;

@end

@implementation GSLineProvider

LineSDKAPI  *apiClient;

#pragma mark - Init methods
+ (GSLineProvider *)instance
{
    static dispatch_once_t onceToken;
    static GSLineProvider *instance;
    
    dispatch_once(&onceToken, ^{
        instance = [[GSLineProvider alloc] init];
    });
    
    return instance;
}

#pragma mark - GSLoginProvider methods
+ (BOOL)isAppConfiguredForProvider
{

    NSDictionary *lineSDKConfig = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LineSDKConfig"];
    NSString* channelID= lineSDKConfig[@"ChannelID"];
    
    return ([LineSDKLogin class] && [channelID length] > 0);
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
    return @"line";
}

#pragma mark - Login flow
// https://developers.line.me/ios/development-with-sdk-v2

- (void)startNativeLoginForMethod:(NSString *)method
                       parameters:(NSDictionary *)parameters
                   viewController:(UIViewController *)viewController
                completionHandler:(GSNativeLoginHandler)handler
{

    self.handler = handler;
    self.viewController = viewController;
    

    [LineSDKLogin sharedInstance].delegate = self;
    
    [[LineSDKLogin sharedInstance] startLogin];
    
}


#pragma mark LineSDKLoginDelegate

- (void)didLogin:(LineSDKLogin *)login
      credential:(LineSDKCredential *)credential
         profile:(LineSDKProfile *)profile
           error:(NSError *)error
{
    NSDictionary *result = nil;
    
    if (error) {
        GSLog(@"error: %@",error);
    }
    else {
        
        NSString * accessToken = credential.accessToken.accessToken;
        GSLog(@"Success, token: %@",accessToken);
        
        if ([accessToken length] > 0 ) {
            result = @{ @"x_providerToken": accessToken
                        //,@"x_providerTokenSecret": oauthTokenSecret
                        };
        }
    }
        
   [self finishWithAuthData:result error:error];
        
}

#pragma mark handleOpenURL

- (BOOL)handleOpenURL:(NSURL *)url
          application:(UIApplication *)application
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation
{
    return [[LineSDKLogin sharedInstance] handleOpenURL:url];
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
