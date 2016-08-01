//
//  IBLUserSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserSearchViewModel.h"

@interface IBLUserSearchViewModel ()

@end

@implementation IBLUserSearchResult

- (instancetype)initWithSearchType:(IBLUserSearchType)searchType
                            region:(IBLRegion *)region
                           account:(NSString *)account
                          username:(NSString *)username
                             phone:(NSString *)phone
                    userIdentifier:(NSString *)userIdentifier
                           address:(NSString *)address {
    self = [super init];
    if (self) {
        self.searchType = searchType;
        self.region = region;
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.userIdentifier=userIdentifier;
        self.address=address;
    }

    return self;
}

+ (instancetype)resultWithSearchType:(IBLUserSearchType)searchType
                              region:(IBLRegion *)region
                             account:(NSString *)account
                            username:(NSString *)username
                               phone:(NSString *)phone
                      userIdentifier:(NSString *)userIdentifier
                             address:(NSString *)address {
    return [[self alloc] initWithSearchType:searchType
                                     region:region
                                    account:account
                                   username:username
                                      phone:phone
                             userIdentifier:userIdentifier
                                    address:address];
}

@end

@implementation IBLUserSearchViewModel

- (instancetype)initWithSearchType:(IBLUserSearchType)searchType {
    self = [super init];
    if (self) {
        _searchType = searchType;
    }

    return self;
}

@end
