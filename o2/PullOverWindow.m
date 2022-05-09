#import "PullOverWindow.h"

@implementation o2Window
@synthesize controller;

+ (id)sharedWindow {
    static o2Window *window = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        window = [[self alloc] init];
    });
    
    return window;
}

- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
        self.windowLevel = UIWindowLevelAlert-1;
        [self setHidden:NO];
        self.alpha = 1;
        self.rootViewController = controller = [[o2ViewController alloc] init];       
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)makeKeyAndVisible{
    [super makeKeyAndVisible];
}
- (bool)_shouldCreateContextAsSecure{
    return YES;
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *hitTestResult = [super hitTest:point withEvent:event];
    

    CGPoint convertedPoint = [self convertPoint:point toView:controller.contentView];

    if ([controller isOpened]) {
       if (CGRectContainsPoint(controller.contentView.bounds, convertedPoint)) {
           NSLog(@"控制器里有触摸");
           return nil;
       }
        return hitTestResult;
    }else{
        if ([hitTestResult isKindOfClass:[POHandle class]]) {
            return controller.handle;
        }
        return nil;
    }
}

@end



