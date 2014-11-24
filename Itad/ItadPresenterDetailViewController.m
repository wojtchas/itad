#import <Foundation/Foundation.h>
#import "ItadPresenterDetailViewController.h"

@interface ItadPresenterDetailViewController ()

@end

@implementation ItadPresenterDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.data) {
        self.presenterName.text = [NSString stringWithFormat:@"%@ %@", [self.data objectForKey:@"firstName"], [self.data objectForKey:@"lastName"]];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.data objectForKey:@"imageUri"]]];
        self.presenterImage.image = [UIImage imageWithData:imageData];
        
        self.presenterDecription.text = [self.data objectForKey:@"description"];
    }
    
}

@end

