#import <Foundation/Foundation.h>
#import "Gigya.h"
#import "GSLoginProvider.h"

@interface GSLoginManager : NSObject
NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, weak) id<GSLoginProvider> currentProvider;

+ (GSLoginManager *)sharedInstance;

+ (GSLoginManager *)sharedInstanceWithApplication:(UIApplication * _Nullable)application launchOptions:(NSDictionary * _Nullable)launchOptions;

- (id<GSLoginProvider>)loginProvider:(NSString *)providerName;

- (id<GSLoginProvider>)webLoginProvider;

- (void)startLoginForMethod:(NSString *)method
                  providers:(NSArray *)providers
                 parameters:(NSMutableDictionary *)parameters
             viewController:(UIViewController *)viewController
                popoverView:(UIView *)view
          completionHandler:(GSUserInfoHandler)handler;

- (BOOL)handleOpenURL:(NSURL *)url
          application:(UIApplication *)application
    sourceApplication:(NSString*)sourceApplication
           annotation:(id)annotation;
- (void)handleDidBecomeActive;

- (void)logoutWithCompletionHandler:(GSResponseHandler)handler;

- (void)clearSessionAfterLogout;

- (void)removeConnectionToProvider:(NSString *)provider
                 completionHandler:(GSUserInfoHandler)handler;

- (void)requestNewFacebookPublishPermissions:(NSString *)permissions
                              viewController:(UIViewController * _Nullable)viewController
                             responseHandler:(GSPermissionRequestResultHandler)handler;

- (void)requestNewFacebookReadPermissions:(NSString *)permissions
                           viewController:(UIViewController * _Nullable)viewController
                          responseHandler:(GSPermissionRequestResultHandler)handler;

NS_ASSUME_NONNULL_END
@end
