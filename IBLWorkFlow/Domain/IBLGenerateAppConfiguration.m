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

@interface IBLGenerateAppConfiguration ()

@end

@implementation IBLGenerateAppConfiguration

- (NSArray<IBLWorkOrderBussinessType *> *)workOrderBizTypes {
    return [IBLAppRepository appConfiguration].workOrderBizTypes;
}

- (NSArray<IBLWorkOrderType *> *)workOrderTypes {
    return [IBLAppRepository appConfiguration].workOrderTypes;
}

//- (NSDictionary *)orderActionsMap{
//    @{kMineWorkOrder : menu1,
//      kMineWorkOrderManage : menu2,
//      kAddOrder : menu3,
//      kCreaetAccount : menu4,
//      kRenew : menu5,
//      kChangeProduct : menu6}
//}

- (NSArray<NSNumber *> *)orderOperationButtonsWithStatus:(IBLOrderStatus)status {
    
    IBLUser *user = [IBLUserRepository user];
    
    
    for (IBLPremission *premission in user.permissions) {
        
    }
    
    
    
    
    return nil;
}
@end
