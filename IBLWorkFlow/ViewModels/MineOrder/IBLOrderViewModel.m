//
//  IBLOrderViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderViewModel.h"
#import "IBLOrderSearchViewModel.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLOperator.h"
#import "IBLForwardOrder.h"
#import "IBLDeleteOrder.h"
#import "IBLFinishOrder.h"
#import "IBLTrashOrder.h"
#import "IBLHandleOrder.h"
#import "IBLSendOrder.h"

@interface IBLOrderViewModel ()
{
    NSMutableArray *_dataSource;
}

@property (nonatomic, strong) NSDictionary *dataSourceMaps;

@property (nonatomic, strong) IBLFetchOrder *fetchOrder;

@property (nonatomic, strong) IBLForwardOrder *forwardOrder;

@property (nonatomic, strong) IBLDeleteOrder *deleteOrder;

@property (nonatomic, strong) IBLHandleOrder *handleOrder;

@property (nonatomic, strong) IBLFinishOrder *finishOrder;

@property (nonatomic, strong) IBLTrashOrder *trashOrder;

@property (nonatomic, strong) IBLSendOrder *sendOrder;

@property (nonatomic, strong) NSMutableDictionary <NSNumber *, IBLOrderSearchResult *> *searchResults;

@end

@implementation IBLOrderViewModel



- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray *)dataSource{
    return _dataSource;
}

- (IBLOrderStatus)status{
    return [[self statusDictionary][@(self.index)] integerValue];
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    self.dataSource = self.dataSourceMaps[@(index)];
}

- (NSDictionary *)statusDictionary{
    NSDictionary *statusMap = nil;
    switch (self.type) {
        case IBLOrderTypeMine: {
            statusMap = @{@(0) : @(IBLOrderStatusSended),
                          @(1) : @(IBLOrderStatusHandling) ,
                          @(2) : @(IBLOrderStatusForwarding),
                          @(3) : @(IBLOrderStatusFinished),
                          @(4) : @(IBLOrderStatusInvalid)};
            break;
        }
        case IBLOrderTypeManage: {
            statusMap = @{@(0) : @(IBLOrderStatusUnsend),
                          @(1) : @(IBLOrderStatusSended) ,
                          @(2) : @(IBLOrderStatusHandling),
                          @(3) : @(IBLOrderStatusForwarding),
                          @(4) : @(IBLOrderStatusFinished),
                          @(5) : @(IBLOrderStatusInvalid)};
            break;
        }
    }
    
    return statusMap;
}

- (void)setupDataSourceMaps{
    IBLSection *section1 = [IBLSection sectionWithInfo:nil items:nil];
    IBLSection *section2 = [IBLSection sectionWithInfo:nil items:nil];
    IBLSection *section3 = [IBLSection sectionWithInfo:nil items:nil];
    IBLSection *section4 = [IBLSection sectionWithInfo:nil items:nil];
    IBLSection *section5 = [IBLSection sectionWithInfo:nil items:nil];
    IBLSection *section6 = [IBLSection sectionWithInfo:nil items:nil];

    self.dataSourceMaps = @{@(0) : [@[section1] mutableCopy],
                            @(1) : [@[section2] mutableCopy],
                            @(2) : [@[section3] mutableCopy],
                            @(3) : [@[section4] mutableCopy],
                            @(4) : [@[section5] mutableCopy],
                            @(5) : [@[section6] mutableCopy]};
}

- (instancetype)initWithOrderType:(IBLOrderType)type
{
    self = [super init];
    if (self) {
        self.type = type;
        
        [self setupDataSourceMaps];
        
        [self setIndex:0];
        
        self.fetchOrder = [[IBLFetchOrder alloc] init];
        
        self.forwardOrder = [[IBLForwardOrder alloc] init];
        
        self.deleteOrder = [[IBLDeleteOrder alloc] init];
        
        self.handleOrder = [[IBLHandleOrder alloc] init];

        self.searchResults = [@{@(0) : [IBLOrderSearchResult defaultSearchResult],
                                @(1) : [IBLOrderSearchResult defaultSearchResult] ,
                                @(2) : [IBLOrderSearchResult defaultSearchResult],
                                @(3) : [IBLOrderSearchResult defaultSearchResult],
                                @(4) : [IBLOrderSearchResult defaultSearchResult],
                                @(5) : [IBLOrderSearchResult defaultSearchResult],
                                @(6) : [IBLOrderSearchResult defaultSearchResult]} mutableCopy];

    }
    return self;
}

