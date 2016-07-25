//
//  IBLGenerateAppConfiguration.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLGenerateAppConfiguration.h"
#import "IBLUserRepository.h"
#import "IBLAppRepository.h"

static NSString const * kMineOrderHandle = @"HANDLE";

static NSString const * kManagedOrderSend = @"ISUUE";

static NSString const * kManagedOrderForward = @"TRAN";

static NSString const * kManagedOrderDelete = @"DEL_ORDER";

static NSString const * kManagedOrderTrash = @"CANCEL_ORDER";

static NSString const * kManagedOrderFinished = @"FINISH_ORDER";

static NSString const * kManagedOrderView = @"VIEW_ORDER";

static NSString const * kMineOrderView = @"VIEW_SINGLE_ORDER";

static NSString const * kMineOrderFinished = @"";




@interface IBLGenerateAppConfiguration ()

@end

@implementation IBLGenerateAppConfiguration

- (NSString *)defaultEffectDate {
    return nil;
}

- (IBLOrderEffectType)defaultEffectType{
    return [IBLAppRepository appConfiguration].effType;
}

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypesWithStatus:(IBLWorkOrderStatus)status {
    
    NSString *string = [@(status) stringValue];
    
    NSMutableArray <IBLWorkOrderBussinessType *> *workOrderBizTypes = [NSMutableArray array];
    
    for (IBLWorkOrderBussinessType *type in [IBLAppRepository appConfiguration].workOrderBizTypes) {
        if([[@(type.status) stringValue] hasPrefix:string]) [workOrderBizTypes addObject:type];
    }
    
    [workOrderBizTypes sortUsingSelector:@selector(compare:)];
    
    return workOrderBizTypes;
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypes {
    return [IBLAppRepository appConfiguration].workOrderTypes;
}

- (NSDictionary *)mineOrderHandleForwardUnHandleMaps{
    return @{kMineOrderHandle : @(IBLOrderActionHandling),
             kMineOrderView : @(IBLOrderActionViewSingle),
             kMineOrderFinished : @(IBLOrderActionFinish)};
}

- (NSDictionary *)mineOrderFinishedMaps{
    return @{kMineOrderView : @(IBLOrderActionViewSingle)};
}

- (NSDictionary *)mineOrderTrashedMaps{
    return @{kMineOrderView : @(IBLOrderActionViewSingle)};
}

- (NSDictionary *)managedOrderUnsendMaps{
    return @{kManagedOrderSend : @(IBLOrderActionSend),
             kManagedOrderView : @(IBLOrderActionView),
             kManagedOrderDelete : @(IBLOrderActionDelete)};
}

- (NSDictionary *)managedOrderSendHandingForwardMaps{
    return @{kManagedOrderForward : @(IBLOrderActionForward),
             kManagedOrderTrash : @(IBLOrderActionTrash),
             kManagedOrderFinished : @(IBLOrderActionFinish),
             kManagedOrderView : @(IBLOrderActionView),
             kManagedOrderDelete : @(IBLOrderActionDelete)};
}

- (NSDictionary *)managedOrderTrashMaps{
    return @{kManagedOrderView : @(IBLOrderActionView),
             kManagedOrderDelete : @(IBLOrderActionDelete)};
}

- (NSArray<NSNumber *> *)mineOrderActionsWithStatus:(IBLOrderStatus)status
                                            bizType:(IBLWorkOrderBizStatus)bizType {
    
    IBLUser *user = [IBLUserRepository user];
    
    NSMutableArray<NSNumber *> *actions = [NSMutableArray array];
    
    for (IBLPremission *premission in user.permissions) {
        switch (status) {
            case IBLOrderStatusSended:
            case IBLOrderStatusForwarding: {
            case IBLOrderStatusHandling: {
                NSNumber *action = [self mineOrderHandleForwardUnHandleMaps][premission.key];
                if (action){
                    [actions addObject:action];
                    if (bizType == IBLWorkOrderBizStatusRepair) [actions addObject:@(IBLOrderActionCreate)];
                };
                break;
            }
                
            case IBLOrderStatusFinished: {
                NSNumber *action = [self mineOrderFinishedMaps][premission.key];
                if (action) [actions addObject:action];
                
                break;
            }
            case IBLOrderStatusInvalid: {
                NSNumber *action = [self mineOrderTrashedMaps][premission.key];
                if (action) [actions addObject:action];
                
                break;
            }
            default:
                break;
            }
        }
    }
    
    return [actions sortedArrayUsingSelector:@selector(compare:)];;
}


- (NSArray<NSNumber *> *)managedOrderActionsWithStatus:(IBLOrderStatus)status
                                              bizType:(IBLWorkOrderBizStatus)bizType{
    IBLUser *user = [IBLUserRepository user];

    NSMutableArray<NSNumber *> *actions = [NSMutableArray array];

    for (IBLPremission *premission in user.permissions) {
        switch (status) {
            case IBLOrderStatusUnsend: {
                
                break;
            }
            case IBLOrderStatusSended:
            case IBLOrderStatusForwarding:
            case IBLOrderStatusHandling:
            {
                NSNumber *action = [self managedOrderUnsendMaps][premission.key];
                if (action) [actions addObject:action];
                break;
                break;
            }
            case IBLOrderStatusInvalid: {
                NSNumber *action = [self managedOrderSendHandingForwardMaps][premission.key];
                if (action) [actions addObject:action];
                break;
            }
            case IBLOrderStatusFinished: {
                NSNumber *action = [self managedOrderTrashMaps][premission.key];
                if (action) [actions addObject:action];
                break;
            }
            default:
                break;
        }
    }
    
    return [actions sortedArrayUsingSelector:@selector(compare:)];
}


@end
