#import "ZNDarkPrefsRootListController.h"
#include <CSColorPicker/CSColorPicker.h>
#import "NSTask.h"

#define THEME_COLOR                                                    \
   [UIColor colorWithRed:0.96                                          \
                   green:0.74                                          \
                    blue:0.00                                          \
                   alpha:1.00];


@implementation ZNDarkPrefsRootListController

+ (UIColor *)hb_tintColor {
   return THEME_COLOR;
 }

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// share button for our tweak :P
	 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareTapped)];
}

// Hide Large Title
- (void)viewDidLoad {
  [super viewDidLoad];

  if (@available(iOS 11, *)) {
    self.navigationController.navigationBar.prefersLargeTitles = false;
    self.navigationController.navigationItem.largeTitleDisplayMode =
        UINavigationItemLargeTitleDisplayModeNever;
  }
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  if (@available(iOS 11, *)) {
    self.navigationController.navigationBar.prefersLargeTitles = false;
    self.navigationController.navigationItem.largeTitleDisplayMode =
        UINavigationItemLargeTitleDisplayModeNever;
  }
}
// End of "Hide Large Title"

//share button action 
- (void)shareTapped {
   
    	 NSString *shareText = @"Turn off the lights! It's too bright! Get dark tabs for #Zenith (@Muirey03) by using #ZenithDark from @mac_user669 and @iKilledAppl3! https://mac-user669.github.io/repo/";
    	 UIImage *image = [UIImage imageWithContentsOfFile:kImagePath];
	     NSArray * itemsToShare = @[shareText, image];
	 
    	UIActivityViewController *controller = [[UIActivityViewController alloc]initWithActivityItems:itemsToShare applicationActivities:nil];
    
    // and present it
    [self presentActivityController:controller];
}

- (void)presentActivityController:(UIActivityViewController *)controller {
    
    // for iPad: make the presentation a Popover
    controller.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:controller animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.barButtonItem = self.navigationItem.rightBarButtonItem;
 
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
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

- (void)resetSettings {
	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList) {
		CFPreferencesSetMultiple(nil, keyList, CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
		CFRelease(keyList);
	}
	[[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Preferences/com.mac-user669.zenithdark.plist" error:nil];

	[self respringUtil];
}

@end
