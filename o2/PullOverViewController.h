#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#define DLog(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#define IS_IOS13_AND_UP ([[UIDevice currentDevice].systemVersion floatValue] >= 13.0)
#import <MediaRemote/MediaRemote.h>
#import <AVFoundation/AVFoundation.h> 
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreFoundation/CoreFoundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import <UIKit/UIWindow+Private.h>
#import "BaseScrollView.h"
#import "POHandle.h"
#import "QuickSwitchTableView.h"
#import "ContextHostManager.h"
#import <AudioToolbox/AudioServices.h>
#import "MediaRemote.h"
#import "IPC.h"
#import "headers.h"
@interface o2ViewController : UIViewController <UIScrollViewDelegate, POHandleDelegate, QuickSwitchSelectionDelegate>
-(void)danjiwaibu111;
-(void)danjiwaibu555;
-(void)danjiwaibu444;
-(void)danjiwaibu333;
-(void)danjiwaibu777;
-(void)danjiwaibu888;
-(void)danjiwaibu999;
-(void)close;
-(void)open;
-(void)opennew;
-(void)endHosting;
- (void)updateImage;
- (void)updateImage2;
- (void)playPause;
- (void)next;
- (void)previous;
- (void)StopPause;
- (void)playingDidChange;

@property (nonatomic) BOOL isOpened;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *handleScrollView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *gecibackgroundView;
@property (nonatomic, strong) UIView *gecibackgroundViewmusic2;
@property (nonatomic, strong) UIView *gecibackgroundViewmusic;
@property (nonatomic, strong) POHandle *handle;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentView2;
@property (nonatomic, strong) UIView *contentView2music;
@property (nonatomic, strong) UIView *contentView2musicicon;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *nextButtonmusic;
@property (nonatomic, strong) UIButton *previousButtonmusic;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *previousButton8;
@property (nonatomic, strong) UIButton *previousButton9;
@property (nonatomic, strong) UIButton *previousButton10;
@property (nonatomic, strong) UIButton *playPauseButton;
@property (nonatomic, strong) UIButton *playPauseButtonmusic;
@property (nonatomic, strong) UIView *contentView3;
@property (nonatomic, strong) UIView *contentView8;
@property (nonatomic, strong) UIView *contentView4;
@property (nonatomic, strong) UIView *contentView9;
@property (nonatomic, strong) UIView *contentView10;
@property (nonatomic, strong) UIView *contentView11;
@property (nonatomic, strong) UIView *contentView12;
@property (nonatomic, strong) UIView *contentView15;
@property (nonatomic, strong) UIView *contentView17;
@property (nonatomic, strong) UIView *contentView18;
@property (nonatomic, strong) UIView *contentView30;
@property (nonatomic, strong) UIView *contentView555;
@property (nonatomic, strong) UIView *contentView333;
@property (nonatomic, strong) UIView *contentView444;
@property (nonatomic, strong) UIView *contentView32;
@property (nonatomic, strong) UIView *contentView31;
@property (nonatomic, strong) UIView *contentView19;
@property (nonatomic, strong) UIView *contentView20;
@property (nonatomic, strong) UIView *contentView21;
@property (nonatomic, strong) UIView *contentView22;
@property (nonatomic, strong) UIView *contentView23;
@property (nonatomic, strong) UIView *contentView16;
@property (nonatomic, strong) UIView *contentView5music;
@property (nonatomic, strong) UIView *contentView5;
@property (nonatomic, strong) UIView *contentView6;
@property (nonatomic, strong) UIView *contentView6music;
@property (nonatomic, strong) UIView *contentView7;
@property (nonatomic, strong) UIView *contentView77music;
@property (nonatomic, strong) QuickSwitchTableView *quickSwitchTableView;
@end

@interface SBOrientationLockManager	: NSObject
    +(instancetype)sharedInstance;
    -(BOOL)isUserLocked;
    -(void)lock;
    -(void)unlock;
@end
SBOrientationLockManager *orientationManager;

@interface SBUIFlashlightController : NSObject
    +(id)sharedInstance;
    -(void)turnFlashlightOnForReason:(id)arg1;
    -(void)turnFlashlightOffForReason:(id)arg1;
    -(void)setLevel:(NSUInteger)arg1;
    -(unsigned long long)level;
@end
SBUIFlashlightController *flc;

@interface SBWiFiManager : NSObject
    +(id)sharedInstance;
    -(void)setWiFiEnabled:(BOOL)enabled;
    -(bool)wiFiEnabled;
@end
SBWiFiManager *wifiman;

@interface BluetoothManager
    +(id)sharedInstance;
    -(void)setEnabled:(BOOL)enabled;
    -(bool)enabled;
    -(void)setPowered:(BOOL)powered;
    -(bool)powered;
@end
BluetoothManager *btoothManager;

@interface RPScreenRecorder : NSObject
    +(id)sharedRecorder;
    -(BOOL)isRecording;
    -(void)startSystemRecordingWithMicrophoneEnabled:(BOOL)arg1 handler:(id)arg2 ;
    -(void)stopSystemRecording:(id)arg1 ;
@end
RPScreenRecorder *tapeman;

@interface _CDBatterySaver
    +(id)batterySaver;
    -(BOOL)setPowerMode:(long long)arg1 error:(id *)arg2;
    -(long long)getPowerMode;
@end

@interface SBMediaController : NSObject
    + (instancetype)sharedInstance;
    - (SBApplication *)nowPlayingApplication;
@end

@interface SBCoverSheetPresentationManager
    +(id)sharedInstance;
    -(BOOL)isVisible;
    - (void)setCoverSheetPresented:(BOOL)arg1
            animated:(BOOL)arg2
    withCompletion:(id)arg3;
@end