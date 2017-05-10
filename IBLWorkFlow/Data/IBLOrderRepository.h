//
//  IBLOrderRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLOrder.h"
#import "IBLWorkOrderType.h"
#import "IBLWorkOrderBussinessType.h"
#import "IBLOrderFlow.h"


typedef NS_ENUM(NSInteger, IBLFetchOrderType) {
    IBLFetchOrderTypeUnknow,
    IBLFetchOrderTypeMine,
    IBLFetchOrderTypeManaged,
};

@interface IBLAddWorkOrderInfo : NSObject

@property (nonatomic, assign) IBLWorkOrderStatus orderType;

@property (nonatomic, assign) IBLWorkOrderBizStatus bizType;

@property (nonatomic, assign) IBLPriorityStatus priority;

/// 期望完成时间 YYYY-MM-dd HH:mm:ss （可选）
@property (nonatomic, copy) NSString *preFinishTime;

/// 工单内容
@property (nonatomic, copy) NSString *orderContent;

/// 关联用户
@property (nonatomic, assign) NSInteger servId;

/// 分配处理的人员ID
@property (nonatomic, assign) NSInteger handleOperId;

/// 订购销售品ID
@property (nonatomic, assign) NSInteger offerId;

/// 小区ID（仅适用于报装工单类型）
@property (nonatomic, assign) NSInteger nodeId;

/// 用户姓名（仅适用于报装工单类型）
@property (nonatomic, copy) NSString *username;

/// 身份证号（仅适用于报装工单类型）
@property (nonatomic, assign) NSInteger userIdentifier;

/// 电话（仅适用于报装工单类型）
@property (nonatomic, copy) NSString *phone;

/// 联系地址（仅适用于报装工单类型）
@property (nonatomic, copy) NSString *address;

/// 备注（仅适用于报装工单类型）
@property (nonatomic, copy) NSString *remark;

/// 订购数，默认为1（仅适用于报装工单类型）
@property (nonatomic, assign) NSInteger buyLength;

@property(nonatomic) NSInteger custType;
@property(nonatomic, copy) NSString *comName;
@property(nonatomic) NSInteger certType;
@property(nonatomic, copy) NSString *comContact;
@property(nonatomic, copy) NSString *comContactPhone;
@property(nonatomic, copy) NSString *comAddress;
@property(nonatomic, copy) NSString *sampleComName;
@end

/**
 *  the info for fetch mine order list
 */
@interface IBLFetchOrderList : NSObject

@property (nonatomic, assign) IBLOrderStatus status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) IBLWorkOrderStatus type;

@property (nonatomic, assign) IBLWorkOrderBizStatus bizType;

@property (nonatomic, copy) NSString *dateRange;

@property (nonatomic, assign) IBLFetchOrderType fetchType;

@property(nonatomic) NSInteger custType;

@property(nonatomic, copy) NSString *comName;

@property(nonatomic, copy) NSString *comContact;

/**
 *  create IBLFetchOrderList
 *
 *  @param dateRange 工单更新时间段，格式为：YYYY/MM/DD HH:mm:ss- YYYY/MM/DD HH:mm:ss，起始或者结束可为空
 *  @param status    工单状态
 *  @param account   关联用户账号（支持模糊查询）
 *  @param username  关联用户姓名（支持模糊查询）
 *  @param phone     关联用户电话号码（支持模糊查询）
 *  @param type      工单类型
 *  @param bizType   工单业务类型
 *
 *  @return IBLFetchOrderList
 */
+ (instancetype)initWithFetchType:(IBLFetchOrderType)fetchType
                listWithDateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(IBLWorkOrderStatus)type
                          bizType:(IBLWorkOrderBizStatus)bizType;

@end

@interface IBLOrderRepository : IBLBusinessRepository

/**
 *  fetch mine order list from server
 *
 *  @param start    the start page number
 *  @param pageSize the count to be fetch
 *  @param fetch    the info used to fetch
 */
- (void)fetchMineOrderListWithFetch:(IBLFetchOrderList *)fetch
                              start:(NSInteger)start
                           pageSize:(NSInteger)pageSize
                    completeHandler:(void (^)(NSMutableArray<IBLOrder *> *, NSError *error))handler;

- (void)forwardOrderWithId:(NSInteger)orderId
                operatorId:(NSInteger)operatorId
                   content:(NSString *)content
           completeHandler:(void (^)(NSError *))handler;

- (void)deleteOrderWithOrderId:(NSInteger)identifier content:(NSString *)content completeHandler:(void (^)(NSError *))handler;

- (void)finishOrderWithId:(NSInteger)identifier content:(NSString *)content completeHandler:(void (^)(NSError *))handler;

- (void)trashOrderWithId:(NSInteger)identifier content:(NSString *)content completeHandler:(void (^)(NSError *))handler;

- (void)handleOrderWithId:(NSInteger)identifier servId:(NSString *)servId markHandle:(NSString *)markHandle content:(NSString *)content completeHandler:(void (^)(NSError *))handler;

- (void)addWorkOrdeWith:(IBLAddWorkOrderInfo *)info
        completeHandler:(void (^)(NSString *, NSError *))handler;

- (void)sendOrderWithId:(NSInteger)identifier
             operatorId:(NSInteger)operatorId
                content:(NSString *)content
        completeHandler:(void (^)(NSError *))handler;

- (void)fetchOrderFlowWithIdentifier:(NSInteger)orderIdentifier
                     completaHandler:(void (^)(NSMutableArray<IBLOrderFlow *> *, NSError *))handler;
@end