- (IBLFetchOrderList *)fetchMineOrderList{
    IBLOrderStatus status = [self status];
    
    IBLOrderSearchResult *fetchResut = [self searchResult];
    
    IBLFetchOrderType orderType = IBLFetchOrderTypeUnknow;
    
    switch (self.type) {
        case IBLOrderTypeMine: {
            orderType = IBLFetchOrderTypeMine;
            break;
        }
        case IBLOrderTypeManage: {
            orderType = IBLFetchOrderTypeManaged;
            break;
        }
    }
    
    return [IBLFetchOrderList initWithFetchType:orderType
                              listWithDateRange:fetchResut.dateRange
                                         status:status
                                        account:fetchResut.account
                                       username:fetchResut.username
                                          phone:fetchResut.phone
                                           type:fetchResut.type.status
                                        bizType:fetchResut.bizType.status];
}

- (void)fetchOrderListWithIndex:(NSInteger)index
                      isRefresh:(BOOL)isRefresh
                completeHandler:(IBLViewModelCompleteHandler)handler {
    IBLFetchOrderList *fetch = [self fetchMineOrderList];

    [self.fetchOrder fetchOrderListWithIsRefresh:isRefresh
                                           fetch:fetch
                                 completeHandler:^(NSMutableArray<IBLOrder *> *orderList, NSError *error) {
                                     [self setDataSourceWithIndex:index isRefresh:isRefresh orderList:orderList];
                                     handler(error);
                                 }];
}

- (void)setDataSourceWithIndex:(NSInteger)index
                     isRefresh:(BOOL)refresh
                     orderList:(NSMutableArray<IBLOrder *> *)orderList {
    
    IBLSection *section = [self sectionAt:0];
    
    NSMutableArray<IBLSectionItem *> *items = [self itemsWithOrders:orderList];

    if (refresh) section.items = items; else [section.items addObjectsFromArray:items];
}

- (NSMutableArray<IBLSectionItem *> *)itemsWithOrders:(NSMutableArray<IBLOrder *> *)orders {
    NSMutableArray<IBLSectionItem *> *items = [NSMutableArray array];

    for (IBLOrder *order in orders) {
        order.actions = [[self orderActionsWithStatus:order.status
                                              bizType:order.bizType] mutableCopy];
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:order selected:NO];
        [items addObject:item];
    }

    return items;
}

- (NSArray<NSNumber *> *)orderActionsWithStatus:(IBLOrderStatus)status
                                               bizType:(IBLWorkOrderBizStatus)bizType {
    switch (self.type) {
        case IBLOrderTypeMine: {
            return [self mineOrderActionsWithStatus:status bizType:bizType];
            break;
        }
        case IBLOrderTypeManage: {
            return [self managedOrderActionsWithStatus:status bizType:bizType];
            break;
        }
    }
}

- (NSArray<NSNumber *> *)managedOrderActionsWithStatus:(IBLOrderStatus)status bizType:(IBLWorkOrderBizStatus)bizType {
    IBLGenerateAppConfiguration *configuration = [[IBLGenerateAppConfiguration alloc] init];
    return [configuration managedOrderActionsWithStatus:status bizType:bizType];
}

- (NSArray<NSNumber *> *)mineOrderActionsWithStatus:(IBLOrderStatus)status bizType:(IBLWorkOrderBizStatus)bizType {
    IBLGenerateAppConfiguration *configuration = [[IBLGenerateAppConfiguration alloc] init];
    return  [configuration mineOrderActionsWithStatus:status bizType:bizType];
}

- (void)setSearchResult:(IBLOrderSearchResult *)searchResult{
    self.searchResults[@(self.index)] = searchResult;
}

