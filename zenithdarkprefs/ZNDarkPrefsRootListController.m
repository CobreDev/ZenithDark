#import "ZNDarkPrefsRootListController.h"
#include <CSColorPicker/CSColorPicker.h>

#define THEME_COLOR                                                    \
   [UIColor colorWithRed:0.82                                          \
                   green:0.64                                          \
                    blue:0.00                                          \
                   alpha:1.0];


@implementation ZNDarkPrefsRootListController

+ (UIColor *)hb_tintColor {
   return THEME_COLOR;
 }

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// share button for our tweak :P
	 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareTapped)];
}

- (void)resetSettings {
	CFArrayRef keyList = CFPreferencesCopyKeyList(CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (keyList) {
		CFPreferencesSetMultiple(nil, keyList, CFSTR("com.mac-user669.zenithdark"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
		CFRelease(keyList);
	}
	[[NSFileManager defaultManager] removeItemAtPath:@"/var/mobile/Library/Preferences/com.mac-user669.zenithdark.plist" error:nil];

	[self respring];
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


- (void)respring {
  [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil]; // Dismisses keyboard
  [HBRespringController respringAndReturnTo:[NSURL URLWithString:@"prefs:root=ZenithDark"]];
}

-(void)respringPopUp {

  UIAlertController *confirmRespringAlert = [UIAlertController alertControllerWithTitle:@"Apply Settings?" message:@"This will respring your device." preferredStyle:UIAlertControllerStyleActionSheet];  
  UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"Respring" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {  

    [self performSelector:@selector(respring) withObject:nil afterDelay:0.0];

    }]; 

  UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]; 

    [confirmRespringAlert addAction:cancel];  
    [confirmRespringAlert addAction:confirm]; 


  [self presentViewController:confirmRespringAlert animated:YES completion:nil]; 
}

@end
