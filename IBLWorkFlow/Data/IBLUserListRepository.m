//
//  IBLUserListRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserListRepository.h"

@implementation IBLFetchUserListInfo
- (instancetype)initWithAccount:(NSString *)account
                       username:(NSString *)username
                          phone:(NSString *)phone
                       areaName:(NSString *)areaName
                 areaIdentifier:(NSInteger)areaIdentifier
                 userIdentifier:(NSString *)userIdentifier
                        address:(NSString *)address {
    self = [super initWithStart:0 pageSize:0];
    if (self) {
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.areaName = areaName;
        self.areaIdentifier = areaIdentifier;
        self.userIdentifier = userIdentifier;
        self.address = address;
    }

    return self;
}

+ (instancetype)infoWithAccount:(NSString *)account
                       username:(NSString *)username
                          phone:(NSString *)phone
                       areaName:(NSString *)areaName
                 areaIdentifier:(NSInteger)areaIdentifier
                 userIdentifier:(NSString *)userIdentifier
                        address:(NSString *)address {
    return [[self alloc] initWithAccount:account
                                username:username
                                   phone:phone
                                areaName:areaName
                          areaIdentifier:areaIdentifier
                          userIdentifier:userIdentifier
                                 address:address];
}


@end

@implementation IBLUserListRepository

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler {

}
@end
