#import <Foundation/Foundation.h>
#import "ItadRegisterViewController.h"

@interface ItadRegisterViewController ()

@end

@implementation ItadRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullURL = @"http://codeguru.geekclub.pl/kalendarium/podglad-wydarzenia/it-academic-day-2014---politechnika-wroclawska,10507";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];
}

@end
