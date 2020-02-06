#import <Preferences/PSListController.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#import <Cephei/HBRespringController.h>
#import <Cephei/HBPreferences.h>

@import UIKit;

// image for share button

#define kImagePath @"/Library/Application Support/ZenithDark/ZNDark.png"

@interface ZNDarkPrefsRootListController : HBRootListController
@property (nonatomic, strong) UIBlurEffect *respringBlur;
@property (nonatomic, strong) UIVisualEffectView *respringEffectView;
@property (nonatomic, strong) UIWindow *mainAppRootWindow;
@end
