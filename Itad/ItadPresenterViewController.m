#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "ItadPresenterViewController.h"
#import "ItadPresenterDetailViewController.h"
#import "ItadPresenterTable.h"

@interface ItadPresenterViewController ()

// Private properties
@property (strong, nonatomic) ItadPresenterTable *todoService;

@end

@implementation ItadPresenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create the todoService - this creates the Mobile Service client inside the wrapped service
    self.todoService = [ItadPresenterTable defaultService];
    
    // have refresh control reload all data from server
    [self.refreshControl addTarget:self
                            action:@selector(onRefresh:)
                  forControlEvents:UIControlEventValueChanged];
    // load the data
    [self refresh];
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

- (void) refresh
{
    [self.refreshControl beginRefreshing];
    
    [self.todoService refreshDataOnSuccess:^
     {
         [self.refreshControl endRefreshing];
         [self.tableView reloadData];
     }];
}

- (void)onRefresh:(id) sender
{
    [self refresh];
}


- (UIFont *)fontForCell
{
    return [UIFont boldSystemFontOfSize:18.0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"presenterCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Set the label on the cell and make sure the label color is black (in case this cell
    // has been reused and was previously greyed out
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSDictionary *item = [self.todoService.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [item objectForKey:@"firstName"], [item objectForKey:@"lastName"]];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[item objectForKey:@"imageUri"]]];
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of items in the todoService items array
    return [self.todoService.items count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ItadPresenterDetailViewController *detailController =segue.destinationViewController;
    NSDictionary *item = [self.todoService.items objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailController.data = item;
}

@end
