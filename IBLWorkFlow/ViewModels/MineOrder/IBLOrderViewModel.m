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



- (NSDictionary<NSNumber *, NSNumber *> *)statusDictionary{
    NSDictionary *statusMap = nil;
    switch (self.type) {
        case IBLOrderTypeMine: {
            statusMap = @{@(0) : @(IBLOrderStatusSended),
                          @(1) : @(IBLOrderStatusHandling) ,
                          @(2) : @(IBLOrderStatusFinished),
                          @(3) : @(IBLOrderStatusInvalid),
//                          @(4) : @(IBLOrderStatusInvalid)
                          };
            break;
        }
        case IBLOrderTypeManage: {
            statusMap = @{@(0) : @(IBLOrderStatusUnsend),
                          @(1) : @(IBLOrderStatusSended) ,
                          @(2) : @(IBLOrderStatusHandling),
                          @(3) : @(IBLOrderStatusFinished),
                          @(4) : @(IBLOrderStatusInvalid),
//                          @(5) : @(IBLOrderStatusInvalid)
                          };
            break;
        }
    }
    
    return statusMap;
}

- (void)setupDataSourceMaps{
    PCCWSection *section1 = [PCCWSection sectionWithInfo:nil items:nil];
    PCCWSection *section2 = [PCCWSection sectionWithInfo:nil items:nil];
    PCCWSection *section3 = [PCCWSection sectionWithInfo:nil items:nil];
    PCCWSection *section4 = [PCCWSection sectionWithInfo:nil items:nil];
    PCCWSection *section5 = [PCCWSection sectionWithInfo:nil items:nil];
    PCCWSection *section6 = [PCCWSection sectionWithInfo:nil items:nil];
    
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
        
        self.sendOrder = [[IBLSendOrder alloc] init];
        
        self.finishOrder = [[IBLFinishOrder alloc] init];
        
        self.trashOrder = [[IBLTrashOrder alloc] init];
        
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
    
    IBLFetchOrderList *fetchList = [IBLFetchOrderList initWithFetchType:orderType
                                                     listWithDateRange:fetchResut.dateRange
                                                                status:status
                                                               account:fetchResut.account
                                                              username:fetchResut.username
                                                                 phone:fetchResut.phone
                                                                  type:fetchResut.type.status
                                                               bizType:fetchResut.bizType.status];
    fetchList.custType = fetchResut.custType;
    fetchList.comName = fetchResut.comName;
    fetchList.comContact = fetchResut.comContact;
    
    return fetchList;
}

- (void)fetchOrderListWithIndex:(NSInteger)index
                      isRefresh:(BOOL)isRefresh
                completeHandler:(PCCWViewModelCompleteHandler)handler {
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
    
    PCCWSection *section = [self sectionAt:0];
    
    NSMutableArray<PCCWSectionItem *> *items = [self itemsWithOrders:orderList];
    
    if (refresh) section.items = items; else [section.items addObjectsFromArray:items];
}

- (NSMutableArray<PCCWSectionItem *> *)itemsWithOrders:(NSMutableArray<IBLOrder *> *)orders {
    NSMutableArray<PCCWSectionItem *> *items = [NSMutableArray array];
    
    for (IBLOrder *order in orders) {
        order.actions = [[self orderActionsWithStatus:order.status
                                              bizType:order.bizType] mutableCopy];
        
        if ([order.handleMark isEqualToString:@"1"]) [order.actions removeObject:@(IBLOrderActionCreate)];
        
        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:order selected:NO];
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
    PCCWSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];;
    return sectionItem.info;
}

