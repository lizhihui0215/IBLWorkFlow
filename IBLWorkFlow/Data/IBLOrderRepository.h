//
//  IBLOrderRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"

/**
 *  the info for fetch mine order list
 */
@interface IBLFetchMineOrderList : NSObject

@property (nonatomic, copy) NSString *status;

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
                           status:(NSString *)status
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
 *  @param isRefresh YES fetch from the beginning, or NO fetch the next page
 *  @param fetch     the info used to fetch
 */
- (void)fetchMineOrderListWithIsRefresh:(BOOL)isRefresh
                                  fetch:(IBLFetchMineOrderList *)fetch;
@end
