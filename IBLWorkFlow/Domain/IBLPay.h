//
//  IBLPay.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLPayRepository.h"

@interface IBLPay : IBLUseCase

- (void)payWithQRPayInfo:(IBLQRPayInfo *)QRPayInfo
         completeHandler:(void (^)(NSString *, NSError *))handler;

@end
