#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "ItadPartnerViewController.h"
#import "ItadPartnerTable.h"

@interface ItadPartnerViewController ()

// Private properties
@property (strong, nonatomic) ItadPartnerTable *todoService;

@end

@implementation ItadPartnerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create the todoService - this creates the Mobile Service client inside the wrapped service
    self.todoService = [ItadPartnerTable startService];
    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIImage *myImage = [UIImage imageNamed:@"Background.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,300,140);
    
    return imageView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 140;
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
