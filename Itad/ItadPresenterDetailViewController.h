#import <UIKit/UIKit.h>

@interface ItadPresenterDetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *data;

@property (strong, nonatomic) IBOutlet UILabel *presenterName;
@property (strong, nonatomic) IBOutlet UIImageView *presenterImage;
@property (strong, nonatomic) IBOutlet UITextView *presenterDecription;

@end
