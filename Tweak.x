
// Basically all of this was written by J.K. Hayslip, aka iKilledAppl3. He's a huge help, go follow him on twitter.

// Idea by Cooper Hull, aka mac-user669. Thanks to iKA for the help!

//––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––\\

// We make an interface to let Theos know that ZNGrabberAccessoryView is of type UIImageView;
@interface ZNGrabberAccessoryView : UIImageView
@end


// We then import UIKit so we can override the color property without this Theos doesn't have a clue what those properties are.
@import UIKit;


//We then hook the class in this case Zenith's grabber view is called “ZNGrabberAccessoryView” 
%hook ZNGrabberAccessoryView
// The method we then modify is this method that is called from UIImageView to set the backgroundColor of the image view. 
// Since the grabber view is of type UIImageView we can modify this method :)

-(void)setBackgroundColor:(UIColor *)backgroundColor {
	//Call the original function then pass our custom argument to the backgroundColor argument as shown below.
	%orig([UIColor colorWithWhite:0.0 alpha:0.44]);

}

// We need to make sure we tell theos that we are finished hooking this class not doing so with cause the end of the world :P
%end

// Our constructor
%ctor {

// We use this to make sure we load Zenith's dynamic library at runtime so we can modify it with our tweak.
dlopen ("/Library/MobileSubstrate/DynamicLibraries/Zenith.dylib", RTLD_NOW);

}