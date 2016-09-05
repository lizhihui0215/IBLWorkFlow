//
//  IBLOrderRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderRepository.h"

static NSString const * kOrderStatus = @"orderStatus";

static NSString const * kAccount = @"userAccount";

static NSString const * kUsername = @"userName";

static NSString *const kPhone = @"userPhone";

static NSString *const kType = @"orderType";

static NSString *const kBizType = @"bizType";

static NSString *const kDateRange = @"dateRange";

static NSString *const kOrderList = @"orderList";

static NSString *const kOrderFlowList = @"orderFlowList";

static NSString *const IBLMethodOfFetchMineOrderList = @"getMyOrderList";

static NSString *const IBLMethodOfOrderMineOrderListResponse = @"getMyOrderListResponse";

static NSString *const IBLMethodOfFetchManagedOrderList = @"getOrderList";

static NSString *const IBLMethodOfFetchManagedOrderListResponse = @"getOrderListResponse";

static NSString *const IBLMethodOfForwardOrder = @"orderTrans";

static NSString *const IBLMethodOfForwardOrderResponse = @"orderTransResponse";

static NSString *const kOrderIdentifier = @"orderId";

static NSString *const kOperatorIdentifier = @"handleOperId";

static NSString *const kContent = @"content";

static NSString *const IBLMethodOfDeleteOrder = @"orderDelete";

static NSString *const IBLMethodOfDeleteOrderReponse = @"orderDeleteResponse";

static NSString *const IBLMethodOfFinishOrder = @"orderComp";

static NSString *const IBLMethodOfFinishOrderResponse = @"orderCompResponse";

static NSString *const IBLMethodOfTrashOrder = @"orderCancel";

static NSString *const IBLMethodOfTrashOrderResponse = @"orderCancelResponse";

@interface IBLOrderRepository()

@property (nonatomic, strong) IBLSOAPMethod *fetchMineOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *fetchManagedOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *forwardOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *deleteOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *finishMethod;

@property (nonatomic, strong) IBLSOAPMethod *trashMethod;

@property (nonatomic, strong) IBLSOAPMethod *handleMethod;

@property (nonatomic, strong) IBLSOAPMethod *sendOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *addWorkOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *fetchOrderFlowMethod;
@end

@implementation IBLOrderRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:IBLWorkOrderSOAPFileName];
    if (self) {
        self.fetchMineOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfFetchMineOrderList
                                                            responseMethodName:IBLMethodOfOrderMineOrderListResponse];
        
        self.fetchManagedOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfFetchManagedOrderList
                                                               responseMethodName:IBLMethodOfFetchManagedOrderListResponse];
        
        
        self.forwardOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfForwardOrder
                                                          responseMethodName:IBLMethodOfForwardOrderResponse];
        
        self.deleteOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfDeleteOrder
                                                         responseMethodName:IBLMethodOfDeleteOrderReponse];
        
        self.finishMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfFinishOrder
                                                    responseMethodName:IBLMethodOfFinishOrderResponse];
        
        self.trashMethod = [IBLSOAPMethod methodWithRequestMethodName:IBLMethodOfTrashOrder
                                                   responseMethodName:IBLMethodOfTrashOrderResponse];
        
        self.handleMethod = [IBLSOAPMethod methodWithRequestMethodName:@"orderHandle"
                                                    responseMethodName:@"orderHandleResponse"];
        
        self.sendOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:@"orderIssue"
                                                       responseMethodName:@"orderIssueResponse"];
        
        self.addWorkOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:@"orderAdd"
                                                          responseMethodName:@"orderAddResponse"];
        self.fetchOrderFlowMethod = [IBLSOAPMethod methodWithRequestMethodName:@"viewOrderFlow"
                                                            responseMethodName:@"viewOrderFlowResponse"];
        
    }
    return self;
}

