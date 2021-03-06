//
//  IBLProductRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLProduct.h"
#import "IBLProductPrice.h"

@interface IBLFetchProductList : IBLFetchList

@property (nonatomic, assign) NSInteger productId;

@property (nonatomic, assign) NSInteger regionId;

@property (nonatomic, copy) NSString *productName;

- (instancetype)initWithProductId:(NSInteger)productId
                         regionId:(NSInteger)regionId
                      productName:(NSString *)productName
                            start:(NSInteger)start
                         pageSize:(NSInteger)pageSize;

+ (instancetype)listWithProductId:(NSInteger)productId
                         regionId:(NSInteger)regionId
                      productName:(NSString *)productName
                            start:(NSInteger)start
                         pageSize:(NSInteger)pageSize;


@end

@interface IBLFetchProductPriceInfo : NSObject

@property (nonatomic,assign) NSInteger productId;

@property (nonatomic, copy) NSString *discountIds;

@property (nonatomic, assign, getter=isRenew) BOOL renew;

+ (instancetype)priceWithProductId:(NSInteger)productId discountIds:(NSString *)discountIds renew:(BOOL)renew;

@end

@interface IBLProductRepository : IBLBusinessRepository

- (void)fetchProductsWithProductList:(IBLFetchProductList *)productList
                     completeHandler:(void (^)(NSArray<IBLProduct *>*, NSError *))handler;

- (void)fetchPriductPrice:(IBLFetchProductPriceInfo *)fetchProductPriceInfo completeHandler:(void (^)(IBLProductPrice *, NSError *))handler;
@end
