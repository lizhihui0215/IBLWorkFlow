//
//  IBLAppConfiguration.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
#import "IBLWorkOrderBussinessType.h"
#import "IBLWorkOrderType.h"
#import "IBLFieldConfiguration.h"

@protocol IBLWorkOrderBussinessType;
@protocol IBLWorkOrderType;

/**
 *  账户密码配置
 */
typedef NS_ENUM(NSInteger, IBLAccountType) {
    /**
     *  显示账号密码
     */
    IBLAccountTypeShow,
    /**
     *  不显示账号密码
     */
    IBLAccountTypeHidden
};

/**
 *  支付方式
 */
typedef NS_ENUM(NSInteger, IBLPayModel) {
    /**
     *  网上支付（支付宝，微信）
     */
    IBLPayModelNet,
    /**
     *  现金支付
     */
    IBLPayModelCash
};

@interface IBLAppConfiguration : IBLModel

/// 工单业务类型
@property (nonatomic, strong) NSMutableArray<IBLWorkOrderBussinessType> *workOrderBizTypes;

/// 工单类型
@property (nonatomic, strong) NSMutableArray<IBLWorkOrderType> *workOrderTypes;

/// 下订单的URL地址
@property (nonatomic, copy) NSString *orderURL;

/// 支付方式
@property (nonatomic, assign) IBLPayModel payModel;

/// 账户密码配置
@property (nonatomic, assign) IBLAccountType accountType;

/// 默认的更换套餐值
@property (nonatomic, assign) NSInteger changeType;

/// 默认的生效方式
@property (nonatomic, assign) NSInteger effType;

/// 隐藏输入 （主要针对于临时优惠和票据的配置，仅仅适用于开户工单、续费工单、换销售品工单）
@property (nonatomic, strong) IBLFieldConfiguration *hiddenFields;

/// 非空字段 （开户，更换销售品）
@property (nonatomic, strong) IBLFieldConfiguration *notNullFields;

@end
