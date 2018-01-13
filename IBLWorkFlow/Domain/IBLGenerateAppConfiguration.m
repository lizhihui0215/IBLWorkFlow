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

static NSString const * kMineOrderForward = @"TRAN_MY_ORDER";

static NSString const * kManagedOrderSend = @"ISUUE";

static NSString const * kManagedOrderForward = @"TRAN";

static NSString const * kManagedOrderDelete = @"DEL_ORDER";

static NSString const * kManagedOrderTrash = @"CANCEL_ORDER";

static NSString const * kManagedOrderFinished = @"FINISH_MY_ORDER";

static NSString const * kManagedOrderView = @"VIEW_ORDER";

static NSString const * kMineOrderView = @"VIEW_SINGLE_ORDER";

static NSString const * kMineOrderFinished = @"FINISH_MY_ORDER";

static NSString const * kMineOrderOpenUser = @"OPEN_USER";




@interface IBLGenerateAppConfiguration ()

@end

@implementation IBLGenerateAppConfiguration

- (IBLPayModel)payModel{
    return [IBLAppRepository appConfiguration].payMode;
}

- (NSString *)defaultEffectDate {
    return [[NSDate date] stringFromFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

- (IBLOrderEffectType)defaultEffectType{
    return [IBLAppRepository appConfiguration].effType;
}

- (NSArray<IBLWorkOrderBussinessType *> *)allWorkOrderBizTypes {
    return [IBLAppRepository appConfiguration].workOrderBizTypes;
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
             kMineOrderFinished : @(IBLOrderActionFinish),
             kMineOrderForward : @(IBLOrderActionForward),
             kMineOrderOpenUser : @(IBLOrderActionCreate)};
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
    return @{kManagedOrderView : @(IBLOrderActionView)};
}

- (NSDictionary *)managedOrderFinishedMaps{
    return @{kManagedOrderView : @(IBLOrderActionView),
             kManagedOrderDelete : @(IBLOrderActionDelete)};
}

- (NSArray<NSNumber *> *)mineOrderActionsWithStatus:(IBLOrderStatus)status bizType:(IBLWorkOrderBizStatus)bizType handleUser:(NSInteger)handleUser {
    
    IBLUser *user = [IBLUserRepository user];
    
    NSMutableArray<NSNumber *> *actions = [NSMutableArray array];
    if ([user.identifier integerValue] != handleUser) {
         [actions addObject:[self mineOrderHandleForwardUnHandleMaps][kMineOrderView]] ;
        return actions;
    }

    for (IBLPremission *premission in user.permissions) {
        if ([kMineOrderOpenUser isEqualToString:premission.key] && bizType != IBLWorkOrderBizStatusInstall) {
            continue;
        }
        switch (status) {
            case IBLOrderStatusSended:
            case IBLOrderStatusForwarding:
            case IBLOrderStatusHandling: {
                NSNumber *action = [self mineOrderHandleForwardUnHandleMaps][premission.key];
                if (action){
                    [actions addObject:action];
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
    
//    switch (status) {
//        case IBLOrderStatusSended:
//        case IBLOrderStatusForwarding:
//        case IBLOrderStatusHandling: {
//            if (bizType == IBLWorkOrderBizStatusInstall) [actions addObject:@(IBLOrderActionCreate)];
//        }
//        default:
//            break;
//    }
    
    return [actions sortedArrayUsingSelector:@selector(compare:)];;
}


- (NSArray<NSNumber *> *)managedOrderActionsWithStatus:(IBLOrderStatus)status
                                              bizType:(IBLWorkOrderBizStatus)bizType{
    IBLUser *user = [IBLUserRepository user];

    NSMutableArray<NSNumber *> *actions = [NSMutableArray array];

    for (IBLPremission *premission in user.permissions) {
        switch (status) {
            case IBLOrderStatusUnsend: {
                NSNumber *action = [self managedOrderUnsendMaps][premission.key];
                if (action) [actions addObject:action];
                break;
            }
            case IBLOrderStatusSended:
            case IBLOrderStatusForwarding:
            case IBLOrderStatusHandling:
            {
                NSNumber *action = [self managedOrderSendHandingForwardMaps][premission.key];
                if (action) [actions addObject:action];
                break;
            }
            case IBLOrderStatusInvalid: {
                NSNumber *action = [self managedOrderTrashMaps][premission.key];
                if (action) [actions addObject:action];
                break;
            }
            case IBLOrderStatusFinished: {
                NSNumber *action = [self managedOrderFinishedMaps][premission.key];
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