- (NSString *)workOrderBizTypeNameWithStatus:(IBLWorkOrderBizStatus)status{
    NSString  *orderBizUnknow= NSLocalizedStringFromTable(@"IBLOrder.bizType.unknow", @"Main", "not found");

    NSString  *orderBizRepair = NSLocalizedStringFromTable(@"IBLOrder.bizType.repair", @"Main", "not found");
    NSString  *orderBizInstall = NSLocalizedStringFromTable(@"IBLOrder.bizType.install", @"Main", "not found");

    
    NSString  *orderBizStop = NSLocalizedStringFromTable(@"IBLOrder.bizType.stop", @"Main", "not found");

    NSString  *orderBizReturn = NSLocalizedStringFromTable(@"IBLOrder.bizType.return", @"Main", "not found");
    NSString  *orderBizMove = NSLocalizedStringFromTable(@"IBLOrder.bizType.move", @"Main", "not found");

    NSString  *orderBizHandleMalfunction = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleMalfunction", @"Main", "not found");

    NSString  *orderBizHandleComplaints = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleComplaints", @"Main", "not found");
    NSString  *orderBizHandleAdvisory = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleAdvisory", @"Main", "not found");
    NSString  *orderBizHandleReply = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleReply", @"Main", "not found");
    NSString  *orderBizElectrical = NSLocalizedStringFromTable(@"IBLOrder.bizType.electrical", @"Main", "not found");
    NSString  *orderBizAddBox = NSLocalizedStringFromTable(@"IBLOrder.bizType.addBox", @"Main", "not found");
    NSString  *orderBizChangeBox = NSLocalizedStringFromTable(@"IBLOrder.bizType.changeBox", @"Main", "not found");

    NSString  *orderBizAddLock = NSLocalizedStringFromTable(@"IBLOrder.bizType.addLock", @"Main", "not found");
    NSString  *orderBizFlyLine = NSLocalizedStringFromTable(@"IBLOrder.bizType.flyLine", @"Main", "not found");
    NSString  *orderBizSplice = NSLocalizedStringFromTable(@"IBLOrder.bizType.splice", @"Main", "not found");

    NSString  *orderBizThroughCable = NSLocalizedStringFromTable(@"IBLOrder.bizType.throughCable", @"Main", "not found");
    NSString  *orderBizLightBarrier = NSLocalizedStringFromTable(@"IBLOrder.bizType.lightBarrier", @"Main", "not found");
    NSString  *orderBizLineBarrier = NSLocalizedStringFromTable(@"IBLOrder.bizType.lineBarrier", @"Main", "not found");
    NSString  *orderBizCableBreak = NSLocalizedStringFromTable(@"IBLOrder.bizType.cableBreak", @"Main", "not found");
    NSString  *orderBizOther = NSLocalizedStringFromTable(@"IBLOrder.bizType.other", @"Main", "not found");
    
    NSDictionary *workOrderBizTypes = @{@(IBLWorkOrderBizStatusUnknow) : [NSString stringWithFormat:@"[ %@ ]",orderBizUnknow],
                                        @(IBLWorkOrderBizStatusRepair) : [NSString stringWithFormat:@"[ %@ ]",orderBizRepair],
                                        @(IBLWorkOrderBizStatusInstall) : [NSString stringWithFormat:@"[ %@ ]",orderBizInstall],
                                        @(IBLWorkOrderBizStatusStop) : [NSString stringWithFormat:@"[ %@ ]",orderBizStop],
                                        @(IBLWorkOrderBizStatusReturn) : [NSString stringWithFormat:@"[ %@ ]",orderBizReturn],
                                        @(IBLWorkOrderBizStatusMove) : [NSString stringWithFormat:@"[ %@ ]",orderBizMove],
                                        @(IBLWorkOrderBizStatusHandleMalfunction) : [NSString stringWithFormat:@"[ %@ ]",orderBizHandleMalfunction],
                                        @(IBLWorkOrderBizStatusHandleComplaints) : [NSString stringWithFormat:@"[ %@ ]",orderBizHandleComplaints],
                                        @(IBLWorkOrderBizStatusHandleAdvisory) : [NSString stringWithFormat:@"[ %@ ]",orderBizHandleAdvisory],
                                        @(IBLWorkOrderBizStatusHandleReply) : [NSString stringWithFormat:@"[ %@ ]",orderBizHandleReply],
                                        @(IBLWorkOrderBizStatusElectrical) : [NSString stringWithFormat:@"[ %@ ]",orderBizElectrical],
                                        @(IBLWorkOrderBizStatusAddBox) : [NSString stringWithFormat:@"[ %@ ]",orderBizAddBox],
                                        @(IBLWorkOrderBizStatusChangeBox) : [NSString stringWithFormat:@"[ %@ ]",orderBizChangeBox],
                                        @(IBLWorkOrderBizStatusAddLock) : [NSString stringWithFormat:@"[ %@ ]",orderBizAddLock],
                                        @(IBLWorkOrderBizStatusFlyLine) : [NSString stringWithFormat:@"[ %@ ]",orderBizFlyLine],
                                        @(IBLWorkOrderBizStatusSplice) : [NSString stringWithFormat:@"[ %@ ]",orderBizSplice],
                                        @(IBLWorkOrderBizStatusThroughCable) : [NSString stringWithFormat:@"[ %@ ]",orderBizThroughCable],
                                        @(IBLWorkOrderBizStatusLightBarrier) : [NSString stringWithFormat:@"[ %@ ]",orderBizLightBarrier],
                                        @(IBLWorkOrderBizStatusLineBarrier) : [NSString stringWithFormat:@"[ %@ ]",orderBizLineBarrier],
                                        @(IBLWorkOrderBizStatusCableBreak) : [NSString stringWithFormat:@"[ %@ ]",orderBizCableBreak],
                                        @(IBLWorkOrderBizStatusOther) : [NSString stringWithFormat:@"[ %@ ]",orderBizOther]};
    
    return workOrderBizTypes[@(status)];
}

