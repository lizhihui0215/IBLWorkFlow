//
//  IBLRenewViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRenewViewModel.h"

@interface IBLRenewViewModel ()

@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;

@end

@implementation IBLRenewViewModel
- (instancetype)initWithUser:(IBLRelateUser *)user {
    self = [super init];
    if (self) {
        _user = user;
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
    }

    return self;
}

+ (instancetype)modelWithUser:(IBLRelateUser *)user {
    return [[self alloc] initWithUser:user];
}

- (NSString *)account {
    return self.user.account;
}

- (NSString *)state {
    return self.user.state;
}

- (NSString *)username {
    return self.user.username;
}

- (NSString *)pbone {
    return self.user.phone;
}

- (NSString *)regionName {
    return self.user.areaName;
}

- (NSString *)expireDate {
    return self.user.expDate;
}

- (NSString *)product {
    return self.user.offerIdentifier;
}

- (NSString *)productCount {
    return nil;
}

- (NSString *)productPriceAmount {
    return nil;
}

- (NSString *)ticket {
    return nil;
}

- (NSString *)contract {
    return nil;
}

- (NSString *)discount {
    return nil;
}

- (NSString *)give {
    return nil;
}

- (NSString *)pay {
    return nil;
}

- (NSString *)comment {
    return self.user.comments;
}

- (NSString *)renewProductCount {
    return nil;
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)info
          completeHandler:(IBLViewModelCompleteHandler)handler {
    [self.fetchProductPrice fetchProductPrice:info
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error) {
                                  self.productPrices = productPrice;
                                  handler(error);
                              }];
}

- (IBLProductPrice *)productPrice {
    return self.productPrices;
}
@end
