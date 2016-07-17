//
//  IBLOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
#import "IBLWorkOrderBussinessType.h"
#import "IBLWorkOrderType.h"

/**
 *  工单状态
 */
typedef NS_ENUM(NSInteger, IBLOrderStatus) {
    /**
     *  未派单
     */
    IBLOrderStatusUnsend = 1,
    /**
     *  已派单
     */
    IBLOrderStatusSended,
    /**
     *  转发中
     */
    IBLOrderStatusForwarding,
    /**
     *  处理中
     */
    IBLOrderStatusHandling,
    /**
     *  作废
     */
    IBLOrderStatusInvalid,
    /**
     *  完成
     */
    IBLOrderStatusFinished,
    /**
     *  反馈中
     */
    IBLOrderStatusFeedback,
};

/**
 *  工单优先级
 */
typedef NS_ENUM(NSInteger, IBLPriorityStatus) {
    /**
     *  紧急
     */
    IBLPriorityStatusEmergency,
    /**
     *  一般
     */
    IBLPriorityStatusGeneral,
    /**
     *  不紧急
     */
    IBLPriorityStatusNoEmergency,
};



@interface IBLOrder : IBLModel

/// 工单ID
@property (nonatomic, assign) NSInteger identifier;

/// 工单标题
@property (nonatomic, copy) NSString *title;

/// 工单类型
@property (nonatomic, assign) IBLWorkOrderStatus type;

/// 工单业务类型
@property (nonatomic, assign) IBLWorkOrderBizStatus bizType;

/// 工单内容
@property (nonatomic, copy) NSString *content;

/// 工单状态
@property (nonatomic, assign) IBLOrderStatus status;

/// 工单优先级
@property (nonatomic, assign) IBLPriorityStatus priority;

/// 处理说明
@property (nonatomic, copy) NSString *note;

/// 处理建议
@property (nonatomic, copy) NSString *suggest;

/// 创建时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSString *createTime;

/// 时效时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSString *expireTime;

/// 最近更新时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, copy) NSString *lastModifyTime;

/// 关联用户ID
@property (nonatomic, assign) NSInteger userIdentifier;

/// 关联用户登录帐号
@property (nonatomic, copy) NSString *userAccount;

/// 创建人员姓名
@property (nonatomic, copy) NSString *creatorName;

/// 创建者联系电话
@property (nonatomic, copy) NSString *creatorPhone;

/// 所属校区ID （报装工单特有）
@property (nonatomic, copy) NSString *residentialIdentifier;

/// 订购的销售品ID （报装工单特有）
@property (nonatomic, copy) NSString *productIdentifier;

/// 用户姓名 （报装工单特有）
@property (nonatomic, copy) NSString *username;

@property (nonatomic, strong) NSMutableArray<NSNumber *> *actions;

@end
