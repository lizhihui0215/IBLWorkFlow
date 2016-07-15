//
//  IBLWorkOrderType.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
/**
 *  工单类型
 */
typedef NS_ENUM(NSInteger, IBLWorkOrderStatus) {
    /**
     *  未知
     */
    IBLWorkOrderStatusUnknow = -1,
    /**
     *  工程
     */
    IBLWorkOrderStatusProject = 1,
    /**
     *  故障
     */
    IBLWorkOrderStatusMalfunction = 2,
    /**
     *  投诉
     */
    IBLWorkOrderStatusComplainn = 3,
    /**
     *  咨询
     */
    IBLWorkOrderStatusAdvisory = 4,
    /**
     *  回访
     */
    IBLWorkOrderStatusReply = 5,
    /**
     *  抢修
     */
    IBLWorkOrderStatusRepair = 6,
};

@interface IBLWorkOrderType : IBLModel
@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) IBLWorkOrderStatus status;

@end
