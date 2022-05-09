#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NSTask.h"
#import "Welcome.h"
#define DLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#define IS_IOS13_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 13.0)
@interface SBSApplicationShortcutItem : NSObject <NSCopying>
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * localizedTitle;
@property (nonatomic,copy) NSString * localizedSubtitle;
@property (nonatomic,copy) NSString * bundleIdentifierToLaunch;
@end
typedef struct SBIconImageInfo {
	CGSize size;
	CGFloat scale;
	CGFloat continuousCornerRadius;
}
SBIconImageInfo;
@interface SBIcon : NSObject
- (UIImage *)getIconImage:(NSInteger)type;
- (UIImage *)generateIconImageWithInfo:(SBIconImageInfo)imageInfo;
@end
@interface SBIconView : UIView
@property (retain, nonatomic) SBIcon *icon;
-(id)applicationBundleIdentifier;
-(id)applicationBundleIdentifierForShortcuts;
@end
@interface UIApplication (Custom)
-(BOOL)_openURL:(id)arg1 ;
@end
@interface UIColor (Private)
+ (id)tableCellGroupedBackgroundColor;
@end
#import <AudioToolbox/AudioServices.h>
#import <spawn.h>
@interface PSUIPrefsListController : UINavigationController
- (void)respring:(UIButton *)sender;
- (void)safeMode:(UIButton *)sender;
- (void)darkMode:(UIButton *)sender;
@end
@interface UISUserInterfaceStyleMode : NSObject
@property (nonatomic, assign) long long modeValue;
@end
@interface SBFolderController : NSObject 
-(BOOL)isOpen;
@end