//
//  IBLExchangeProduct.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUserListRepository.h"

@interface IBLExchangeProduct : IBLUseCase

- (void)exchangeProductWithParameters:(IBLExchangeProductParameters *)exchangeProductParameters
                      completeHandler:(void (^)(NSString *obj, NSError *))handler;

@end