- (NSString *)workOrderTypAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    
    return [self workOrderBizTypeNameWithStatus:order.bizType];
}

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    
    return order.userAccount;
}

- (NSString *)orderContentAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    
    return order.content;
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
    NSString  *orderOperatorHandling = NSLocalizedStringFromTable(@"IBLOrderOperator.handling", @"Main", "not found");
    NSString  *orderOperatorViewSingle = NSLocalizedStringFromTable(@"IBLOrderOperator.viewSingle", @"Main", "not found");
    NSString  *orderOperatorFinish = NSLocalizedStringFromTable(@"IBLOrderOperator.finish", @"Main", "not found");
    NSString  *orderOperatorView = NSLocalizedStringFromTable(@"IBLOrderOperator.view", @"Main", "not found");
    NSString  *orderOperatorCreate = NSLocalizedStringFromTable(@"IBLOrderOperator.create", @"Main", "not found");
    NSString  *orderOperatorSend = NSLocalizedStringFromTable(@"IBLOrderOperator.send", @"Main", "not found");
    NSString  *orderOperatorDelete = NSLocalizedStringFromTable(@"IBLOrderOperator.delete", @"Main", "not found");
    NSString  *orderOperatorForward = NSLocalizedStringFromTable(@"IBLOrderOperator.forward", @"Main", "not found");

    NSString  *orderOperatorTrash = NSLocalizedStringFromTable(@"IBLOrderOperator.trash", @"Main", "not found");
    
    return @{@(IBLOrderActionHandling) : orderOperatorHandling,
             @(IBLOrderActionViewSingle) : orderOperatorViewSingle,
             @(IBLOrderActionFinish) : orderOperatorFinish,
             @(IBLOrderActionView) : orderOperatorView,
             @(IBLOrderActionCreate) : orderOperatorCreate,
             @(IBLOrderActionSend) : orderOperatorSend,
             @(IBLOrderActionDelete) : orderOperatorDelete,
             @(IBLOrderActionForward) : orderOperatorForward,
             @(IBLOrderActionTrash) : orderOperatorTrash,
             @(IBLOrderActionFinish) : orderOperatorFinish,
             @(IBLOrderActionCreate) : orderOperatorSend,};
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
    NSString *orderStatusUnsend = NSLocalizedStringFromTable(@"IBLOrderStatus.unsend", @"Main", "not found");
    NSString *orderStatusSended = NSLocalizedStringFromTable(@"IBLOrderStatus.sended", @"Main", "not found");
    NSString *orderStatusHandling = NSLocalizedStringFromTable(@"IBLOrderStatus.handling", @"Main", "not found");
    NSString *orderStatusInvalid = NSLocalizedStringFromTable(@"IBLOrderStatus.invalid", @"Main", "not found");
    NSString *orderStatusFinished = NSLocalizedStringFromTable(@"IBLOrderStatus.finished", @"Main", "not found");

    switch (self.type) {
        case IBLOrderTypeMine: {
            titles = @[orderStatusUnsend,orderStatusHandling,orderStatusFinished,orderStatusInvalid];
            break;
        }
        case IBLOrderTypeManage: {
            
            titles = @[orderStatusUnsend,orderStatusSended,orderStatusHandling, orderStatusFinished, orderStatusInvalid];
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
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.title.delete", @"Main", "not found");
            break;
        }
        case IBLOrderActionTrash: {
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.title.trash", @"Main", "not found");
            break;
        }
        case IBLOrderActionFinish: {
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.title.finish", @"Main", "not found");
            break;
        }
        case IBLOrderActionForward:{
            //FIXME: 转发最后一步。
            //            IBLOrder *order = [self orderAtIndexPath:indexPath];
            //            title = [NSString stringWithFormat:@"转发给：开户%@号"];
            break;
        }
        case IBLOrderActionHandling:{
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.title.handle", @"Main", "not found");
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
        case IBLOrderActionHandling:{
            image = [UIImage imageNamed:@"info"];
        }
        default: break;
    }
    
    return image;
}

