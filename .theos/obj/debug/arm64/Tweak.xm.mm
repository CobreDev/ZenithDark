#line 1 "Tweak.xm"











#import "ZenithDark.h"

static BOOL enabled;


static void refreshPrefs() {
  CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.mac-user669.zenithdarkprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
  if (keyList) {
    settings = (NSMutableDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.mac-user669.zenithdarkprefs"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
    CFRelease(keyList);
  } else {
    settings = nil;
  }
  if (!settings) {
    settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.mac-user669.zenithdarkprefs.plist"];
  }

  enabled = [([settings objectForKey:@"enabled"] ?: @(YES)) boolValue];
}




#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class ZNGrabberAccessoryView; 
static void (*_logos_orig$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$)(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST, SEL, UITraitCollection *); static void _logos_method$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST, SEL, UITraitCollection *); static void (*_logos_orig$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$)(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST, SEL, UIColor *); static void _logos_method$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST, SEL, UIColor *); 

#line 34 "Tweak.xm"

  
static void _logos_method$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UITraitCollection * previousTraitCollection) {
  if(enabled){
  _logos_orig$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$(self, _cmd, previousTraitCollection);
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
    _logos_orig$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$(self, _cmd, previousTraitCollection);
      }

}



static void _logos_method$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$(_LOGOS_SELF_TYPE_NORMAL ZNGrabberAccessoryView* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIColor * backgroundColor) {
    if(enabled){

  
    if (@available(iOS 13, *)) {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
       _logos_orig$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$(self, _cmd, kDarkModeColor);
    }

    else {
    _logos_orig$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$(self, _cmd, backgroundColor);
      }
    }
  }
    else {
    _logos_orig$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$(self, _cmd, backgroundColor);
}
}






static __attribute__((constructor)) void _logosLocalCtor_16c0be02(int __unused argc, char __unused **argv, char __unused **envp) {



dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);

}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$ZNGrabberAccessoryView = objc_getClass("ZNGrabberAccessoryView"); MSHookMessageEx(_logos_class$_ungrouped$ZNGrabberAccessoryView, @selector(traitCollectionDidChange:), (IMP)&_logos_method$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$, (IMP*)&_logos_orig$_ungrouped$ZNGrabberAccessoryView$traitCollectionDidChange$);MSHookMessageEx(_logos_class$_ungrouped$ZNGrabberAccessoryView, @selector(setBackgroundColor:), (IMP)&_logos_method$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$, (IMP*)&_logos_orig$_ungrouped$ZNGrabberAccessoryView$setBackgroundColor$);} }
#line 88 "Tweak.xm"
