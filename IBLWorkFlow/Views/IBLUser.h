//
//  IBLUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
#import "IBLPremission.h"

@protocol IBLPremission <NSObject>

@end

@interface IBLUser : IBLModel
@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, copy) NSString *password;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, strong) NSArray<IBLPremission> *permissions;

@property (nonatomic, assign, readonly) BOOL isOnlinePay;

@property (nonatomic, assign, readonly) BOOL isHiddenPreferential;

@property (nonatomic, assign, readonly) BOOL isHiddenExtraMonthLength;



@end
