#import <Preferences/PSSpecifier.h>

@interface lzsxclAppearanceSelectionTableCell : PSTableCell
@property(nonatomic, retain) UIStackView *containerStackView;
@property(nonatomic, retain) NSArray *options;

- (void)updateForType:(int)type;
@end
