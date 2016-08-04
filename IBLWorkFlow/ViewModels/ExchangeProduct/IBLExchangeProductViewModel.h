//
// Created by 李智慧 on 7/25/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IBLRelateUser;


@interface IBLExchangeProductViewModel : NSObject

@property (nonatomic, strong, readonly) IBLRelateUser *user;

+ (instancetype)modelWithUser:(IBLRelateUser *)user;

- (NSString *)account;

- (NSString *)status;

- (NSString *)username;

- (NSString *)phone;

- (NSString *)region;

- (NSString *)finishedDate;

- (NSString *)product;

- (NSString *)exchangeType;
@end