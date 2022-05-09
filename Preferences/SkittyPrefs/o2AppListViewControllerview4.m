// Skitty App List - Custom AppList Alternative
// By Skitty

#import "o2AppListViewControllerview4.h"

#define PREFS_PATH @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.o2app+.plist"
#define BUNDLE_ID @"xc.lzsxcl.o2"

o2AppListViewControllerview4 *controller;
BOOL checkAllFlag;

static void setAppList(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	if ([(__bridge NSDictionary *)userInfo count] < 2) { // people must have at least two apps, right?
		return;
	}
	NSLog(@"[SPEC] setAppList: %@", userInfo);
	[controller recieveAppList:(__bridge NSDictionary *)userInfo];
}

static void post() {
	NSLog(@"[SPEC] post");
	CFNotificationCenterPostNotification(CFNotificationCenterGetDistributedCenter(), (CFStringRef)[BUNDLE_ID stringByAppendingString:@".getapps"], nil, nil, true);
}

@implementation o2AppListViewControllerview4

- (NSArray *)specifiers {
	return nil;
}

- (id)init {
	self = [super init];
	if (self) {
		// Supported Apps
		//self.supportedApps = @[@"com.apple.AppStore", @"com.apple.mobilecal", @"com.apple.MobileAddressBook", @"com.apple.mobilemail", @"com.apple.Maps", @"com.apple.MobileSMS", @"com.apple.Music", @"com.apple.mobileslideshow", @"com.apple.mobilephone", @"com.apple.news", @"com.apple.podcasts", @"com.apple.Preferences", @"is.workflow.my.app"];
		
		self.title = @"选择分屏窗口3应用";

		CFNotificationCenterAddObserver(CFNotificationCenterGetDistributedCenter(), NULL, setAppList, (CFStringRef)[BUNDLE_ID stringByAppendingString:@".setapps"], nil, CFNotificationSuspensionBehaviorDeliverImmediately);

		[self getAppList];
		
		NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:PREFS_PATH];
		NSArray *apps;
		if ([[NSFileManager defaultManager] fileExistsAtPath:PREFS_PATH]) {
			apps = [prefs objectForKey:@"bundleID"];
		} else {
			apps = @[];
		}
		self.preferencesAppList = apps;
		
		self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
		self.searchController.dimsBackgroundDuringPresentation = NO;
		self.searchController.delegate = self;
		self.searchController.searchBar.delegate = self;
		self.searchController.searchBar.placeholder = @"搜索 *仅能选择一个app";

		self.navigationItem.searchController = self.searchController;
		self.navigationItem.hidesSearchBarWhenScrolling = NO; // unfortunatly, this is required.

		self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
		self.tableView.delegate = self;
		self.tableView.dataSource = self;
		[self.view addSubview:self.tableView];

		// This is probably a terrible way to do it.
		controller = self;
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	UIBarButtonItem *checkAllButton = [[UIBarButtonItem alloc] initWithTitle: @"全选" 
																	style: UIBarButtonItemStylePlain 
																   target: self 
																   action: @selector(checkAll)];
	self.navigationItem.rightBarButtonItem = checkAllButton;
}

- (void)viewDidLoad {
	[super viewDidLoad];
}

- (void)checkAll {
	checkAllFlag = !checkAllFlag;
	NSString *msg = checkAllFlag ? 
		@"" : 
		@"";
	UIAlertController* alert = [UIAlertController alertControllerWithTitle: @"提示 仅能选择一个app"
								   								   message: msg
								  						    preferredStyle: UIAlertControllerStyleAlert];
	
	UIAlertAction* confirmAction = [UIAlertAction actionWithTitle: @"坚持这样做" 
															 style: UIAlertActionStyleDestructive
	   handler:^(UIAlertAction * action) {
		if (checkAllFlag) {
			self.preferencesAppList = [self.identifiers mutableCopy];
		} else {
			self.preferencesAppList = @[];
		}
		[self.tableView reloadData];
		[self updatePreferencesAppList];

	}];

	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle: @"取消" 
														   style: UIAlertActionStyleCancel
	handler:^(UIAlertAction * action) {}];
	 
	[alert addAction:confirmAction];
	[alert addAction:cancelAction];
	
	[self presentViewController:alert animated:YES completion:nil];
}

