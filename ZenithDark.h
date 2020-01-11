/*

Dark Mode for Zenith's Grabber view!
Copyright 2020 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC.
All code was written for learning purposes and credit must be given to the original author.

Written for Cooper Hull, @(mac-user669).

ZenithDark Header file to keep the tweak.x file clean!


*/


// We then import UIKit so we can override the color property without this Theos doesn't have a clue what those properties are.
@import UIKit;

// We make an interface to let Theos know that ZNGrabberAccessoryView is of type UIImageView.
@interface ZNGrabberAccessoryView : UIImageView
@end

// Dark Zenith color we are using macros so we can call it later if need be.
#define kDarkModeColor [UIColor colorWithWhite:0.0 alpha:0.44]

// Stock Zenith color we are using macros so we can call it later if need be.
#define kLightModeColor [UIColor colorWithWhite:1.0 alpha:1.0]
