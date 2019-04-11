#import <Foundation/Foundation.h>
#import "Gigya.h"
#import "GSNativeLoginProvider.h"

@interface GSFacebookProvider : GSNativeLoginProvider
NS_ASSUME_NONNULL_BEGIN

- (void)requestNewPublishPermissions:(NSString *)permissions
                      viewController:(UIViewController * _Nullable)viewController
                     responseHandler:(GSPermissionRequestResultHandler)handler;

- (void)requestNewReadPermissions:(NSString *)permissions
                   viewController:(UIViewController * _Nullable)viewController
                  responseHandler:(GSPermissionRequestResultHandler)handler;

NS_ASSUME_NONNULL_END
@end
