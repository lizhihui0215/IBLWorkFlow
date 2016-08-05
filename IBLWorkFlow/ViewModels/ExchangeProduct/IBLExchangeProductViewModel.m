//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLExchangeProductViewModel.h"
#import "IBLRelateUser.h"
#import "IBLCreateAccountHiddenFields.h"

@interface IBLExchangeProductViewModel ()

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@end

@implementation IBLExchangeProductViewModel

- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
    }

    return self;
}

+ (instancetype)modelWithUser:(IBLRelateUser *)user {
    return [[self alloc] initWithUser:user];
}

- (NSString *)account {
    return self.user.account;
}


- (NSString *)status {
    return self.user.state;
}

- (NSString *)username {
    return self.user.username;
}

- (NSString *)phone {
    return self.user.phone;
}

- (NSString *)region {
    return self.user.areaName;
}

- (NSString *)finishedDate {
    return self.user.expDate;
}

- (NSString *)product {
    return self.user.offerName;
}

- (NSString *)exchangeType {
    return nil;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    return [self.hiddenFields.exchangeProductHiddenFieldsDictionary[indexPath] boolValue];
}
@end