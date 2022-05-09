#import "QuickSwitchTableView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreGraphics/CoreGraphics.h>
#import "PullOverWindow.h"
#define TWEAK_PREF_PATH @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.o2applove.plist"
#define APPLIST_WHITE_PREF_PATH @"/var/mobile/Library/Preferences/xc.lzsxcl.o2.o2applove.plist"
#define BUNDLE_ID @"xc.lzsxcl.o2"

@interface QuickSwitchTableView (){
    NSDictionary *settings;
    NSMutableArray *items;
    NSIndexPath *lastHoveredIndexPath;
    UITableViewCell *lastCellToAnimate;
    UITableViewCell *thisCellToAnimate;
    SBApplication *draggingApp;
    float scale;
}
@end

@implementation QuickSwitchTableView
    -(instancetype)initWithDarkMode:(BOOL)darkMode{
        if (self = [super init]) {
            [self registerClass:[QuickSwitchTableViewCell class] forCellReuseIdentifier:@"QuickSwitchCell"];
            self.alpha = 0;
            self.clipsToBounds = NO;
            [self.layer setShadowColor:[UIColor blackColor].CGColor];
            [self.layer setShadowOpacity:0.15];
            [self.layer setShadowRadius:4.0];
            [self.layer setShadowOffset:CGSizeMake(0, 0)];
            self.separatorColor = [UIColor clearColor];
            self.darkMode = darkMode;
            self.delegate = self;
            self.dataSource = self;
            self.backgroundColor = self.darkMode?[UIColor darkGrayColor]:[UIColor whiteColor];
            self.layer.cornerRadius = 34/4;
            if (@available(iOS 13, *)){
                self.backgroundColor = [UIColor performSelector:@selector(secondarySystemBackgroundColor)];
            }else{
                self.backgroundColor = [[POApplicationHelper settings][@"darkHandle"] boolValue] ? [UIColor darkGrayColor] : [UIColor whiteColor];
            }      
            [self refresh];
        }
        return self;
    }




    -(void)presentFromHandle:(UIView *)handle withRecognizer:(UILongPressGestureRecognizer *)recognizer{
        CGPoint p = [recognizer locationInView:self];
        NSIndexPath *indexPath = [self indexPathForRowAtPoint:p];

        if (recognizer.state == UIGestureRecognizerStateBegan) {
            if ([settings[@"zzzp"] boolValue]) {
            AudioServicesPlaySystemSound(1519);
            }
            [self refresh];
            if (items.count == 0) {
            recognizer.enabled = NO;
            recognizer.enabled = YES;
            }
            float height = handle.frame.size.height*items.count;
            self.frame = CGRectMake(handle.frame.origin.x, handle.frame.origin.y, handle.frame.size.width, height);
            UIScrollView *scrollView = (UIScrollView *)self.superview;
            float origin = (self.frame.origin.y-scrollView.contentOffset.y)+scrollView.frame.origin.y;
            if(origin+height > [UIScreen mainScreen].bounds.size.height) {
            self.frame = CGRectMake(handle.frame.origin.x, (handle.frame.origin.y-height)+handle.frame.size.height, handle.frame.size.width, height);
            items = [[[items reverseObjectEnumerator] allObjects] mutableCopy];
            [self reloadData];
            }
            self.backgroundView.frame = self.frame;
            [self present];
            [self.selectionDelegate quickSwitchTableViewWillAppear:self];
        }else if (recognizer.state == UIGestureRecognizerStateChanged){
            if ((indexPath != lastHoveredIndexPath && p.x >= 0) | (draggingApp && p.x >= 0)){
            [self.selectionDelegate draggingDidEnterBoundsOfQuickSwitchTableView:self];
            if ([settings[@"zzzp"] boolValue]) {
            AudioServicesPlaySystemSound(1519);
            }
            lastCellToAnimate = [self cellForRowAtIndexPath:lastHoveredIndexPath];
            thisCellToAnimate = [self cellForRowAtIndexPath:indexPath];
            NSLog(@"[PO] this cell: %@", thisCellToAnimate);
            [self animateZoomforCellremove:lastCellToAnimate];
            [self animateZoomforCell:thisCellToAnimate];
            lastHoveredIndexPath = indexPath;
            draggingApp = nil;
            }else if(p.x < self.frame.origin.x){
            [self animateZoomforCellremove:thisCellToAnimate];
            [self animateZoomforCellremove:lastCellToAnimate];
            draggingApp = [[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:items[lastHoveredIndexPath.row]];
            [self.selectionDelegate quickSwitchTableView:self draggingDidChangeForQuickSwitchItem:draggingApp withPoint:p];
            }
        }else if (recognizer.state == UIGestureRecognizerStateEnded){
            if (lastHoveredIndexPath && p.x >= 0) {
            [self.selectionDelegate quickSwitchTableView:self didSelectBundleId:items[lastHoveredIndexPath.row]];
            }else{
            [self.selectionDelegate quickSwitchTableView:self didDropApp:[[objc_getClass("SBApplicationController") sharedInstance] applicationWithBundleIdentifier:items[lastHoveredIndexPath.row]] atPoint:p];
            }
            [self end];
        }else{
            [self end];
        }
    }

    #pragma mark — TableView
    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
    }

    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return items.count;
    }

    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if ([[POApplicationHelper settings][@"enabledppp"] boolValue]){
        return 34;       
        }else{
        return 50;
        }
    }


    - (NSMutableArray *)reversedArray:(NSMutableArray *)array {
        if ([array count] <= 1)
        return array;
        NSUInteger i = 0;
        NSUInteger j = [array count] - 1;
        while (i < j) {
        [array exchangeObjectAtIndex:i
        withObjectAtIndex:j];
        i++;
        j--;
        }
        return array;
    }

    #pragma mark - Animations
    -(void)present{
        [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        }];
    }

    -(void)end{
        [self animateZoomforCellremove:thisCellToAnimate];
        [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        lastHoveredIndexPath = nil;
        } completion:^(BOOL finished) {
        [self.selectionDelegate quickSwitchTableViewDidDisappear:self];
        }];
    }

    -(void)animateZoomforCell:(UITableViewCell*)zoomCell {
        zoomCell.layer.zPosition = 3;
        [UIView animateWithDuration:0.2 delay:0  options:UIViewAnimationOptionCurveEaseOut animations:^{
        zoomCell.transform = CGAffineTransformMakeScale(scale,scale);
        }completion:^(BOOL finished){}];
    }

    -(void)animateZoomforCellremove:(UITableViewCell*)zoomCell {
        zoomCell.layer.zPosition = 2;
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        zoomCell.transform = CGAffineTransformMakeScale(1.0,1.0);
        }completion:^(BOOL finished){}];
    }
@end