#import "ZenithDark.h"
#import <Cephei/HBPreferences.h>
#import <CepheiPrefs/HBRootListController.h>
#import <CepheiPrefs/HBAppearanceSettings.h>

/*

Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.

Written for Cooper Hull, @(mac-user669).


*/

%group Tweak13
// We then hook the class in this case Zenith's grabber view is called “ZNGrabberAccessoryView” 
%hook ZNGrabberAccessoryView

// this is called when iOS 13's dark mode is enabled!
-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
   %orig(previousTraitCollection);
  if (kEnabled) { 
  // if the tweak is enabled and the version is iOS 13 or later run our code
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       [self setBackgroundColor:kDarkModeColor];
    }

    else {
     [self setBackgroundColor:kLightModeColor];
    }
  }
}

else {
  %orig(previousTraitCollection);
}

}



// the method we  modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)
-(void)setBackgroundColor:(UIColor *)backgroundColor {
  %orig;
  if (kEnabled) {
  // by default have our tweak overide this.
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       %orig(kDarkModeColor);
    }
  }

    else {
    %orig;
    }
  }
}

  %end   // We need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
%end

static BOOL ios13;


%group Tweak12

//We then hook the class in this case Zenith's grabber view is called “ZNGrabberAccessoryView” 
%hook ZNGrabberAccessoryView
// The method we then modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)

-(void)setBackgroundColor:(UIColor *)backgroundColor {
  //call the original function then pass our custom argument to the backgroundColor argument as shown below.
  %orig(kDarkModeColor);
}

// We need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
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
}


// Thanks to skittyblock!
static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
  loadPrefs();
}

%ctor {   // Our constructor

 loadPrefs();   // Load our prefs

 if (kEnabled) {    // If enabled
    if (@available(iOS 13, *)) {    // If the device is running iOS 13
      ios13 = YES;    // Set "iOS13" to "YES"
      %init(Tweak13);   // Enable the group "Tweak13"
    } else {
      ios13 = NO;   // Set "iOS13" to "NO"
      %init(Tweak12);   // Enable the group "Tweak12"
    }
  }

 CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.mac-user669.zenithdark.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);

dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);      // We use this to make sure we load Zenith's dynamic library at runtime so we can modify it with our tweak.

}
