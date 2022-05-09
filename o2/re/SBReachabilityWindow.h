#import <SpringBoard/SBSecureWindow.h>
#import <SpringBoard/SpringBoard-Structs.h>

@interface SBReachabilityWindow : SBSecureWindow

- (id)initWithWallpaperVariant:(long long)arg1;
- (BOOL)pointInside:(CGPoint)arg1 withEvent:(id)arg2;
- (id)view;
@end