/*
Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.
Written for Cooper Hull, @mac-user669.
*/

@import UIKit;

@interface ZNGrabberAccessoryView : UIImageView
@end

#define kDarkModeColor [UIColor colorWithWhite:0.0 alpha:0.44]
#define kLightModeColor [UIColor colorWithWhite:1.0 alpha:0.7]

#define kColor1 [UIColor redColor]
#define kColor2 [UIColor greenColor] 
#define kColor3 [UIColor blueColor]  
#define kColor4 [UIColor cyanColor]  


%group Tweak13
%hook ZNGrabberAccessoryView

	-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	  %orig(previousTraitCollection);
	    if (@available(iOS 13, *)) {

	    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
	       [self setBackgroundColor:kColor1];
	    }

	    else {
	     [self setBackgroundColor:kColor2];
	    }

	  }
	}

	-(void)setBackgroundColor:(UIColor *)backgroundColor {
	    if (@available(iOS 13, *)) {

	    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
	       %orig(kColor1);
	    }

	    else {
	    %orig(kColor2);
	    }

	  }
	}

%end
%end

static BOOL ios13;

%group Tweak12
%hook ZNGrabberAccessoryView

	-(void)setBackgroundColor:(UIColor *)backgroundColor {
	       %orig(kColor1);
	}

%end
%end

%ctor {

    if (@available(iOS 13, *)) { 
      ios13 = YES; 
      %init(Tweak13);
    } else {
      ios13 = NO;
      %init(Tweak12);
    }

	dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);   

}