//
// Created by 李智慧 on 7/22/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLFetchProductPrice.h"

@interface IBLFetchProductPrice ()

@property (nonatomic, strong) IBLProductRepository *productRepository;

@end

@implementation IBLFetchProductPrice

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.productRepository = [[IBLProductRepository alloc] init];
    }
    return self;
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPriceInfo
          completeHandler:(void (^)(IBLProductPrice *, NSError *))handler {
    [self.productRepository fetchPriductPrice:fetchProductPriceInfo
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error){
                                  handler(productPrice, error);
                              }];

}
@end