- (NSString *)title {
    NSString *title = @"";
    switch (self.type) {
        case IBLOrderTypeMine: {
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.controller.title.mine", @"Main", "not found");
            break;
        }
        case IBLOrderTypeManage: {
            title = NSLocalizedStringFromTable(@"IBLOrderViewModel.controller.title.managed", @"Main", "not found");
            break;
        }
    }
    return title;
}



- (NSString *)placeHolderWith:(IBLOrderAction)action atIndexPath:(NSIndexPath *)indexPath {
    NSString *placeHolder = @"";
    switch (action) {
        case IBLOrderActionTrash: {
            placeHolder = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.placeholder.trash", @"Main", "not found");;
            break;
        }
        case IBLOrderActionFinish: {
            placeHolder = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.placeholder.finish", @"Main", "not found");;
            break;
        }
        case IBLOrderActionDelete: {
            placeHolder = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.placeholder.delete", @"Main", "not found");;
            break;
        }
        case IBLOrderActionHandling:{
            placeHolder = NSLocalizedStringFromTable(@"IBLOrderViewModel.action.placeholder.handle", @"Main", "not found");;
        }
        default: break;
    }
    
    return placeHolder;
}

- (void)deleteOrderAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSection *section = [self sectionAt:indexPath.section];
    [section.items removeObjectAtIndex:indexPath.row];
}

