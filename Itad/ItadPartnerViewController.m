#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "ItadPartnerViewController.h"
#import "ItadPartnerTable.h"

@interface ItadPartnerViewController ()

// Private properties
@property (strong, nonatomic) ItadPartnerTable *todoService;

@end

@implementation ItadPartnerViewController

@synthesize todoService;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIGraphicsBeginImageContext(self.tableView.tableHeaderView.frame.size);
    [[UIImage imageNamed:@"Background.png"] drawInRect:self.tableView.tableHeaderView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithPatternImage:image];
    
    // Create the todoService - this creates the Mobile Service client inside the wrapped service
    self.todoService = [ItadPartnerTable defaultService];
    
    // have refresh control reload all data from server
    [self.refreshControl addTarget:self
                            action:@selector(onRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    // load the data
    [self refresh];
}

- (void) refresh
{
    [self.refreshControl beginRefreshing];
    
    [self.todoService refreshDataOnSuccess:^
     {
         [self.refreshControl endRefreshing];
         [self.tableView reloadData];
     }];
}

- (UIFont *)fontForCell
{
    return [UIFont boldSystemFontOfSize:18.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the label on the cell and make sure the label color is black (in case this cell
    // has been reused and was previously greyed out
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSDictionary *item = [self.todoService.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"name"];
    //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[item objectForKey:@"imageUri"]]];
    //cell.imageView.image = [UIImage imageWithData:imageData];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of items in the todoService items array
    return [self.todoService.items count];
}

- (void)onRefresh:(id) sender
{
    [self refresh];
}


@end
