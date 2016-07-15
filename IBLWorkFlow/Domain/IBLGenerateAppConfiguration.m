//
//  IBLGenerateAppConfiguration.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLGenerateAppConfiguration.h"
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
@end
