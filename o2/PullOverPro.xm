
#import <notify.h>
#include <dlfcn.h>
#include <objc/runtime.h>
#import <libactivator/libactivator.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "headers.h"
#import "Tweak.h"
#import "PullOverWindow.h"
#import "POApplicationHelper.h"
NSUserDefaults *defaultsTweakpull;
BOOL oppull;
static o2Window *window;
static SBUserNotificationAlert *startupAlert;

#define tweakName @"PullOver Pro"
#define changelog [NSString stringWithFormat:@"/Library/Application Support/PullOverPro/changelog.plist"]
#import <sys/utsname.h>
#include <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>

void ReloadPrefspull() {
   defaultsTweakpull = [[NSUserDefaults alloc] initWithSuiteName:@"xc.lzsxcl.o2.Split"];
   [defaultsTweakpull registerDefaults:@{ @"enabled" : @YES }];  

   oppull = [[defaultsTweakpull objectForKey:@"enabled"] boolValue];  

  }
%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication *)arg1{
    %orig();
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[POApplicationHelper settingsPath]]){
        [@{} writeToFile:[POApplicationHelper settingsPath] atomically:NO];
        
        NSMutableDictionary *settings = [POApplicationHelper settings];

            [settings setObject:@(YES) forKey:@"enabledppp"];
            [settings setObject:@(NO) forKey:@"dsmsgc"];       
            [settings setObject:@(NO) forKey:@"h2splithp"];  
            [settings setObject:@(NO) forKey:@"xxymz"]; 
            [settings setObject:@(NO) forKey:@"minipx"]; 
            [settings setObject:@(NO) forKey:@"mini"]; 
            [settings setObject:@(NO) forKey:@"chuangkouhudong"]; 
            [settings setObject:@(NO) forKey:@"opcawbx"]; 
            [settings setObject:@(NO) forKey:@"opdjwb"]; 
            [settings setObject:@(NO) forKey:@"leftHanded"]; 
            [settings setObject:@(NO) forKey:@"ziyoulashen"]; 
            [settings setObject:@(NO) forKey:@"opdkdjlsgb"]; 
            [settings setObject:@(NO) forKey:@"ckmbbs"]; 
            [settings setObject:@(YES) forKey:@"minidibux"]; 
            [settings setObject:@(NO) forKey:@"o2splithp"]; 
            [settings setObject:@(NO) forKey:@"minifz"]; 
            [settings setObject:@(NO) forKey:@"angsmoon"]; 
            [settings setObject:@(NO) forKey:@"autoNubalpha"]; 
            [settings setObject:@(NO) forKey:@"jinzhihuadong"]; 
            [settings setObject:@(NO) forKey:@"zzzp"]; 
            [settings setObject:@(NO) forKey:@"splisthpzpy"]; 
            [settings setObject:@(NO) forKey:@"darkHandle"]; 
            [settings setObject:@(NO) forKey:@"hideLabels"]; 
            [settings setObject:@(NO) forKey:@"hpslagdface"]; 
            [settings setObject:@(NO) forKey:@"hpslagdtoch"]; 
            [settings setObject:@(NO) forKey:@"opsjwbxc2"]; 
            [settings setObject:@(NO) forKey:@"opsjwbxc2minipx"]; 
            [settings setObject:@(NO) forKey:@"ghddc"]; 
            [settings setObject:@(NO) forKey:@"istouch"];
            [settings setObject:@(NO) forKey:@"gddwz"];
            [settings setObject:@(NO) forKey:@"hytxx"];
            [settings setObject:@(NO) forKey:@"ghddcno"];
            [settings setObject:@(NO) forKey:@"splistycxy"];           
            [settings setObject:@(NO) forKey:@"volo2"];             
            [settings setObject:@"6" forKey:@"ckcornerRadius"]; 
            [settings setObject:@"12" forKey:@"ckcornerRadius3"];            
            [settings setObject:@"com.apple.mobileslideshow" forKey:@"chuangkou4viewapp"];               
            [settings setObject:@"com.apple.calculator" forKey:@"chuangkou3viewapp"];               
            [settings setObject:@(NO) forKey:@"hideInLandscape"];
            [settings setObject:[NSNumber numberWithInt:3] forKey:@"autoNub-time"];
            [settings setObject:[NSArray new] forKey:@"favorites"]; 
            [settings setObject:[NSNumber numberWithInt:5] forKey:@"recentAppsCount"];
            [settings setObject:[NSNumber numberWithFloat:1.75] forKey:@"quickswitchScale"];
            [settings setObject:@"Recent Apps" forKey:@"style"];
            [settings setObject:@"waibu555" forKey:@"danjiwaibuqh"];
            [settings setObject:@"555" forKey:@"act"];            
            [settings setObject:@"system" forKey:@"colorview"];
            [settings setObject:@"waibuxuanfu5" forKey:@"danjiwaixuanfu"];            
            [settings setObject:@"ghddcno3" forKey:@"onghddc"];
if (![settings objectForKey:@"favorites"]){
[settings setObject:[NSArray new] forKey:@"favorites"];
[settings writeToFile:[POApplicationHelper settingsPath] atomically:NO];
}

            [settings writeToFile:[POApplicationHelper settingsPath] atomically:NO];
    }
    

  window.alpha = 0;
  [window makeKeyAndVisible];

  if ([[POApplicationHelper settings][@"leftHanded"] boolValue]){
      window.transform = CGAffineTransformMakeScale(-1.0, 1.0);
  }
}


