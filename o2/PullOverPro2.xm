

#import "PullOverPro.h"

static LAActivator *_LASharedActivator;
static NSString *bundleID = @"xc.lzsxcl.o2Split";
static void loadActivator() {
	NSLog(@"attempting to load libactivator");
	void *la = dlopen("/usr/lib/libactivator.dylib", RTLD_LAZY);
	if (!(char *)la) {
		NSLog(@"failed to load libactivator");
	}
	NSLog(@"libactivator is installed");
	_LASharedActivator = [objc_getClass("LAActivator") sharedInstance];
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
			if (![_LASharedActivator hasSeenListenerWithName:bundleID]) {
				[_LASharedActivator assignEvent:[objc_getClass("LAEvent") eventWithName:@"xc.lzsxcl.o2.Spliton"] toListenerWithName:bundleID];
			}
			if (_LASharedActivator.isRunningInsideSpringBoard) {
				[_LASharedActivator registerListener:self forName:bundleID];
			}
		}
	}
	return self;
}

- (void)dealloc {
	if (_LASharedActivator) {
		if (_LASharedActivator.runningInsideSpringBoard) {
			[_LASharedActivator unregisterListenerWithName:bundleID];
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

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
 return @"(横屏)o2分屏";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
 return @"通过activator以打开/关闭o2分屏";
}

- (NSArray *)activator:(LAActivator *)activator requiresCompatibleEventModesForListenerWithName:(NSString *)listenerName {
 return [NSArray arrayWithObjects:@"springboard", @"application", nil];
}

@end


  %ctor {


   ReloadPrefspull();
   CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ReloadPrefspull, CFSTR("xc.lzsxcl.o2/ReloadPreferences"), NULL, CFNotificationSuspensionBehaviorCoalesce);	
  }
