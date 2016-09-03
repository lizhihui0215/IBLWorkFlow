//
//  IBLProductRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLProductRepository.h"
#import "IBLProduct.h"
#import "IBLProductPrice.h"

static NSString *const kProductId = @"productId";

static NSString *const kRegionId = @"nodeId";

static NSString *const kProductName = @"offerName";

@interface IBLProductRepository ()

@property (nonatomic, strong) IBLSOAPMethod *fetchProduct;

@property (nonatomic, strong) IBLSOAPMethod *fetchProductPrice;

@end

@implementation IBLFetchProductPriceInfo

- (instancetype)initWithProductId:(NSInteger)productId discountIds:(NSString *)discountIds renew:(BOOL)renew {
    self = [super init];
    if (self) {
        self.productId = productId;
        self.discountIds = discountIds;
        self.renew = renew;
    }

    return self;
}

+ (instancetype)priceWithProductId:(NSInteger)productId discountIds:(NSString *)discountIds renew:(BOOL)renew {
    return [[self alloc] initWithProductId:productId discountIds:discountIds renew:renew];
}


@end

@implementation IBLFetchProductList

- (instancetype)initWithProductId:(NSInteger)productId
                         regionId:(NSInteger)regionId
                      productName:(NSString *)productName
                            start:(NSInteger)start
                         pageSize:(NSInteger)pageSize {
    self = [super initWithStart:start pageSize:pageSize];
    if (self) {
        self.productId = productId;
        self.regionId = regionId;
        self.productName = productName;
    }

    return self;
}

+ (instancetype)listWithProductId:(NSInteger)productId
                         regionId:(NSInteger)regionId
                      productName:(NSString *)productName
                            start:(NSInteger)start
                         pageSize:(NSInteger)pageSize {
    return [[self alloc] initWithProductId:productId
                                  regionId:regionId
                               productName:productName
                                     start:start
                                  pageSize:pageSize];
}

@end

@implementation IBLProductRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"ProductOfferInterface"];
    if (self) {
        self.fetchProduct = [IBLSOAPMethod methodWithRequestMethodName:@"getOfferList"
                                                    responseMethodName:@"getOfferListResponse"];
        
        self.fetchProductPrice = [IBLSOAPMethod methodWithRequestMethodName:@"getOfferTariffInfo"
                                                         responseMethodName:@"getOfferTariffInfoResponse"];
    }
    return self;
}

- (void)fetchProductsWithProductList:(IBLFetchProductList *)productList
                     completeHandler:(void (^)(NSArray<IBLProduct *>*, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        if (productList.productId != 0) parameters[kProductId] = @(productList.productId);
        if (productList.regionId != 0) parameters[kRegionId] = @(productList.regionId);
        parameters[kProductName] = productList.productName;
        parameters[kStart] = @(productList.start * productList.pageSize);
        parameters[kPageSize] = @(productList.pageSize);
        
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchProduct] POST:@"ProductOfferInterface"
                                               parameters:parameters
                                                 progress:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                      NSArray<NSDictionary *> *productListDictionarys = responseObject[@"offerList"];
                                                      
                                                      NSMutableArray<IBLProduct *> *products = [NSMutableArray array];
                                                      
                                                      for (NSDictionary *productDictionary in productListDictionarys) {
                                                          IBLProduct *product = [[IBLProduct alloc] initWithDictionary:productDictionary error:nil];
                                                          [products addObject:product];
                                                      }
                                                      handler(products, nil);
                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                      handler(nil, error);
                                                  }];
    
}

- (void)fetchPriductPrice:(IBLFetchProductPriceInfo *)fetchProductPriceInfo
          completeHandler:(void (^)(IBLProductPrice *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        if (fetchProductPriceInfo.productId != 0) parameters[@"offerId"] = @(fetchProductPriceInfo.productId);
        
        if (![NSString isNull:fetchProductPriceInfo.discountIds]) parameters[@"selItems"] = fetchProductPriceInfo.discountIds;
        
        parameters[@"isRenew"] = fetchProductPriceInfo.isRenew ? @"true" : @"false";
        
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchProductPrice] POST:@"ProductOfferInterface"
                                                    parameters:parameters
                                                      progress:nil
                                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                           IBLProductPrice *productPrice = [[IBLProductPrice alloc] initWithDictionary:responseObject error:nil];
                                                           handler(productPrice, nil);
                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                           handler(nil, error);
                                                       }];
}
@end
