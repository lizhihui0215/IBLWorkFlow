//
//  IBLFetchUserList.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchUserList.h"

@interface IBLFetchUserList ()

@property (nonatomic, strong) IBLUserListRepository *userListRepository;

@property (nonatomic, assign) NSInteger start;

@end

@implementation IBLFetchUserList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userListRepository = [[IBLUserListRepository alloc] init];
    }
    return self;
}

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler {
    if (refresh) self.start = 0; else self.start ++;
    result.start = self.start;
    result.pageSize = 20;
    [self.userListRepository fetchUserListWithIsRefresh:refresh
                                            fetchResult:result
                                        completeHandler:^(NSArray<IBLRelateUser *> *users, NSError *error){
                                            handler(users,error);
                                        }];
}
@end
