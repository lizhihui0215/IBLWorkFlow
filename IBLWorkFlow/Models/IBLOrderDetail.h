//
//  IBLOrderDetail.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 30/08/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLOrderDetail : IBLModel
/// 订单号
@property (nonatomic, copy) NSString *orderNo;
/// 订单类型
@property (nonatomic, copy) NSString *orderType;
/// 支付类型
@property (nonatomic, copy) NSString *payType;
/// 套餐
@property (nonatomic, copy) NSString *offerName;
/// 区域
@property (nonatomic, copy) NSString *nodeName;
/// 账号
@property (nonatomic, copy) NSString *account;
/// 密码
@property (nonatomic, copy) NSString *password;
/// 用户姓名
@property (nonatomic, copy) NSString *userName;
/// 身份证号
@property (nonatomic, copy) NSString *idNo;
/// 电话号码
@property (nonatomic, copy) NSString *phone;
/// 联系地址
@property (nonatomic, copy) NSString *addr;
/// 购买销售品数
@property (nonatomic, copy) NSString *buyLength;
/// 临时赠送量（带单位）
@property (nonatomic, assign) NSInteger extraLength;
/// 总量（带单位）
@property (nonatomic, copy) NSString *totalLength;
/// 支付金额，单位分
@property (nonatomic, assign) NSInteger payCost;
/// 销售品总金额，单位分
@property (nonatomic, assign) NSInteger totalCost;
/// 其它金额，如果为负数，则为优惠金额
@property (nonatomic, copy) NSString *otherCost;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comAddr;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *simpleComName;
@property (nonatomic, assign) NSInteger certType;


@property (nonatomic, copy) NSString *servId;

@end
