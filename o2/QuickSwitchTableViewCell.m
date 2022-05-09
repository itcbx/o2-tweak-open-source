#import "QuickSwitchTableViewCell.h"
#import "POApplicationHelper.h"
@interface UIApplication (Private)
-(long long)_frontMostAppOrientation;
-(id)_accessibilityFrontMostApplication;
- (void)_relaunchSpringBoardNow;
- (id)_accessibilityFrontMostApplication;
- (void)launchApplicationWithIdentifier: (NSString*)identifier suspended: (BOOL)suspended;
- (id)displayIdentifier;
- (void)setStatusBarHidden:(bool)arg1 animated:(bool)arg2;
void receivedStatusBarChange(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo);
void receivedLandscapeRotate();
void receivedPortraitRotate();
@end

@implementation QuickSwitchTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    UIDeviceOrientation deviceOrientation = [[UIApplication sharedApplication] _frontMostAppOrientation];    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
        if (@available(iOS 13, *)){
            self.backgroundColor = [UIColor performSelector:@selector(secondarySystemBackgroundColor)];
        }else{
            self.backgroundColor = [[POApplicationHelper settings][@"darkHandle"] boolValue] ? [UIColor darkGrayColor] : [UIColor whiteColor];
        }

        if ([[POApplicationHelper settings][@"leftHanded"] boolValue]){
            self.imgView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
            if ((deviceOrientation == UIDeviceOrientationFaceUp)) {
            self.imgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }else{
            self.imgView.transform = CGAffineTransformMakeScale(-1.0, 1.0);                
            }                           
        }
    }
    return self;
}
@end