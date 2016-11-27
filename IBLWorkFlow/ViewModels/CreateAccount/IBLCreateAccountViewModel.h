//
//  IBLCreateAccountViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLOrder.h"
@class IBLFetchProductPriceInfo;
@class IBLProductPrice;
@class IBLCreateAccountInfo;
@class IBLCreateAccountTableViewInfo;
@class IBLPayResult;

@interface IBLCreateAccountViewModel : IBLListViewModel

@property (nonatomic, assign, readonly) IBLCreateAccountType createAccountType;
@property (nonatomic, strong, readonly) IBLOrder *order;
@property (nonatomic, strong, readonly) IBLPayResult *payResult;

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

- (IBLOrderEffectType)defaultEffectType;

- (NSString *)defaultEffectDate;

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPrice completeHandler:(IBLViewModelCompleteHandler)handler;

- (IBLProductPrice *)productPrice;

- (NSDictionary<NSIndexPath *, NSString *> *)notNullFieldsDictionary;

- (IBLPayModel)payModel;

- (void)createAccountWith:(IBLCreateAccountTableViewInfo *)info completeHandler:(void (^)(NSError *))handler;

- (void)payWithType:(NSString *)type
  createAccountInfo:(IBLCreateAccountTableViewInfo *)createAccountInfo
    completeHandler:(IBLViewModelCompleteHandler)handler;

@end
