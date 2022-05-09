#import <UIKit/UIKit.h>
#define ding @"/Library/ApplicationSupport/ding.mp3"
#import "SparkColourPickerUtils.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <AVFoundation/AVFoundation.h>
#include <string.h>
#include <dlfcn.h>

AVAudioPlayer *player;
UIColor *customBackgroundColor;

@interface SBDisplayItem : NSObject
@property (retain, nonatomic, readwrite) NSString *bundleIdentifier;
@end

@interface SBAppLayout : NSObject
@property (retain, nonatomic, readwrite) NSDictionary* rolesToLayoutItemsMap;
@end


@interface SBIcon : NSObject
-(id)application;
@end

@interface SBIconView : UIView
@property (nonatomic,retain) SBIcon * icon;
-(void)setIconImageAlpha:(double)arg1;
-(void)setIconAccessoryAlpha:(double)arg1;
-(void)_applyIconImageAlpha:(double)arg1;
@end


@interface CCUILabeledRoundButton
@property (nonatomic, copy, readwrite) NSString *title;
@end



@interface SBWiFiManager
-(id)sharedInstance;
-(void)setWiFiEnabled:(BOOL)enabled;
-(bool)wiFiEnabled;
@end

@interface BluetoothManager
-(id)sharedInstance;
-(void)setEnabled:(BOOL)enabled;
-(bool)enabled;

-(void)setPowered:(BOOL)powered;
-(bool)powered;
@end


////////




@interface SBSwitcherSnapshotImageView : UIView {

	UIImageView* _imageView;
	UIView* _scalingView;
	double _cornerRadius;
	unsigned long long _maskedCorners;
	BOOL _usesNonuniformScaling;
	BOOL _hasOpaqueContents;
	long long _orientationForClassicLayout;

}

@property (nonatomic,retain) UIImage * image; 
@property (assign,nonatomic) double cornerRadius; 
@property (assign,nonatomic) unsigned long long maskedCorners; 
@property (assign,nonatomic) BOOL usesNonuniformScaling;                         
@property (assign,nonatomic) BOOL hasOpaqueContents;                             
@property (assign,nonatomic) long long orientationForClassicLayout; 
-(CGAffineTransform)scalingTransform;
-(BOOL)usesNonuniformScaling;
-(double)_transformHorizontalScale;
-(double)_transformVerticalScale;
-(double)_transformScale;
-(BOOL)_isUsingExternalClassicLayout;
-(void)setHasOpaqueContents:(BOOL)arg1 ;
-(void)setOrientationForClassicLayout:(long long)arg1 ;
-(void)setUsesNonuniformScaling:(BOOL)arg1 ;
-(BOOL)hasOpaqueContents;
-(long long)orientationForClassicLayout;
-(void)setCornerRadius:(double)arg1 ;
-(double)cornerRadius;
-(void)layoutSubviews;
-(void)setImage:(UIImage *)arg1 ;
-(id)initWithImage:(id)arg1 ;
-(UIImage *)image;
-(void)setMaskedCorners:(unsigned long long)arg1 ;
-(unsigned long long)maskedCorners;
-(void)_updateCornerRadius;
@end


@interface SBAppSwitcherReusableSnapshotView : UIView {
	SBSwitcherSnapshotImageView* _firstImageView;
	SBAppLayout* _appLayout;
}
@property (nonatomic,retain) SBAppLayout * appLayout;
- (UIImage *)blurredImageWithImage:(UIImage *)sourceImage;
@end

@interface SBReusableSnapshotItemContainer
@property (nonatomic,retain) SBAppLayout * appLayout; 
	-(void)setSnapshotView:(SBAppSwitcherReusableSnapshotView *)arg1;
@end

@interface SBMainSwitcherViewController
+(instancetype)sharedInstance;
-(BOOL)isMainSwitcherVisible;
@end

@interface SBApplication
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *displayName;
@end

@interface SBWorkspaceTransitionRequest :NSObject
@property (nonatomic,copy) NSString * eventLabel;
-(NSSet *)toApplicationSceneEntities;
@end
@interface SBWorkspaceTransaction : NSObject
@property (nonatomic,readonly) SBWorkspaceTransitionRequest * transitionRequest;
-(BOOL)isComplete;
@end