#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface SBApplication : NSObject
@property (nonatomic, retain) NSString *displayName;
@property (nonatomic, retain) NSString *bundleIdentifier;
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)allApplications;
- (id)allBundleIdentifiers;
- (id)runningApplications;
@end