-(void)noteInterfaceOrientationChanged:(long long)arg1 duration:(double)arg2 updateMirroredDisplays:(BOOL)arg3 force:(BOOL)arg4 logMessage:(id)arg5{
    
    if ([[POApplicationHelper settings][@"hideInLandscape"] boolValue]){
        if (arg1 == 1){
            [UIView animateWithDuration:0.2 animations:^{
                window.rootViewController.view.alpha = 1;
            }];
        }else{
            // if ([window.controller isOpened]){
            //     [window.controller endHosting];
            //     [window.controller close];
            // }
            [UIView animateWithDuration:0.2 animations:^{
                window.rootViewController.view.alpha = 0;
            }];
        }
    }
    
    %orig;
}
%end



%hook SBLockScreenViewControllerBase
-(void)finishUIUnlockFromSource:(int)arg1{
    %orig;
}

%end

%hook SBFluidSwitcherGestureManager
-(void)grabberTongueBeganPulling:(id)arg1 withDistance:(double)arg2 andVelocity:(double)arg3 {
    if ([window.controller isOpened]){
        [window.controller close];
        [self grabberTongueCanceledPulling:arg1 withDistance:arg2 andVelocity:arg3];
    }else{
        %orig;
    }
}
%end

%hook SBHomeHardwareButton
-(void)singlePressUp:(id)arg1{
    if ([window.controller isOpened]){
        [window.controller close];
    }else{
        %orig;
    }
}
%end

%hook SBLockHardwareButton
-(void)singlePress:(id)arg1 {
    if ([window.controller isOpened]){
        [window.controller close];
    }
    %orig;
}
%end



%hook SBReachabilityBackgroundViewController