- (IBLSOAPMethod *)methodWithFetchType:(IBLFetchOrderType)fetchType{
    IBLSOAPMethod *method = nil;
    switch (fetchType) {
        case IBLFetchOrderTypeUnknow: {
            
            break;
        }
        case IBLFetchOrderTypeMine: {
            method = self.fetchMineOrderMethod;
            break;
        }
        case IBLFetchOrderTypeManaged: {
            method = self.fetchManagedOrderMethod;
            break;
        }
    }
    return method;
}

- (void)fetchOrderFlowWithIdentifier:(NSInteger)orderIdentifier
                     completaHandler:(void (^)(NSMutableArray<IBLOrderFlow *> *, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(orderIdentifier);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchOrderFlowMethod] POST:IBLWorkOrderInterface
                                                       parameters:parameters
                                                         progress:nil
                                                          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                              NSArray <NSDictionary *> * ordersDictionary = responseObject[kOrderFlowList];
                                                              
                                                              NSMutableArray<IBLOrderFlow *> *orderFlows = [NSMutableArray array];
                                                              for (NSDictionary *orderDictionary in ordersDictionary) {
                                                                  IBLOrderFlow *order = [[IBLOrderFlow alloc] initWithDictionary:orderDictionary error:nil];
                                                                  [orderFlows addObject:order];
                                                              }
                                                              handler(orderFlows, nil);
                                                          } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                              handler(nil, error);
                                                          }];
}

- (void)fetchMineOrderListWithFetch:(IBLFetchOrderList *)fetch
                              start:(NSInteger)start
                           pageSize:(NSInteger)pageSize
                    completeHandler:(void (^)(NSMutableArray<IBLOrder *> *, NSError *error))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        if (fetch.bizType !=  IBLWorkOrderBizStatusUnknow) parameters[kBizType] = @(fetch.bizType);
        if(fetch.type != IBLWorkOrderStatusUnknow) parameters[kType] = @(fetch.type);
        parameters[kOrderStatus] = @(fetch.status);
        parameters[kAccount] = fetch.account;
        parameters[kUsername] = fetch.username;
        parameters[kPhone] = fetch.phone;
        parameters[kDateRange] = fetch.dateRange;
        parameters[kStart] = @(start * pageSize);
        parameters[kPageSize] = @(pageSize);
        return parameters;
    }];
    
    IBLSOAPMethod *method = [self methodWithFetchType:fetch.fetchType];
    
    [[self networkServicesMethods:method] POST:IBLWorkOrderInterface
                                    parameters:parameters
                                      progress:nil
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           NSArray <NSDictionary *> * ordersDictionary = responseObject[kOrderList];
                                           
                                           NSMutableArray<IBLOrder *> *orders = [NSMutableArray array];
                                           for (NSDictionary *orderDictionary in ordersDictionary) {
                                               IBLOrder *order = [[IBLOrder alloc] initWithDictionary:orderDictionary error:nil];
                                               [orders addObject:order];
                                           }
                                           handler(orders, nil);
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           handler(nil, error);
                                       }];
}

- (void)forwardOrderWithId:(NSInteger)orderId
                operatorId:(NSInteger)operatorId
                   content:(NSString *)content
           completeHandler:(void (^)(NSError *))handler {
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(orderId);
        parameters[kOperatorIdentifier] = @(operatorId);
        parameters[kContent] = content;
        return parameters;
    }];
    
    [[self networkServicesMethods:self.forwardOrderMethod] POST:IBLWorkOrderInterface
                                                     parameters:parameters
                                                       progress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                            handler(nil);
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            handler(error);
                                                        }];
}

- (void)sendOrderWithId:(NSInteger)identifier
             operatorId:(NSInteger)operatorId
                content:(NSString *)content
        completeHandler:(void (^)(NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(identifier);
        parameters[kOperatorIdentifier] = @(operatorId);
        parameters[kContent] = content;
        return parameters;
    }];
    
    [[self networkServicesMethods:self.sendOrderMethod] POST:IBLWorkOrderInterface
                                                     parameters:parameters
                                                       progress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                            handler(nil);
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            handler(error);
                                                        }];
}

