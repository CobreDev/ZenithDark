// We make an interface to let Theos know that ZNGrabberAccessoryView is of type UIImageView;
@interface ZNGrabberAccessoryView : UIImageView
@end

BOOL kDarkModeEnabled;

/*

Colorize Zenith's Grabber view with ease!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.


*/

// We then import UIKit so we can override the color property without this Theos doesn't have a clue what those properties are.
@import UIKit;


//We then hook the class in this case Zenith's grabber view is called “ZNGrabberAccessoryView” 
%hook ZNGrabberAccessoryView
// the method we then modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)

-(void)setBackgroundColor:(UIColor *)backgroundColor {
	//call the original function then pass our custom argument to the backgroundColor argument as shown below.
        kDarkModeEnabled = ([UITraitCollection currentTraitCollection].userInterfaceStyle == UIUserInterfaceStyleDark);
        if (kDarkModeEnabled) {
        %orig([UIColor colorWithWhite:0.0 alpha:0.44]);
       }
       else {
       %orig;
       }


}

// we need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
%end

// our constructor
%ctor {

// We use this to make sure we load Zenith's dynamic library at runtime so we can modify it with our tweak.
dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);

}