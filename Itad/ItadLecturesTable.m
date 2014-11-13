#import "ItadLecturesTable.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ItadLecturesTable() <MSFilter>

@property (nonatomic, strong)   MSTable *table;
@property (nonatomic)           NSInteger busyCount;

@end

@implementation ItadLecturesTable

@synthesize items;

+ (ItadLecturesTable *)defaultService
{
    // Create a singleton instance of ItadLecturesTable
    static ItadLecturesTable* service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[ItadLecturesTable alloc] init];
    });
    
    return service;
}

-(ItadLecturesTable *)init
{
    self = [super init];
    
    if (self)
    {
        // Initialize the Mobile Service client with your URL and key
        MSClient *client = [MSClient clientWithApplicationURLString:@"https://itad.azure-mobile.net/"
                                                     applicationKey:@"gpTtvdJLiFqqpkpqhuquyIKlomKsuX67"];
        
        // Add a Mobile Service filter to enable the busy indicator
        self.client = [client clientWithFilter:self];
        
        // Create an MSTable instance to allow us to work with the TodoItem table
        self.table = [_client tableWithName:@"Lecture"];
        
        self.items = [[NSMutableArray alloc] init];
        self.busyCount = 0;
    }
    
    return self;
}

- (void)refreshDataOnSuccess:(QSCompletionBlock)completion
{
    [self.table readWithCompletion:^(NSArray *partners, NSInteger totalCount, NSError *error) {
        if(error) {
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *partner in partners) {
                NSLog(@"Lecture: %@", [partner objectForKey:@"name"]);
            }
            items = [partners mutableCopy];
            completion();
        }
    }];
}

- (void)busy:(BOOL)busy
{
    // assumes always executes on UI thread
    if (busy)
    {
        if (self.busyCount == 0 && self.busyUpdate != nil)
        {
            self.busyUpdate(YES);
        }
        self.busyCount++;
    }
    else
    {
        if (self.busyCount == 1 && self.busyUpdate != nil)
        {
            self.busyUpdate(FALSE);
        }
        self.busyCount--;
    }
}

- (void)logErrorIfNotNil:(NSError *) error
{
    if (error)
    {
        NSLog(@"ERROR %@", error);
    }
}

- (void)handleRequest:(NSURLRequest *)request
                 next:(MSFilterNextBlock)next
             response:(MSFilterResponseBlock)response
{
    // A wrapped response block that decrements the busy counter
    MSFilterResponseBlock wrappedResponse = ^(NSHTTPURLResponse *innerResponse, NSData *data, NSError *error)
    {
        [self busy:NO];
        response(innerResponse, data, error);
    };
    
    // Increment the busy counter before sending the request
    [self busy:YES];
    next(request, wrappedResponse);
}

@end