- (IBLOrderSearchResult *)searchResult {
    return self.searchResults[@(self.index)];
}

- (IBLOrder *)orderAtIndexPath:(NSIndexPath *)indexPath{
    IBLSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];;
    return sectionItem.info;
}

- (NSString *)workOrderBizTypeNameWithStatus:(IBLWorkOrderBizStatus)status{
    NSDictionary *workOrderBizTypes = @{@(IBLWorkOrderBizStatusUnknow) : @"[ 未知 ]",
                                        @(IBLWorkOrderBizStatusRepair) : @"[ 报修 ]",
                                        @(IBLWorkOrderBizStatusInstall) : @"[ 报装 ]",
                                        @(IBLWorkOrderBizStatusStop) : @"[ 停机修复 ]",
                                        @(IBLWorkOrderBizStatusReturn) : @"[ 退网 ]",
                                        @(IBLWorkOrderBizStatusMove) : @"[ 移网 ]",
                                        @(IBLWorkOrderBizStatusHandleMalfunction) : @"[ 故障处理 ]",
                                        @(IBLWorkOrderBizStatusHandleComplaints) : @"[ 投诉处理 ]",
                                        @(IBLWorkOrderBizStatusHandleAdvisory) : @"[ 咨询处理 ]",
                                        @(IBLWorkOrderBizStatusHandleReply) : @"[ 回访处理 ]",
                                        @(IBLWorkOrderBizStatusElectrical) : @"[ 接电 ]",
                                        @(IBLWorkOrderBizStatusAddBox) : @"[ 加箱 ]",
                                        @(IBLWorkOrderBizStatusChangeBox) : @"[ 改箱 ]",
                                        @(IBLWorkOrderBizStatusAddLock) : @"[ 加锁 ]",
                                        @(IBLWorkOrderBizStatusFlyLine) : @"[ 飞线 ]",
                                        @(IBLWorkOrderBizStatusSplice) : @"[ 熔纤 ]",
                                        @(IBLWorkOrderBizStatusThroughCable) : @"[ 穿光缆 ]",
                                        @(IBLWorkOrderBizStatusLightBarrier) : @"[ 光不通 ]",
                                        @(IBLWorkOrderBizStatusLineBarrier) : @"[ 线不通穿线 ]",
                                        @(IBLWorkOrderBizStatusCableBreak) : @"[ 光缆断 ]",
                                        @(IBLWorkOrderBizStatusOther) : @"[ 其他 ]"};

    return workOrderBizTypes[@(status)];
}

- (NSString *)workOrderTypAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return [self workOrderBizTypeNameWithStatus:order.bizType];
}

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.username;
}

- (NSString *)dateAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.lastModifyTime;
}

- (IBLPriorityStatus)orderPriorityAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    return order.priority;
}

- (NSDictionary *)mineOrderTitleMaps{
    return @{@(IBLOrderActionHandling) : @"处理",
             @(IBLOrderActionViewSingle) : @"查看",
             @(IBLOrderActionFinish) : @"完成",
             @(IBLOrderActionView) : @"查看",
             @(IBLOrderActionCreate) : @"开户",
             @(IBLOrderActionSend) : @"派单",
             @(IBLOrderActionDelete) : @"删除",
             @(IBLOrderActionForward) : @"转发",
             @(IBLOrderActionTrash) : @"作废",
             @(IBLOrderActionFinish) : @"完成",
             @(IBLOrderActionCreate) : @"派单",};
}


- (NSArray<NSString *> *)orderActionsTitlesAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    
    NSMutableArray<NSString *> *titles = [NSMutableArray array];
    
    for (NSNumber *action in order.actions) {
        [titles addObject:[self mineOrderTitleMaps][action]];
    }
    
    return titles;
}

- (IBLOrderAction)actionInIndexPath:(NSIndexPath *)indexPath atIndex:(NSInteger)index {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    
    return [order.actions[index] integerValue];
}

