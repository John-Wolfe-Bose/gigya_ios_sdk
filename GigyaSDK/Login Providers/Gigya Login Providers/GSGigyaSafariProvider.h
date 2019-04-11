#import <Foundation/Foundation.h>
#import "Gigya.h"
#import "GSLoginProvider.h"
#import "GSProviderSelectionViewController.h"
#import <SafariServices/SafariServices.h>

@interface GSGigyaSafariProvider : NSObject <GSLoginProvider, SFSafariViewControllerDelegate>

@end
