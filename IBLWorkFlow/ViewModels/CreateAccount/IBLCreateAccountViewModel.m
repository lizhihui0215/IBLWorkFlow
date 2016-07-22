//
//  IBLCreateAccountViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountViewModel.h"
#import "IBLCreateAccountHiddenFields.h"
#import "IBLGenerateAppConfiguration.h"
#import "IBLProductRepository.h"
#import "IBLFetchProductPrice.h"


@interface IBLCreateAccountViewModel ()

@property (nonatomic, assign, readwrite) IBLCreateAccountType createAccountType;

@property (nonatomic, strong, readwrite) IBLOrder *order;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@property (nonatomic, strong) IBLGenerateAppConfiguration *generateAppConfiguration;

@property (nonatomic, strong) IBLFetchProductPrice *fetchProductPrice;

@property (nonatomic, strong) IBLProductPrice *productPrices;
@end

@implementation IBLCreateAccountViewModel

- (NSMutableArray *)dataSource{
    return nil;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
}

- (instancetype)initWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                    order:(IBLOrder *)order{
    self = [super init];
    if (self) {
        self.createAccountType = createAccountType;
        self.order = order;
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
        self.generateAppConfiguration = [[IBLGenerateAppConfiguration alloc] init];
        self.fetchProductPrice = [[IBLFetchProductPrice alloc] init];
    }

    return self;
}

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order{
    return [[self alloc] initWithCreateAccountType:createAccountType
                                             order:order];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    if([self.hiddenFields createAccountHiddenFieldsDictionary][indexPath]){
        return YES;
    }
    return NO;
}

- (IBLOrderEffectType)defaultEffectType {
    return [self.generateAppConfiguration defaultEffectType];
}

- (NSString *)defaultEffectDate {
    return [self.generateAppConfiguration defaultEffectDate];
}

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPrice
          completeHandler:(IBLViewModelCompleteHandler)handler {
    [self.fetchProductPrice fetchProductPrice:fetchProductPrice
                              completeHandler:^(IBLProductPrice *productPrice, NSError *error){
                                  self.productPrices = productPrice;
                                  handler(error);
                              }];
}

- (IBLProductPrice *)productPrice {
    return self.productPrices;
}
@end
