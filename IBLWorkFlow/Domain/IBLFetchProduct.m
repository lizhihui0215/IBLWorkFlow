//
//  IBLFetchProduct.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchProduct.h"

@interface IBLFetchProduct()

@property (nonatomic, strong) IBLProductRepository *productRepository;

@property (nonatomic, assign) NSInteger start;

@end

@implementation IBLFetchProduct

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.productRepository = [[IBLProductRepository alloc] init];
    }
    return self;
}

- (void)fetchProductsWithIsRefresh:(BOOL)refresh
                         productId:(NSInteger)productId
                          regionId:(NSInteger)regionId
                       productName:(NSString *)name
                   completeHandler:(void (^)(NSArray<IBLProduct *> *, NSError *))handler {
    NSInteger start = self.start;
    
    IBLFetchProductList *fetchProductList = [IBLFetchProductList listWithProductId:productId
                                                                          regionId:regionId
                                                                       productName:name
                                                                             start:start++
                                                                          pageSize:20];
    
    [self.productRepository fetchProductsWithProductList:fetchProductList
                                         completeHandler:^(NSArray<IBLProduct *> *products, NSError *error) {
                                             if (!error) self.start = fetchProductList.start;
                                             handler(products, error);
                                         }];

}
@end
