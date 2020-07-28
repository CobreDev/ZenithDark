#include "ZDPRootListController.h"

// #define THEME_COLOR [UIColor red: 0.65, green: 0.35, blue: 0.00, alpha: 1.00];

#define THEME_COLOR                                                    \
   [UIColor colorWithRed:0.65                                          \
                   green:0.35                                          \
                    blue:0.00                                          \
                   alpha:1.00];

@implementation ZDPRootListController

+ (UIColor *)tintColor {
   return THEME_COLOR;
 }

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)respring {
	UIAlertController *respring = [UIAlertController alertControllerWithTitle:@"ZenithDark"
									message:@"Do you want to Respring?"
									preferredStyle:UIAlertControllerStyleAlert];

	UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
			[self respringUtil];
	}];

	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[respring addAction:confirmAction];
	[respring addAction:cancelAction];
	[self presentViewController:respring animated:YES completion:nil];

}

-(void)respringUtil {
	NSTask *t = [[NSTask alloc] init];
    [t setLaunchPath:@"/usr/bin/killall"];
    [t setArguments:[NSArray arrayWithObjects:@"backboardd", nil]];
    [t launch];
}

//Adds a method to open the github link for the sourcecode
- (void)openGithub {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/CobreDev/ZenithDark"]];
}

@end
