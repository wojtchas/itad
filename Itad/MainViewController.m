#import <Foundation/Foundation.h>
#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(IBAction)fbButton:(id)sender{
    NSURL *fbURL = [[NSURL alloc] initWithString:@"fb://profile/ITAD.PWR"];
    // check if app is installed
    if ( ! [[UIApplication sharedApplication] canOpenURL:fbURL] ) {
        // if we get here, we can't open the FB app.
        fbURL = [[NSURL alloc] initWithString:@"https://www.facebook.com/ITAD.PWR?fref=ts"]; // direct URL on FB website to open in safari
    }
    
    [[UIApplication sharedApplication] openURL:fbURL];
}

@end