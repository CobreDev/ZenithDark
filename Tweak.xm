#import "ZenithDark.h"

/*
Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.
Written for Cooper Hull, @mac-user669.
*/


BOOL kEnabled;
BOOL kCustomDarkColorEnabled;
BOOL kCustomLightColorEnabled;

inline NSString *StringForPreferenceKey(NSString *key) {
    NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] ? : [NSDictionary new];
    return prefs[key];
}

%group TweakGroup
%hook ZNGrabberAccessoryView

// this is called when iOS 13's dark mode is enabled!
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  %orig(previousTraitCollection);
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       [self setBackgroundColor:[UIColor cscp_colorFromHexString:StringForPreferenceKey(@"kDarkCustomColor")]];
    }

    else {
      if (kCustomLightColorEnabled) {
     [self setBackgroundColor:[UIColor cscp_colorFromHexString:StringForPreferenceKey(@"kLightCustomColor")]];
      }
      else {
     [self setBackgroundColor:kLightModeColor];
      }
    }
  }
}

// the method we  modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)
-(void)setBackgroundColor:(UIColor *)backgroundColor {

  // by default have our tweak overide this.
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
      if (kCustomDarkColorEnabled) {
       %orig([UIColor cscp_colorFromHexString:StringForPreferenceKey(@"kDarkCustomColor")]); 
      }

      else {  
       %orig(kDarkModeColor);
      }
    }

    else {
    %orig;
    }
  }
}


// we need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
%end
%end

static void loadPrefs() {   // Load preferences to make sure changes are written to the plist

  // Thanks to skittyblock!
  CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
  if(keyList) {
    prefs = (NSMutableDictionary *)CFPreferencesCopyMultiple(keyList, CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
    CFRelease(keyList);
  } else {
    prefs = nil;
  }

  if (!prefs) {
   prefs = [NSMutableDictionary dictionaryWithContentsOfFile:PLIST_PATH];

  }

  kEnabled = [([prefs objectForKey:@"kEnabled"] ?: @(YES)) boolValue];    //our preference values that write to a plist file when a user selects somethings
  kCustomDarkColorEnabled = [([prefs objectForKey:@"kCustomDarkColorEnabled"] ?: @(NO)) boolValue];    //our preference values that write to a plist file when a user selects somethings
  kCustomLightColorEnabled = [([prefs objectForKey:@"kCustomLightColorEnabled"] ?: @(NO)) boolValue];    //our preference values that write to a plist file when a user selects somethings

}


// Thanks to skittyblock!
static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  loadPrefs();
}


%ctor {   // Our constructor

 loadPrefs();   // Load our prefs

 if (kEnabled) {    // If enabled
      %init(TweakGroup);   // Enable the group "TweakGroup"
  }

 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.mac-user669.zenithdark.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);      // We use this to make sure we load Zenith's dynamic library at runtime so we can modify it with our tweak.
}