- (void)handlerWithAction:(IBLOrderAction)action content:(NSString *)content indexPath:(NSIndexPath *)indexPath completeHandler:(void (^)(NSError *))handler {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    //!!!: can be refine
    switch (action) {
        case IBLOrderActionTrash: {
            [self.trashOrder trashOrderWith:order content:content completeHandler:^(NSError *error) {
                if (!error) [self finishedHandleOrderWithAction:action atIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionFinish: {
            [self.finishOrder finishOrderWith:order content:content completeHandler:^(NSError *error) {
                if (!error) [self finishedHandleOrderWithAction:action atIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionDelete: {
            [self.deleteOrder deleteOrderWithOrder:order content:content completeHandler:^(NSError *error) {
                if (!error) [self finishedHandleOrderWithAction:action atIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        case IBLOrderActionHandling:{
            [self.handleOrder handleOrderWithOrder:order markHandle:nil servId:nil content:content completeHandler:^(NSError *error) {
                if (!error) [self finishedHandleOrderWithAction:action atIndexPath:indexPath];
                handler(error);
            }];
            break;
        }
        default: break;
    }
}

- (NSIndexPath *)indexPathWithOrder:(IBLOrder *)order{
    return [self indexPathOfItem:order];
}

- (void)finisedHandleMineWorkOrderStatusWithWithAction:(IBLOrderAction)action
                                           atIndexPath:(NSIndexPath *)indexPath{
    switch (self.status) {
        case IBLOrderStatusSended: {
            switch (action) {
                case IBLOrderActionHandling:
                case IBLOrderActionFinish:
                case IBLOrderActionForward:
                case IBLOrderActionCreate:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                case IBLOrderActionViewSingle:
                default: break;
            }
            break;
        }
        case IBLOrderStatusHandling:{
            switch (action) {
                case IBLOrderActionFinish:
                case IBLOrderActionForward:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
        case IBLOrderStatusForwarding:{
            switch (action) {
                case IBLOrderActionFinish:
                case IBLOrderActionHandling:
                case IBLOrderActionCreate:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
        default: break;
    }
}

- (void)finishedHandleManagedWorkOrderStatusWithWithAction:(IBLOrderAction)action
                                               atIndexPath:(NSIndexPath *)indexPath{
    switch (self.status) {
        case IBLOrderStatusUnsend: {
            switch (action) {
                case IBLOrderActionSend:
                case IBLOrderActionDelete:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
        case IBLOrderStatusSended: {
            switch (action) {
                case IBLOrderActionForward:
                case IBLOrderActionFinish:
                case IBLOrderActionTrash:
                case IBLOrderActionDelete:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
            
        case IBLOrderStatusHandling: {
            switch (action) {
                case IBLOrderActionForward:
                case IBLOrderActionFinish:
                case IBLOrderActionTrash:
                case IBLOrderActionDelete:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
        case IBLOrderStatusFinished:
        {
            switch (action) {
                case IBLOrderActionDelete:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            break;
        }
        case IBLOrderStatusForwarding:{
            switch (action) {
                case IBLOrderActionFinish:
                case IBLOrderActionTrash:
                case IBLOrderActionDelete:{
                    [self deleteOrderAtIndexPath:indexPath];
                    break;
                }
                default: break;
            }
            
            break;
        }
        default: break;
    }
}


- (void)finishedHandleOrderWithAction:(IBLOrderAction)action
                          atIndexPath:(NSIndexPath *)indexPath {
    if (self.type == IBLOrderTypeMine) {
        [self finisedHandleMineWorkOrderStatusWithWithAction:action
                                                 atIndexPath:indexPath];
    }else{
        [self finishedHandleManagedWorkOrderStatusWithWithAction:action
                                                     atIndexPath:indexPath];
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


- (void)setStatus:(IBLOrderStatus)status {
    NSDictionary *statusMap = nil;
    switch (self.type) {
        case IBLOrderTypeMine: {
            statusMap = @{ @(IBLOrderStatusSended) : @(0),
                           @(IBLOrderStatusHandling) : @(1),
                           @(IBLOrderStatusFinished) : @(2),
                           @(IBLOrderStatusInvalid) : @(3),
//                           @(IBLOrderStatusInvalid): @(4)
                           } ;
            break;
        }
        case IBLOrderTypeManage: {
            statusMap = @{ @(IBLOrderStatusUnsend) : @(0),
                           @(IBLOrderStatusSended) : @(1),
                           @(IBLOrderStatusHandling) : @(2),
                           @(IBLOrderStatusFinished) : @(3),
                           @(IBLOrderStatusInvalid) : @(4),
//                           @(IBLOrderStatusInvalid): @(5)
                           } ;
            break;
        }
    }
    
    self.index = [statusMap[@(status)] integerValue];
}

- (BOOL)isHiddenPhoneAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    if (order.custType == 0) {
        return [NSString isNull:order.phone];
    }

    return [NSString isNull:order.comContactPhone];
}

- (NSString *)phoneAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];

    if (order.custType == 0) {
        return order.phone;
    }
    return order.comContactPhone;
}

- (NSString *)addressAtIndexPath:(NSIndexPath *)indexPath {
    IBLOrder *order = [self orderAtIndexPath:indexPath];
    NSString  *address = NSLocalizedStringFromTable(@"IBLOrderViewModel.cell.address", @"Main", "not found");
    if (order.custType == 0) {
        
        return [NSString stringWithFormat:@"%@：%@",address,order.address];
    }
    return [NSString stringWithFormat:@"%@：%@",address,order.comAddr];
}
@end
