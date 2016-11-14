//
//  IBLWorkOrderBussinessType.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
/**
 *  工单业务类型
 */
typedef NS_ENUM(NSInteger, IBLWorkOrderBizStatus) {
    /**
     *  未知
     */
    IBLWorkOrderBizStatusUnknow = -1,
    /**
     *  报修
     */
    IBLWorkOrderBizStatusRepair = 11,
    /**
     *  报装
     */
    IBLWorkOrderBizStatusInstall = 12,
    /**
     *  停复机
     */
    IBLWorkOrderBizStatusStop = 13,
    /**
     *  退网
     */
    IBLWorkOrderBizStatusReturn = 14,
    /**
     *  移网
     */
    IBLWorkOrderBizStatusMove = 15,
    /**
     *  故障处理
     */
    IBLWorkOrderBizStatusHandleMalfunction = 21,
    /**
     *  投诉处理
     */
    IBLWorkOrderBizStatusHandleComplaints = 31,
    /**
     *  咨询处理
     */
    IBLWorkOrderBizStatusHandleAdvisory = 41,
    /**
     *  回访处理
     */
    IBLWorkOrderBizStatusHandleReply = 51,
    /**
     *  接电
     */
    IBLWorkOrderBizStatusElectrical = 61,
    /**
     *  加箱
     */
    IBLWorkOrderBizStatusAddBox = 62,
    
    /**
     *  改箱
     */
    IBLWorkOrderBizStatusChangeBox = 63,
    /**
     *  加锁
     */
    IBLWorkOrderBizStatusAddLock = 64,
    /**
     *  飞线
     */
    IBLWorkOrderBizStatusFlyLine = 65,
    /**
     *  熔纤
     */
    IBLWorkOrderBizStatusSplice = 66,
    /**
     *  穿光缆
     */
    IBLWorkOrderBizStatusThroughCable = 67,
    /**
     *  光不通
     */
    IBLWorkOrderBizStatusLightBarrier = 68,
    /**
     *  线不通穿线
     */
    IBLWorkOrderBizStatusLineBarrier = 69,
    /**
     *  光缆断
     */
    IBLWorkOrderBizStatusCableBreak = 610,
    /**
     *  其他
     */
    IBLWorkOrderBizStatusOther= 611,
};

@interface IBLWorkOrderBussinessType : IBLModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) IBLWorkOrderBizStatus status;

@end