- (void)deleteOrderWithOrderId:(NSInteger)identifier
               completeHandler:(void (^)(NSError *))handler {
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(identifier);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.deleteOrderMethod] POST:IBLWorkOrderInterface
                                                    parameters:parameters
                                                      progress:nil
                                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                           handler(nil);
                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                           handler(error);
                                                       }];
    
}

- (void)finishOrderWithId:(NSInteger)identifier
          completeHandler:(void (^)(NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(identifier);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.finishMethod] POST:IBLWorkOrderInterface
                                               parameters:parameters
                                                 progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      handler(nil);
                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                      handler(error);
                                                  }];
}

- (void)trashOrderWithId:(NSInteger)identifier
         completeHandler:(void (^)(NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(identifier);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.trashMethod] POST:IBLWorkOrderInterface
                                              parameters:parameters
                                                progress:nil
                                                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                     handler(nil);
                                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                     handler(error);
                                                 }];
    
}

- (void)handleOrderWithId:(NSInteger)identifier
          completeHandler:(void (^)(NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOrderIdentifier] = @(identifier);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.handleMethod] POST:IBLWorkOrderInterface
                                               parameters:parameters
                                                 progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      handler(nil);
                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                      handler(error);
                                                  }];
}


- (void)addWorkOrdeWith:(IBLAddWorkOrderInfo *)info
        completeHandler:(void (^)(NSString *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        if (info.orderType != IBLWorkOrderStatusUnknow) parameters[@"orderType"] = @(info.orderType);
        if (info.bizType != IBLWorkOrderBizStatusUnknow) parameters[@"bizType"] = @(info.bizType);
        if(info.servId != 0 ) parameters[@"servId"] = @(info.servId);
        if(info.offerId != 0) parameters[@"offerId"] = @(info.offerId);
        if(info.nodeId != 0) parameters[@"nodeId"] = @(info.nodeId);
        if (info.userIdentifier != 0) parameters[@"idNo"] = @(info.userIdentifier);
        if (info.handleOperId != 0) parameters[@"handleOperId"] = @(info.handleOperId);
        if (info.buyLength != 0) parameters[@"buyLength"] = @(info.buyLength);
        parameters[@"priority"] = @(info.priority);
        parameters[@"preFinishTime"] = info.preFinishTime;
        parameters[@"orderContent"] = info.orderContent;
        parameters[@"userName"] = info.username;
        parameters[@"phone"] = info.phone;
        parameters[@"addr"] = info.address;
        parameters[@"remark"] = info.remark;
        return parameters;
    }];
    
    [[self networkServicesMethods:self.addWorkOrderMethod] POST:IBLWorkOrderInterface
                                                     parameters:parameters
                                                       progress:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                            handler(responseObject[@"orderId"],nil);
                                                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                            handler(nil,error);
                                                        }];
}
@end

@implementation IBLAddWorkOrderInfo


@end

@interface IBLFetchOrderList ()

@end

@implementation IBLFetchOrderList

- (instancetype)initWithFetchType:(IBLFetchOrderType)fetchType
                        dateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(IBLWorkOrderStatus)type
                          bizType:(IBLWorkOrderBizStatus)bizType {
    self = [super init];
    if (self) {
        self.dateRange = dateRange;
        self.status = status;
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.type = type;
        self.bizType = bizType;
        self.fetchType = fetchType;
    }
    
    return self;
}

+ (instancetype)initWithFetchType:(IBLFetchOrderType)fetchType
                listWithDateRange:(NSString *)dateRange
                           status:(IBLOrderStatus)status
                          account:(NSString *)account
                         username:(NSString *)username
                            phone:(NSString *)phone
                             type:(IBLWorkOrderStatus)type
                          bizType:(IBLWorkOrderBizStatus)bizType {
    return [[self alloc] initWithFetchType:fetchType
                                 dateRange:dateRange
                                    status:status
                                   account:account
                                  username:username
                                     phone:phone
                                      type:type
                                   bizType:bizType];
}

@end
