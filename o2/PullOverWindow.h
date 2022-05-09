#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PullOverViewController.h"
@interface o2Window : UIWindow
@property (nonatomic, strong) o2ViewController *controller;
+ (id)sharedWindow;
@end
