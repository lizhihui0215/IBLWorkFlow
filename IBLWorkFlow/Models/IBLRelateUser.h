//
//  IBLRelateUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLRelateUser : IBLModel

/// 用户Id
@property (nonatomic, assign) NSInteger servId;
/// 用户账号
@property (nonatomic, copy) NSString *account;
/// 用户姓名
@property (nonatomic, copy) NSString *username;
/// 电话号码
@property (nonatomic, copy) NSString *phone;
/// 邮箱
@property (nonatomic, copy) NSString *email;
/// 联系地址
@property (nonatomic, copy) NSString *address;
/// 身份证号
@property (nonatomic, copy) NSString *idNo;
/// 所属区域
@property (nonatomic, copy) NSString *areaName;
/// 所属区域ID
@property (nonatomic, copy) NSString *areaIdentifier;
/// 订购套餐
@property (nonatomic, copy) NSString *offerName;
/// 销售品
@property (nonatomic, copy) NSString *offerIdentifier;
/// 失效时间
@property (nonatomic, copy) NSString *expDate;
/// 生效时间
@property (nonatomic, copy) NSString *effDate;
/// 身份证号
@property (nonatomic, copy) NSString *userIdentifier;
/// 备注
@property (nonatomic, copy) NSString *comments;
/// 办理时间
@property (nonatomic, copy) NSString *createDate;
/// 状态
@property (nonatomic, copy) NSString *state;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, assign) NSInteger certType;

@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *comAddr;
@property (nonatomic, copy) NSString *simpleComName;


@end
