#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <Foundation/Foundation.h>


typedef void (^QSCompletionBlock) ();
typedef void (^QSCompletionWithIndexBlock) (NSUInteger index);
typedef void (^QSBusyUpdateBlock) (BOOL busy);


@interface ItadTable : NSObject

@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, strong)   MSClient *client;
@property (nonatomic, copy)     QSBusyUpdateBlock busyUpdate;

+ (ItadTable *)startService:(NSString *)tableName;

- (void)refreshDataOnSuccess:(QSCompletionBlock)completion;

- (void)handleRequest:(NSURLRequest *)request
                 next:(MSFilterNextBlock)next
             response:(MSFilterResponseBlock)response;

@end