- (NSArray<NSString *> *)segmentedControlTitles {
    NSArray<NSString *> *titles = nil;
    switch (self.type) {
        case IBLOrderTypeMine: {
            titles = @[@"未理中",@"处理中",@"转发中",@"已完成",@"作废"];
            break;
        }
        case IBLOrderTypeManage: {
            titles = @[@"未派单",@"已派单",@"处理中",@"转发中", @"已完成", @"作废"];
            break;
        }
    }
    return titles;
}

- (NSString *)actionTitleWith:(IBLOrderAction)action
                  atIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *title = @"";
    switch (action) {
        case IBLOrderActionDelete: {
            title = @"确定删除工单？";
            break;
        }
        case IBLOrderActionTrash: {
            title = @"确定作废工单？";
            break;
        }
        case IBLOrderActionFinish: {
            title = @"完成工单";
            break;
        }
        case IBLOrderActionForward:{
            //FIXME: 转发最后一步。
//            IBLOrder *order = [self orderAtIndexPath:indexPath];
//            title = [NSString stringWithFormat:@"转发给：开户%@号"];
            break;
        }
            
        default: break;
    }
    
    return title;
}

- (UIImage *)actionImageWith:(IBLOrderAction)action {
    UIImage *image = nil;
    switch (action) {
        case IBLOrderActionDelete: {
            image = [UIImage imageNamed:@"alert"];
            break;
        }
        case IBLOrderActionTrash: {
            image = [UIImage imageNamed:@"alert"];
            break;
        }
        case IBLOrderActionFinish: {
            image = [UIImage imageNamed:@"finished"];
            break;
        }
        case IBLOrderActionForward:{
            image = [UIImage imageNamed:@"alert"];
            break;
        }
        default: break;
    }

    return image;
}

- (NSString *)title {
    NSString *title = @"";
    switch (self.type) {
        case IBLOrderTypeMine: {
            title = @"我的工单";
            break;
        }
        case IBLOrderTypeManage: {
            title = @"工单管理";
            break;
        }
    }
    return title;
}



- (NSString *)placeHolderWith:(IBLOrderAction)action atIndexPath:(NSIndexPath *)indexPath {
    NSString *placeHolder = @"";
    switch (action) {
        case IBLOrderActionTrash: {
            placeHolder = @"作废说明";
            break;
        }
        case IBLOrderActionFinish: {
            placeHolder = @"完成说明填写";
            break;
        }
        case IBLOrderActionDelete: {
            placeHolder = @"删除说明填写";
            break;
        }
        default: break;
    }
    
    return placeHolder;
}

- (void)deleteOrderAtIndexPath:(NSIndexPath *)indexPath{
    IBLSection *section = [self sectionAt:indexPath.section];
    [section.items removeObjectAtIndex:indexPath.row];
}

- (void)handlerWithAction:(IBLOrderAction)action
                indexPath:(NSIndexPath *)indexPath
          completeHandler:(void (^)(NSError *))handler {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    //!!!: can be refine
    switch (action) {
        case IBLOrderActionTrash: {
            [self.trashOrder trashOrderWith:order completeHandler:^(NSError *error) {
                [self deleteOrderAtIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionFinish: {
            [self.finishOrder finishOrderWith:order completeHandler:^(NSError *error) {
                [self deleteOrderAtIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionDelete: {
            [self.deleteOrder deleteOrderWithOrder:order completeHandler:^(NSError *error) {
                [self deleteOrderAtIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionHandling:{
            [self.handleOrder handleOrderWithOrder:order completeHandler:^(NSError *error){
                
            }];
            break;
        }
        default: break;
    }
}

- (void)forwardWithOrder:(IBLOrder *)order
                operator:(IBLOperator *)operator
                 content:(NSString *)content
         completehandler:(void (^) (NSError *error))handler{
    [self.forwardOrder forwardOrderWith:order
                               operator:operator
                                content:content
                        completeHandler:handler];
}

- (void)sendWithOrder:(IBLOrder *)order
             operator:(IBLOperator *)operator
              content:(NSString *)content
      completehandler:(void (^)(NSError *))handler {
    [self.sendOrder sendOrderWith:order
                         operator:operator
                          content:content
                  completeHandler:handler];
}
@end