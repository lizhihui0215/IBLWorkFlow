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

@interface IBLCreateAccountViewModel : IBLListViewModel

@property (nonatomic, assign, readonly) IBLCreateAccountType createAccountType;
@property (nonatomic, strong, readonly) IBLOrder *order;

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

- (IBLOrderEffectType)defaultEffectType;

- (NSString *)defaultEffectDate;

- (void)fetchProductPrice:(IBLFetchProductPriceInfo *)fetchProductPrice completeHandler:(IBLViewModelCompleteHandler)handler;

- (IBLProductPrice *)productPrice;

- (NSDictionary<NSIndexPath *, NSString *> *)notNullFieldsDictionary;

- (IBLPayModel)payModel;

- (void)createAccountWith:(IBLCreateAccountInfo *)info completeHandler:(void (^)(NSError *))handler;
@end
