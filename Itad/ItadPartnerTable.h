#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <Foundation/Foundation.h>


typedef void (^QSCompletionBlock) ();
typedef void (^QSCompletionWithIndexBlock) (NSUInteger index);
typedef void (^QSBusyUpdateBlock) (BOOL busy);


@interface ItadPartnerTable : NSObject

@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, strong)   MSClient *client;
@property (nonatomic, copy)     QSBusyUpdateBlock busyUpdate;

+ (ItadPartnerTable *)startService;

- (void)refreshDataOnSuccess:(QSCompletionBlock)completion;

- (void)handleRequest:(NSURLRequest *)request
                 next:(MSFilterNextBlock)next
             response:(MSFilterResponseBlock)response;

@end
