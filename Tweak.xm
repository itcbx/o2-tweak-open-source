#import "Tweak.h"
#import "MediaRemote.h"
#define TWEAK_PREF_PATH @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.prefs.plist"
#define APPLIST_WHITE_PREF_PATH2 @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.appsh.plist"
#define BUNDLE_ID @"xc.lzsxcl.o2"
#import <UIKit/UIKit.h>

NSUserDefaults *defaults;
BOOL enabled;


void ReloadPrefs() {
    defaults = [[NSUserDefaults alloc] initWithSuiteName:@"xc.lzsxcl.o2.prefs"];
    [defaults registerDefaults:@{ @"enabled" : @YES }];
    enabled = [[defaults objectForKey:@"enabled"] boolValue];    
}


%ctor {
    ReloadPrefs();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ReloadPrefs, CFSTR("xc.lzsxcl.o2/ReloadPreferences"), NULL, CFNotificationSuspensionBehaviorCoalesce);

	%init(_ungrouped);    
    }

    