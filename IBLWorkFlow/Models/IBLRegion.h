//
//  IBLRegion.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

/**
 *  组织类型
 */
typedef NS_ENUM(NSInteger, IBLRegionType) {
    /**
     *  总公司
     */
    IBLRegionTypeCompany,
    /**
     *  代理商
     */
    IBLRegionTypeAgent,
    /**
     *  营业厅
     */
    IBLRegionTypeBusinessHall,
    /**
     *  小区
     */
    IBLRegionTypeResidential,
};

@interface IBLRegion : IBLModel

/// 区域电话
@property (nonatomic, copy) NSString *phone;

/// 区域描述
@property (nonatomic, copy) NSString *desc;

/// 区域地址
@property (nonatomic, copy) NSString *address;

/// 区域名称
@property (nonatomic, copy) NSString *name;

/// 小区ID
@property (nonatomic, assign) NSInteger identifier;

/// 小区父组织ID
@property (nonatomic, assign) NSInteger parentIdentifier;

/// 组织类型
@property (nonatomic, assign) IBLRegionType type;

@end
