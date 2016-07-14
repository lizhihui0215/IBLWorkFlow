//
//  IBLOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLOrder : IBLModel

/// 工单ID
@property (nonatomic, assign) NSInteger identifier;

/// 工单标题
@property (nonatomic, copy) NSString *title;

/// 工单类型
@property (nonatomic, assign) NSInteger type;

/// 工单业务类型
@property (nonatomic, assign) NSInteger bizType;

/// 工单内容
@property (nonatomic, assign) NSString *content;

/// 工单状态
@property (nonatomic, assign) NSString *status;

/// 工单优先级
@property (nonatomic, assign) NSInteger priority;

/// 处理说明
@property (nonatomic, assign) NSString *note;

/// 处理建议
@property (nonatomic, assign) NSString *suggest;

/// 创建时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, assign) NSString *createTime;

/// 时效时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, assign) NSString *expireTime;

/// 最近更新时间 格式为 yyyy-MM-dd HH:mm:ss
@property (nonatomic, assign) NSString *lastModifyTime;

/// 关联用户ID
@property (nonatomic, assign) NSInteger userIdentifier;

/// 关联用户登录帐号
@property (nonatomic, assign) NSString *userAccount;

/// 创建人员姓名
@property (nonatomic, assign) NSString *creatorName;

/// 创建者联系电话
@property (nonatomic, assign) NSString *creatorPhone;

/// 所属校区ID （报装工单特有）
@property (nonatomic, assign) NSString *residentialIdentifier;

/// 订购的销售品ID （报装工单特有）
@property (nonatomic, assign) NSString *productIdentifier;

/// 用户姓名 （报装工单特有）
@property (nonatomic, assign) NSString *username;

@end
