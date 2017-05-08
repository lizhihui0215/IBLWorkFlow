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
     *  已派单 （我的工单未处理）
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
    IBLPriorityStatusEmergency = 1,
    /**
     *  一般
     */
    IBLPriorityStatusGeneral,
    /**
     *  不紧急
     */
    IBLPriorityStatusNoEmergency,
};

/**
 *  工单操作类型
 */
typedef NS_ENUM(NSInteger, IBLOrderAction) {
    /**
     *  处理
     */
    IBLOrderActionHandling,
    /**
     *  派单
     */
    IBLOrderActionSend,
    /**
     *  转发
     */
    IBLOrderActionForward,
    /**
     *  开户
     */
    IBLOrderActionCreate,
    
    /**
     *  作废
     */
    IBLOrderActionTrash,
    
    /**
     *  查看单个(我的工单)
     */
    IBLOrderActionViewSingle,
    /**
     *  完成
     */
    IBLOrderActionFinish,
    /**
     *  查看
     */
    IBLOrderActionView,

    /**
     *  删除
     */
    IBLOrderActionDelete,
    
    
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
@property (nonatomic, assign) NSInteger residentialIdentifier;

/// 订购的销售品ID （报装工单特有）
@property (nonatomic, assign) NSInteger productIdentifier;

/// 用户姓名 （报装工单特有）
@property (nonatomic, copy) NSString *username;

/// 小区名称 (报装工单特有)
@property (nonatomic, copy) NSString *regionName;

/// 销售品名称 (报装工单特有)
@property (nonatomic, copy) NSString *productName;

/// 身份证号 (报装工单特有)
@property (nonatomic, copy) NSString *identifierNumber;

/// 备注 (报装工单特有)
@property (nonatomic, copy) NSString *remark;

/// 生效方式 (报装工单特有)
@property (nonatomic, assign) IBLOrderEffectType effectType;

/// 生效日期 (报装工单特有)
@property (nonatomic, copy) NSString *effectDate;

/// 用户联系电话 (报装工单特有)
@property (nonatomic, copy) NSString *phone;

/// 用户联系地址 (报装工单特有)
@property (nonatomic, copy) NSString *address;

/// 是否标记处理 (报装工单特有)
@property (nonatomic, copy) NSString *handleMark;

/// 工单操作按钮
@property (nonatomic, strong) NSMutableArray<NSNumber *> *actions;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *comAddr;



@end
