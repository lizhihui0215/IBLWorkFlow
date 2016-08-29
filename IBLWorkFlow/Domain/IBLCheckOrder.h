//
//  IBLCheckOrder.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLPayRepository.h"

@interface IBLCheckOrder : IBLUseCase

- (void)checkOrderWithNumber:(NSString *)orderNumber
             completeHandler:(void (^)(IBLOrderPayStatus, NSError *))handler;

@end
