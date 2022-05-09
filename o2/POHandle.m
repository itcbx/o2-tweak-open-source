#import "POHandle.h"
#import <QuartzCore/QuartzCore.h>
#import "PullOverViewController.h"

#import "POApplicationHelper.h"

@interface POHandle (){
    UILabel *messageLabel;
    UIVisualEffectView *blurView;
}

@end

@implementation POHandle

-(instancetype)initWithController:(id)hubController{



        if ([[POApplicationHelper settings][@"enabledppp"] boolValue]){
        if (self = [super initWithFrame:CGRectMake(0, 0, 34, 34)]) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.layer.cornerRadius = self.frame.size.height/4;
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.25];
        [self.layer setShadowRadius:4.0];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];
        

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];

        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = .3f;
        [self addGestureRecognizer:longPress];
        
        
        self.darkMode = [[POApplicationHelper settings][@"darkHandle"] boolValue];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.darkMode?UIBlurEffectStyleDark:UIBlurEffectStyleRegular];
        blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        blurView.userInteractionEnabled = NO;
        blurView.layer.cornerRadius = self.frame.size.height/4;
        blurView.clipsToBounds = YES;
        [self addSubview:blurView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2, 3.5, 26, 26)];           
        [self.imageView setBackgroundColor:[UIColor clearColor]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        self.imageView.tintColor = [UIColor lightGrayColor];
        [self addSubview:self.imageView];
        
        [self setIsNubbed:[[NSUserDefaults standardUserDefaults] boolForKey:@"isNubbed"]];
    }
    }else if (self = [super initWithFrame:CGRectMake(0, 0, 48.5, 50)]) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.1];
        self.layer.cornerRadius = self.frame.size.height/4;
        [self.layer setShadowColor:[UIColor blackColor].CGColor];
        [self.layer setShadowOpacity:0.15];
        [self.layer setShadowRadius:4.0];
        [self.layer setShadowOffset:CGSizeMake(0, 0)];

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];

        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = .3f;
        [self addGestureRecognizer:longPress];
        
        
        self.darkMode = [[POApplicationHelper settings][@"darkHandle"] boolValue];
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:self.darkMode?UIBlurEffectStyleDark:UIBlurEffectStyleRegular];
        blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        blurView.frame = self.bounds;
        blurView.userInteractionEnabled = NO;
        blurView.layer.cornerRadius = self.frame.size.height/4;
        blurView.clipsToBounds = YES;
        [self addSubview:blurView];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(22, 7.5, 34, 34)];

        [self.imageView setBackgroundColor:[UIColor clearColor]];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.clipsToBounds = YES;
        self.imageView.tintColor = [UIColor lightGrayColor];
        [self addSubview:self.imageView];
        
        [self setIsNubbed:[[NSUserDefaults standardUserDefaults] boolForKey:@"isNubbed"]];
    }


    return self;
}

-(void)setIsNubbed:(BOOL)isNubbed{
    _isNubbed = isNubbed;
    
    [[NSUserDefaults standardUserDefaults] setBool:isNubbed forKey:@"isNubbed"];
    
    [UIView animateWithDuration:0.3 animations:^{
        if (isNubbed) {
            CGRect r = self.frame; r.origin.x = 38; self.frame = r;
        if ([[POApplicationHelper settings][@"enabledppp"] boolValue]){
            blurView.layer.cornerRadius = 10;
        }else{
            blurView.layer.cornerRadius = 10;
        }
        if ([[POApplicationHelper settings][@"enabledppp"] boolValue]){
            CGRect f = self.imageView.frame; f.origin.x = 4; self.imageView.frame = f;
}else{
            CGRect f = self.imageView.frame; f.origin.x = 7.5; self.imageView.frame = f;
}

        }else{
            CGRect r = self.frame; r.origin.x = 0; self.frame = r;
            blurView.layer.cornerRadius = self.frame.size.height/4;
         if ([[POApplicationHelper settings][@"enabledppp"] boolValue]){
            CGRect f = self.imageView.frame; f.origin.x = 4.1; self.imageView.frame = f;
         }else{                 
            CGRect f = self.imageView.frame; f.origin.x = 7.5; self.imageView.frame = f;
        }
        }
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    blurView.frame = self.bounds;
}


-(void)tap:(UIGestureRecognizer *)recognizer{
    [self.delegate handle:self didReceiveTap:recognizer];
}

-(void)longPress:(UIGestureRecognizer *)recognizer{
    [self.delegate handle:self didLongPress:recognizer];
}


@end



