//
//  IBLOrderRelateUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLOrderRelateUser : IBLModel

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *addr;
@property (nonatomic, copy) NSString *idNo;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *bizStation;
//@property (nonatomic, copy) NSString *nodeId;
@property (nonatomic, copy) NSString *offerName;
@property (nonatomic, copy) NSString *offerId;
@property (nonatomic, copy) NSString *expDate;
@property (nonatomic, copy) NSString *exfDate;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *comAddr;

@property (nonatomic, assign) NSInteger certType;

@property (nonatomic, copy) NSString *simpleComName;



@end
