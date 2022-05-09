#import <Preferences/PSSpecifier.h>

@interface PSControlTableCell : PSTableCell
-(UIControl *)control;
@end

@interface PSSegmentTableCell : PSControlTableCell
@end

@interface o2SegmentTableImageCell : PSSegmentTableCell
@end

@interface UISegmentControl : UIControl
-(void)setImage:(UIImage *)image forSegmentAtIndex:(NSInteger)index;
-(void)setTitle:(NSString *)image forSegmentAtIndex:(NSInteger)index;
@end