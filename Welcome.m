#include "Welcome.h"

@implementation Welcomeo2
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken = 0;
    __strong static Welcomeo2 *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    return self;
}

-(void)showWelcome {

	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:WELCOME];
	NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:ROOT];

	UIImage * imageTitle = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/PreferenceBundles/o2Prefs.bundle/%@", [prefs objectForKey:@"icon"]]];
	self.welcomeController = [[OBWelcomeController alloc] initWithTitle:[prefs objectForKey:@"title"] detailText:[prefs objectForKey:@"detailText"]
		icon:imageTitle];

	NSArray * items = [prefs objectForKey:@"items"];
	for (NSMutableDictionary *item in items) {
		UIImage * imageWel = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"/Library/PreferenceBundles/o2Prefs.bundle/%@", [item objectForKey:@"icon"]]];
		[self.welcomeController addBulletedListItemWithTitle:[item objectForKey:@"title"] description:[item objectForKey:@"description"]
			image:imageWel];
	}

    OBBoldTrayButton* continueButton = [OBBoldTrayButton buttonWithType:0];
    [continueButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [continueButton setTitle:[prefs objectForKey:@"button"] forState:UIControlStateNormal];
    [continueButton setClipsToBounds:YES];
    [continueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [continueButton.layer setCornerRadius:15];
    [self.welcomeController.buttonTray addButton:continueButton];
    self.welcomeController.buttonTray.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial];
    UIVisualEffectView *effectWelcomeView = [[UIVisualEffectView alloc] initWithFrame:self.welcomeController.viewIfLoaded.bounds];
    effectWelcomeView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemChromeMaterial];
    [self.welcomeController.viewIfLoaded insertSubview:effectWelcomeView atIndex:0];
    self.welcomeController.viewIfLoaded.backgroundColor = [UIColor clearColor];
	self.welcomeController.buttonTray.backgroundColor = [UIColor clearColor];
    [self.welcomeController.buttonTray addCaptionText:[prefs objectForKey:@"captionText"] ? : @"Pull down can close this view, too"];

    self.welcomeController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.welcomeController.view.tintColor = [root objectForKey:@"tintColor"] ? [self colorFromHex:[root objectForKey:@"tintColor"]] : nil;
    [[self keyWindow].rootViewController presentViewController:self.welcomeController animated:YES completion:nil];
}

-(UIWindow*)keyWindow {
    UIWindow* foundWindow = nil;
    NSArray* windows = [[UIApplication sharedApplication]windows];
    for (UIWindow* window in windows) {
        if (window.isKeyWindow) {
            foundWindow = window;
            break;
        }
    }
    return foundWindow;
}

-(void)dismissVC {
	[self.welcomeController dismissViewControllerAnimated:YES completion:nil];
}

-(bool)isTweakUpgraded {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_WEL];
	NSMutableDictionary *root = [[NSMutableDictionary alloc] initWithContentsOfFile:ROOT];
    if (prefs == nil) {
        prefs = [[NSMutableDictionary alloc] init];
        [prefs setObject:[root objectForKey:@"subtitle"] forKey:@"subtitle"];
        [prefs writeToFile:PLIST_WEL atomically:YES];
        return YES;
    }
    NSString * oldVersion = prefs[@"subtitle"];
    if (![oldVersion isEqualToString:[root objectForKey:@"subtitle"]]) {
        [prefs setObject:[root objectForKey:@"subtitle"] forKey:@"subtitle"];
        [prefs writeToFile:PLIST_WEL atomically:YES];
        return YES;
    }
    return NO;
}

-(id)colorFromHex:(NSString *)hexString {
	unsigned int rgbValue = 0;

	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	[scanner setScanLocation:[hexString hasPrefix:@"#"] ? 1 : 0];
	[scanner scanHexInt:&rgbValue];

	NSString *newString = [hexString substringFromIndex:[hexString hasPrefix:@"#"] ? 1 : 0];

	CGFloat r, g, b, a;
	switch (newString.length) {
		case 3:
			r = ((rgbValue & 0xF00) >> 8) / 255.0;
			g = ((rgbValue & 0xF0) >> 4) / 255.0;
			b = (rgbValue & 0xF) / 255.0;
			a = 1.0;
			break;
		case 4:
			r = ((rgbValue & 0xF000) >> 16) / 255.0;
			g = ((rgbValue & 0xF00) >> 8) / 255.0;
			b = ((rgbValue & 0xF0) >> 4) / 255.0;
			a = (rgbValue & 0xF) / 255.0;
			break;
		case 6:
			r = ((rgbValue & 0xFF0000) >> 16) / 255.0;
			g = ((rgbValue & 0xFF00) >> 8) / 255.0;
			b = (rgbValue & 0xFF) / 255.0;
			a = 1.0;
			break;
		case 8:
			r = ((rgbValue & 0xFF000000) >> 24) / 255.0;
			g = ((rgbValue & 0xFF0000) >> 16) / 255.0;
			b = ((rgbValue & 0xFF00) >> 8) / 255.0;
			a = (rgbValue & 0xFF) / 255.0;
			break;
		default:
			r = 0;
			g = 0;
			b = 0;
			a = 0;
			break;
	}

	return [UIColor colorWithRed:r green:g blue:b alpha:a];
}
@end