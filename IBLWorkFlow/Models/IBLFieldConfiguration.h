//
//  IBLFieldConfiguration.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLFieldConfiguration : IBLModel

/// 开户
@property (nonatomic, strong) NSArray *createAccountFields;

/// 更换销售品
@property (nonatomic, strong) NSArray *changeProductFields;

/// 续费
@property (nonatomic, strong) NSArray *renewFields;

@end
