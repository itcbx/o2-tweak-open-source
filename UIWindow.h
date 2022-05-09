@interface UIWindow (Private)

+(BOOL)_isSecure;
-(BOOL)_canAffectStatusBarAppearance;
- (void)_setSecure:(BOOL)secure;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@property (nonatomic, retain) UIPanGestureRecognizer *ssGestureRecognizer;
- (void)ssScreenshot;
@end
@interface UIStatusBar_Modern : UIWindow
@end

@interface SBApplication : NSObject
@property (nonatomic,readonly) NSString *bundleIdentifier;
@end