//
//  IBLProductPrice.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/22/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

/**
 *  资费类型
 */
typedef NS_ENUM(NSInteger,IBLTariffType) {
    /**
     *  按天计费
     */
    IBLTariffTypeDay = 3,
    /**
     *  按月计费
     */
    IBLTariffTypeMonth = 6,
    /**
     *  按时长计费
     */
    IBLTariffTypeHour = 7,
    /**
     *  按流量计费
     */
    IBLTariffTypeTraffic = 8,
};

@interface IBLProductPrice : IBLModel

/// 销售品总周期数
@property (nonatomic, assign) NSInteger totalLength;

/// 销售品总金额
@property (nonatomic, assign) CGFloat totalAmount;

/// 单位资费(精确到分钟), 单位情参考(tariffType)字段
@property (nonatomic, assign) NSInteger unitPrice;

/// 资费类型(3-按天计费,6-按月计费,7-按时长计费,8-按流量计费)
@property (nonatomic, assign) IBLTariffType tariffType;

/// 单位
@property (nonatomic, copy) NSString *unit;

@end