- (void)viewDidAppear:(BOOL)animated {
    %orig;

    static UIImageView *imageView;
    if(!imageView) {
        UIImage *image = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/o2Prefs.bundle/header@2x.png"];
        imageView = [[UIImageView alloc] initWithImage:image];
        CGSize newSize = CGSizeMake(imageView.frame.size.width/5, imageView.frame.size.height/5);
        imageView.frame = CGRectMake(
            (self.view.frame.size.width - newSize.width - 10),
            (-1 * newSize.height),
            newSize.width,
            newSize.height
        );
    }

    [self.view addSubview:imageView];
    [self.view bringSubviewToFront:imageView];

	[NSLayoutConstraint activateConstraints:@[
		[imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
		[imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
		[imageView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
		[imageView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]
	]];
}

%end

%hook SBReachabilityBackgroundView

- (void)_setupChevron {

}

%end


%hook SBVolumeControl

-(void)decreaseVolume {
    if (![[POApplicationHelper settings][@"volo2"] boolValue]){
    	%orig;
    }
if ([[POApplicationHelper settings][@"volo2"] boolValue]){
    if ([window.controller isOpened]){
        [window.controller close];
    }else{
        [window.controller open];
       [window.controller danjiwaibu555];           
    }
}
}
%end

static LAActivator *_LASharedActivator;
static LAActivator *_LASharedActivator2;
static NSString *bundleID = @"xc.lzsxcl.o2Split";
static NSString *bundleID2 = @"xc.lzsxcl.o2SpringBoard";
static void loadActivator() {
	NSLog(@"attempting to load libactivator");
	void *la = dlopen("/usr/lib/libactivator.dylib", RTLD_LAZY);
	if (!(char *)la) {
		NSLog(@"failed to load libactivator");
	}
	NSLog(@"libactivator is installed");
	_LASharedActivator = [objc_getClass("LAActivator") sharedInstance];
    	_LASharedActivator2 = [objc_getClass("LAActivator") sharedInstance];
}

@interface o2splitactivatoropen : NSObject <LAListener>

@end
@implementation o2splitactivatoropen


+ (id)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}
  +(void)load {
	loadActivator();
	[self sharedInstance];  
  }



- (id)init {
	if ([super init]) {
		if (_LASharedActivator) {
			if (![_LASharedActivator hasSeenListenerWithName:bundleID2]) {
				[_LASharedActivator assignEvent:[objc_getClass("LAEvent") eventWithName:@"xc.lzsxcl.o2.Spliton"] toListenerWithName:bundleID2];
			}
			if (_LASharedActivator.isRunningInsideSpringBoard) {
				[_LASharedActivator registerListener:self forName:bundleID2];
			}
		}
	}
	return self;
}

- (void)dealloc {
	if (_LASharedActivator) {
		if (_LASharedActivator.runningInsideSpringBoard) {
			[_LASharedActivator unregisterListenerWithName:bundleID2];
		}
	}
}


- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale
{
 if (scale > 2) {
  return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/o2Prefs.bundle/icon@2x.png"];
 }

 return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/o2Prefs.bundle/icon@2x.png"];
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
    if ([window.controller isOpened]){
        [window.controller close];
    }else{
        [window.controller opennew];            
    }
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
	return @"(横屏)o2分屏";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {//主要的名字
 return @"(横屏)o2分屏";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
 return @"通过activator以打开/关闭o2分屏";
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
 return [NSArray arrayWithObjects:@"springboard", @"application", nil];//, @"lockscreen"
}

@end

@interface o2splitactivatoropenhengp : NSObject <LAListener>

@end
@implementation o2splitactivatoropenhengp

+ (id)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}


  +(void)load {
	loadActivator();
	[self sharedInstance];  
  }





- (id)init {
	if ([super init]) {
		if (_LASharedActivator2) {
			if (![_LASharedActivator2 hasSeenListenerWithName:bundleID]) {
				[_LASharedActivator2 assignEvent:[objc_getClass("LAEvent") eventWithName:@"xc.lzsxcl.o2.Spliton2"] toListenerWithName:bundleID];
			}
			if (_LASharedActivator2.isRunningInsideSpringBoard) {
				[_LASharedActivator2 registerListener:self forName:bundleID];
			}
		}
	}
	return self;
}

- (void)dealloc {
	if (_LASharedActivator2) {
		if (_LASharedActivator2.runningInsideSpringBoard) {
			[_LASharedActivator2 unregisterListenerWithName:bundleID];
		}
	}
}


- (UIImage *)activator:(LAActivator *)activator requiresSmallIconForListenerName:(NSString *)listenerName scale:(CGFloat)scale
{
 if (scale > 2) {
  return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/o2Prefs.bundle/icon@2x.png"];
 }

 return [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/o2Prefs.bundle/icon@2x.png"];
}



- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
	return @"(竖屏)o2分屏";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {//主要的名字
 return @"(竖屏)o2分屏";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
 return @"通过activator以打开/关闭o2分屏";
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
 return [NSArray arrayWithObjects:@"springboard", @"application", nil];//, @"lockscreen"
}

@end

  %ctor {
   ReloadPrefspull();
   CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ReloadPrefspull, CFSTR("xc.lzsxcl.o2/ReloadPreferences"), NULL, CFNotificationSuspensionBehaviorCoalesce);	

  }
