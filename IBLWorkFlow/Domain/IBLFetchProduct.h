//
//  IBLFetchProduct.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLProductRepository.h"

@interface IBLFetchProduct : IBLUseCase

- (void)fetchProductsWithIsRefresh:(BOOL)refresh
                         productId:(NSInteger)productId
                          regionId:(NSInteger)regionId
                       productName:(NSString *)name
                   completeHandler:(void (^)(NSArray<IBLProduct *> *, NSError *))handler;
@end
