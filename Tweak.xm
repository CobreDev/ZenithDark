/*

Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.

Written for Cooper Hull, @(mac-user669).


*/

#import "ZenithDark.h"

static BOOL enabled;
static BOOL replaceOriginalView;
static BOOL notificationBadgesEnabled;
static void loadPrefs() {
  static NSMutableDictionary *settings;

  CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.mac-user669.zenithdarkprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
  if (keyList) {
    settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.mac-user669.zenithdarkprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
    CFRelease(keyList);
  } else {
    settings = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.mac-user669.zenithdarkprefs.plist"];
  }

    enabled = [([settings objectForKey:@"enabled"] ? [settings objectForKey:@"enabled"] : @(YES)) boolValue];
  replaceOriginalView = [([settings objectForKey:@"replaceoriginalview"] ? [settings objectForKey:@"replaceoriginalview"] : @(YES)) boolValue];
  notificationBadgesEnabled = [([settings objectForKey:@"notificationBadgesEnabled"] ? [settings objectForKey:@"notificationBadgesEnabled"] : NO) boolValue];
}


// We then hook the class in this case Zenith's grabber view is called “ZNGrabberAccessoryView” 
%hook ZNGrabberAccessoryView
// this is called when iOS 13's dark mode is enabled!
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  %orig(previousTraitCollection);
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       [self setBackgroundColor:kDarkModeColor];
    }

    else {
     [self setBackgroundColor:kLightModeColor];
    }
  }
}

// the method we  modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)
-(void)setBackgroundColor:(UIColor *)backgroundColor {
  // by default have our tweak overide this.
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       %orig(kDarkModeColor);
    }

    else {
    %orig;
    }
  }
}

// we need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
%end

// our constructor
%ctor {

loadPrefs();

// We use this to make sure we load Zenith's dynamic library at runtime so we can modify it with our tweak.
dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);

}