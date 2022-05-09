#import "SkittyPrefs/SPSettingsController.h"
#import <Preferences/PSSpecifier.h>
#import <objc/runtime.h>
#import <AppSupport/CPDistributedMessagingCenter.h>

@interface o2Controllerpro : SPSettingsController
-(void)showToastMessage:(NSString *)message withTitle:(NSString *)title timeout:(double)timeout viewController:(UIViewController *)viewController;
@end


