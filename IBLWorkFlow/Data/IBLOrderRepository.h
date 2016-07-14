//
//  IBLOrderRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLOrder.h"

static NSString *const IBLMethodOfFetchMineOrderList = @"getMyOrderList";

static NSString *const IBLMethodOfOrderMineOrderListResponse = @"getMyOrderListResponse";

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
 *  the info for fetch mine order list
 */
@interface IBLFetchMineOrderList : NSObject

@property (nonatomic, assign) IBLOrderStatus status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *bizType;

@property (nonatomic, copy) NSString *dateRange;

/**
 *  create IBLFetchMineOrderList
 *
 *  @param dateRange 工单更新时间段，格式为：YYYY/MM/DD HH:mm:ss- YYYY/MM/DD HH:mm:ss，起始或者结束可为空
 *  @param status    工单状态
 *  @param account   关联用户账号（支持模糊查询）
 *  @param username  关联用户姓名（支持模糊查询）
 *  @param phone     关联用户电话号码（支持模糊查询）
 *  @param type      工单类型
 *  @param bizType   工单业务类型
 *
 *  @return IBLFetchMineOrderList
 */
+ (instancetype)listWithDateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(NSString *)type
                          bizType:(NSString *)bizType;

@end

@interface IBLOrderRepository : IBLBusinessRepository

/**
 *  fetch mine order list from server
 *
 *  @param start    the start page number
 *  @param pageSize the count to be fetch
 *  @param fetch    the info used to fetch
 */
- (void)fetchMineOrderListWithFetch:(IBLFetchMineOrderList *)fetch
                              start:(NSInteger)start
                           pageSize:(NSInteger)pageSize
                    completeHandler:(void (^)(NSArray *orderList, NSError *error))handler;
@end
