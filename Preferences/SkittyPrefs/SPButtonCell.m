#import "SPButtonCell.h"

@implementation SPButtonCell
-(UILabel*)textLabel {
    PSSpecifier * ps = self.specifier;
    SPSettingsController * controller = (SPSettingsController *)ps.target;
    NSMutableDictionary * settings = controller.settings;
    UILabel* res = [super textLabel];
    res.textColor = settings[@"tintColor"] ? : [UIColor colorFromHex:@"#89c997"];
    return res;
}
@end