//
//  IBLFetchOnlineRecord.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOnlineRecord.h"

@interface IBLFetchOnlineRecord ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@property (nonatomic, assign) NSInteger start;

@end

@implementation IBLFetchOnlineRecord

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)fetchOnlineWithAccount:(NSString *)account
                          date:(NSString *)date
                     isRefresh:(BOOL)isRefresh
               completeHandler:(void (^)(NSArray<IBLNetworkRecord *> *, NSError *))handler;
{
    if (isRefresh) self.start = 0; else self.start += 1;
    [self.userListRepository fetchOnlineWithAccount:account
                                               date:date
                                              start:self.start
                                           pageSize:20
                                    completeHandler:^(NSArray<IBLNetworkRecord *> *records, NSError *error) {
                                        if(error && self.start > 0) self.start -= 1;
                                        handler(records, error);
                                    }];
    
}
@end
