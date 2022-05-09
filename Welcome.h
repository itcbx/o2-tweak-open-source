#define WELCOME @"/Library/PreferenceBundles/o2Prefs.bundle/Welcome.plist"
#define ROOT @"/Library/PreferenceBundles/o2Prefs.bundle/Root.plist"
#define PLIST_WEL @"/tmp/o2_WEL.plist"

@interface OBButtonTray : UIButton
@property (nonatomic,retain) UIVisualEffectView * effectView;
- (void)addButton:(id)arg1;
- (void)setStackViewTopConstraint:(NSLayoutConstraint *)arg1;
- (NSLayoutConstraint *)stackViewTopConstraint;
- (void)setEffectView:(UIVisualEffectView *)arg1;
- (void)addCaptionText:(id)arg1;
+(id)buttonWithType:(long long)arg1;
@end

@interface OBBuddyContinueButton : UIButton
+ (id)buttonWithType:(long long)arg1;
@end

@interface OBWelcomeController : UIViewController
- (id)initWithTitle:(id)arg1 detailText:(id)arg2 icon:(id)arg3;
- (void)addBulletedListItemWithTitle:(id)arg1 description:(id)arg2 image:(id)arg3;
- (void)setButtonTray:(OBButtonTray *)arg1;
@property (nonatomic,retain) OBButtonTray *buttonTray;
@end

@interface UIImage (Private)
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(double)arg3;
- (UIImage *)initWithContentOfFile:(id)arg1;
@end

@interface SBFLockScreenAlternateDateLabel : UIView
@end

@interface OBBoldTrayButton : UIButton
-(void)setTitle:(id)arg1 forState:(unsigned long long)arg2;
+(id)buttonWithType:(long long)arg1;
@end

@interface Welcomeo2 : NSObject
@property (nonatomic, strong) OBWelcomeController *welcomeController;
+(instancetype)shareInstance;
-(void)showWelcome;
-(void)dismissVC;
-(bool)isTweakUpgraded;
-(id)colorFromHex:(NSString *)hexString;
@end