// Preferences

- (void)updatePreferencesAppList {
	NSDictionary *preferencesDict = @{ @"bundleID": self.preferencesAppList };
	[preferencesDict writeToFile:PREFS_PATH atomically:YES];
	// CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (__bridge CFStringRef)@"xc.lzsxcl.o2/ReloadPreferences", NULL, NULL, YES);
}

- (void)updateSwitch:(UISwitch *)appSwitch {
	NSString *tag = [NSString stringWithFormat:@"%ld", (long)appSwitch.tag];
	NSInteger section = [[tag substringToIndex:1] intValue] - 1;
	NSInteger row = [[tag substringFromIndex:1] intValue];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	BOOL on = [(UISwitch *)cell.accessoryView isOn];

	NSString *bundleIdentifier = self.identifiers[indexPath.row];

	NSMutableArray *list = [self.preferencesAppList mutableCopy];
	if (on) {
		[list addObject:bundleIdentifier];
	} else {
		[list removeObject:bundleIdentifier];
	}

	self.preferencesAppList = list;
	[self updatePreferencesAppList];
}

// App List

- (void)getAppList {
	if (self.appList.count == 0) {
		self.appList = @{@"Loading!": @"Loading..."};
	}
	
	post();
}

- (void)recieveAppList:(NSDictionary *)appList {
	if ([appList count] < 2) {
		return;
	}
	self.fullAppList = appList;
	[self updateAppList:appList];
}

- (void)updateAppList:(NSDictionary *)appList {
	NSLocale *locale=[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
	NSArray *ids = [appList keysSortedByValueUsingComparator:^(NSString *obj1, NSString *obj2) {
		NSRange string1Range = NSMakeRange(0, [obj1 length]);
        return [obj1 compare:obj2 options:0 range:string1Range locale:locale];
	}];

	self.appList = appList;
	self.identifiers = ids;

	[self.tableView reloadData];
}

// Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnabledAppCell"];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:@"EnabledAppCell"];
	}
	
	UISwitch *appSwitch = [[UISwitch alloc] init];
	appSwitch.tag = [[NSString stringWithFormat:@"%ld%ld", (long)indexPath.section + 1, (long)indexPath.row] intValue];
	[appSwitch addTarget:self action:@selector(updateSwitch:) forControlEvents:UIControlEventPrimaryActionTriggered];
	[cell setAccessoryView:appSwitch];
	
	cell.detailTextLabel.textColor = [UIColor grayColor];
	
	if (![self.preferencesAppList containsObject:self.identifiers[indexPath.row]]) {
		[appSwitch setOn:NO animated:NO];
	} else {
		[appSwitch setOn:YES animated:NO];
	}

	cell.textLabel.text = [self.fullAppList objectForKey:self.identifiers[indexPath.row]];
	cell.detailTextLabel.text = self.identifiers[indexPath.row];
	
	cell.imageView.image = [UIImage _applicationIconImageForBundleIdentifier:self.identifiers[indexPath.row] format:0 scale:[UIScreen mainScreen].scale];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.identifiers.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}

// Search Bar

- (void)searchWithText:(NSString *)text {
	NSDictionary *newAppList;
	if (text.length == 0) {
		newAppList = self.fullAppList;
	} else {
		NSMutableDictionary *mutableList = [[NSMutableDictionary alloc] init];
		NSArray *ids = [self.fullAppList keysSortedByValueUsingComparator:^(NSString *obj1, NSString *obj2) {
			return [obj1 compare:obj2];
		}];
		NSArray<NSString *> *names = [[self.fullAppList allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			return [obj1 compare:obj2 options:NSNumericSearch];
		}];
		for (int i = 0; i < names.count; i++) {
			if ([names[i].lowercaseString rangeOfString:text.lowercaseString].location != NSNotFound) {
				[mutableList setObject:names[i] forKey:ids[i]];
			}
		}
		newAppList = [mutableList copy];
	}
	[self updateAppList:newAppList];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)text {
	[self searchWithText:text];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
	[self searchWithText:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[searchBar resignFirstResponder];
	[searchBar setShowsCancelButton:NO animated:YES];
	[self searchWithText:nil];
}

@end