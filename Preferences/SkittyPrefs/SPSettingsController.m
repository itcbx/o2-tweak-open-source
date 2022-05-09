// SPSettingsController.m

#import "SPSettingsController.h"
#import "UIColor+Hex.h"
#import <Preferences/PSSpecifier.h>

@implementation SPSettingsController

- (NSString *)plistName {
	return @"Root";
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"";

	// Icon on navbar
	UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 29, 29)];
	self.iconView = [[UIImageView alloc] initWithFrame:titleView.bounds];
	self.iconView.image = [UIImage imageWithContentsOfFile:[[self resourceBundle] pathForResource:@"icon" ofType:@"png"]];
	self.iconView.alpha = 0;
	[titleView addSubview:self.iconView];

	self.navigationItem.titleView = titleView;

	// Create header view
	self.headerView = [[SPHeaderView alloc] initWithSettings:[self.settings copy]];
	self.headerView.layer.zPosition = 1000;
	[self.view addSubview:self.headerView];

	// Update offset for header
	UITableView *tableView = [self valueForKey:@"_table"];
	CGFloat contentHeight = [self.headerView contentHeightForWidth:self.view.bounds.size.width];
	[tableView setContentOffset:CGPointMake(0, -contentHeight) animated: NO];

	self.navbarThemed = YES;
	self.iconView.alpha = 0;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	self.navbarThemed = YES;
	self.iconView.alpha = 0;

	if ([UIStatusBar instancesRespondToSelector:@selector(setForegroundColor:)]) {
		[UIApplication sharedApplication].statusBar.foregroundColor = [UIColor whiteColor];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	self.navbarThemed = NO;

	if ([UIStatusBar instancesRespondToSelector:@selector(setForegroundColor:)]) {
		[UIApplication sharedApplication].statusBar.foregroundColor = nil;
	}
}

// Set global tint color
- (void)setThemeColor:(UIColor *)color {
	_themeColor = color;
	
	UIWindow *keyWindow = nil;
	NSArray *windows = [[UIApplication sharedApplication] windows];
	for (UIWindow *window in windows) {
		if (window.isKeyWindow) {
			keyWindow = window;
			break;
		}
	}

	self.view.tintColor = color;
	keyWindow.tintColor = color;
	[UISwitch appearanceWhenContainedInInstancesOfClasses:@[self.class]].onTintColor = color;

	self.navbarThemed = self.navbarThemed;
}

// Modify navbar colors
- (void)setNavbarThemed:(BOOL)enabled {
	_navbarThemed = enabled;

	UINavigationBar *bar = self.navigationController.navigationController.navigationBar;

	if (enabled) {
		bar.barTintColor = self.settings[@"headerColor"] ?: self.themeColor;
		bar.tintColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
		if (@available(iOS 13.0, *)) {
			if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
				if (self.settings[@"darkHeaderColor"]) bar.barTintColor = self.settings[@"darkHeaderColor"];
				if (self.settings[@"darkTextColor"]) bar.tintColor = self.settings[@"darkTextColor"];
			}
		}
		bar.translucent = NO;
		bar.shadowImage = [UIImage new];
	} else {
		bar.barTintColor = [[UINavigationBar appearance] barTintColor];
		bar.tintColor = [[UINavigationBar appearance] tintColor];
		bar.translucent = YES;
		bar.shadowImage = [[UINavigationBar appearance] shadowImage];
	}

	[self layoutHeader];
}

// Header colors dark mode support
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	if (@available(iOS 13, *)) {
		UINavigationBar *bar = self.navigationController.navigationController.navigationBar;
		if (@available(iOS 13.0, *)) {
			if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
				if (self.settings[@"darkHeaderColor"]) bar.barTintColor = self.settings[@"darkHeaderColor"];
				if (self.settings[@"darkTextColor"]) bar.tintColor = self.settings[@"darkTextColor"];
			} else {
				bar.barTintColor = self.settings[@"headerColor"] ?: self.themeColor;
				bar.tintColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
			}
		} else {
			bar.barTintColor = self.settings[@"headerColor"] ?: self.themeColor;
			bar.tintColor = self.settings[@"textColor"] ?: [UIColor whiteColor];
		}
	}
}

// Status bar color (requires UINavigationController+StatusBar hack)
- (UIStatusBarStyle)preferredStatusBarStyle {
	return UIStatusBarStyleLightContent;
}

// Header positioning
- (void)layoutHeader {
	UITableView *tableView = [self valueForKey:@"_table"];

	CGFloat contentHeight = [self.headerView contentHeightForWidth:self.view.bounds.size.width];

	CGFloat yPos = fmin(0, -tableView.contentOffset.y);
	CGFloat elasticHeight = -tableView.contentOffset.y - contentHeight;

	if (elasticHeight < 0) {
		yPos += elasticHeight;
		elasticHeight = 0;
	}

	self.headerView.frame = CGRectMake(0, yPos, self.view.bounds.size.width, contentHeight + elasticHeight);
	self.headerView.elasticHeight = elasticHeight;
	tableView.contentInset = UIEdgeInsetsMake(contentHeight, 0, 0, 0);

	if (@available(iOS 13.0, *)) {
		tableView.automaticallyAdjustsScrollIndicatorInsets = NO;
	}
	tableView.scrollIndicatorInsets = UIEdgeInsetsMake(contentHeight + elasticHeight, 0, 0, 0);

	// Show header icon
	CGFloat start = -60;
	CGFloat length = 50;
	if (tableView.contentOffset.y < start) {
		self.iconView.alpha = 0;
	} else if (tableView.contentOffset.y > start && tableView.contentOffset.y < length + start) {
		self.iconView.alpha = (tableView.contentOffset.y - start) / length;
	} else if (tableView.contentOffset.y >= length + start) {
		self.iconView.alpha = 1;
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self layoutHeader];
}

// Bundle for fetching resources
// This should probably be overridden in subclasses.
- (NSBundle *)resourceBundle {
	return [NSBundle bundleForClass:self.class];
}

- (void)updateVisibility {
	[[self valueForKey:@"_table"] beginUpdates];
	[[self valueForKey:@"_table"] endUpdates];
}


//如果删除o2RootListController.m 12-29行则保持以下调整。
- (void)respring {
	UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"o2"
								   								   message: @"现在进行注销？\nRespring now?"
								  						    preferredStyle: UIAlertControllerStyleAlert];
	 
	UIAlertAction* respringAction = [UIAlertAction actionWithTitle: @"是的 Yes" 
															 style: UIAlertActionStyleDestructive
	   handler:^(UIAlertAction * action) {
		pid_t pid;
		int status;

		const char* args[] = {"killall", "-9", "backboardd", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
		waitpid(pid, &status, WEXITED);
	}];
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"取消 Cancel" 
														   style: UIAlertActionStyleCancel
	handler:^(UIAlertAction * action) {}];
	 
	[alert addAction:respringAction];
	[alert addAction:cancelAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}
@end
