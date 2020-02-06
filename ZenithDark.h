/*
Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.

Written for Cooper Hull, (@mac-user669).

ZenithDark Header file to keep the tweak.x file clean!
*/


#import <Cephei/HBPreferences.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>
#include <CSColorPicker/CSColorPicker.h>

@import UIKit;

@interface ZNGrabberAccessoryView : UIImageView
@end


NSMutableDictionary *prefs;

#define kDarkModeColor [UIColor colorWithWhite:0.0 alpha:0.44]

#define kLightModeColor [UIColor colorWithWhite:1.0 alpha:0.7]

#define kColor1 [UIColor redColor]   // Color used for testing
#define kColor2 [UIColor greenColor] // Color used for testing
#define kColor3 [UIColor blueColor]  // Color used for testing
#define kColor4 [UIColor cyanColor]  // Color used for testing

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.mac-user669.zenithdark.plist"
