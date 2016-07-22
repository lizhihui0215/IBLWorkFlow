//
// Created by 李智慧 on 7/22/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLProductRepository.h"

@interface IBLFetchProductPrice : IBLUseCase

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPriceInfo
          completeHandler:(void (^)(IBLProductPrice *, NSError *))handler;
@end