//
//  IBLOperator.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/19/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLOperator : IBLModel

/// 操作员ID
@property (nonatomic, assign) NSInteger identifier;

/// 操作员姓名
@property (nonatomic, copy) NSString *name;

/// 操作员登录账号
@property (nonatomic, copy) NSString *account;

/// 角色
@property (nonatomic, copy) NSString *role;

/// 电话
@property (nonatomic, copy) NSString *phone;

@end
