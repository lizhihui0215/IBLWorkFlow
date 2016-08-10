//
//  IBLCreateAccountHiddenFields.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@interface IBLCreateAccountHiddenFields : IBLUseCase

@property (nonatomic, strong) NSDictionary<NSIndexPath *, NSNumber *> *createAccountHiddenFieldsDictionary;

@property (nonatomic, strong) NSDictionary<NSIndexPath *, NSNumber *> *exchangeProductHiddenFieldsDictionary;

@property (nonatomic, strong) NSDictionary<NSIndexPath *, NSNumber *> *renewHiddenFieldsDictionary;



- (NSDictionary <NSIndexPath *, NSNumber *> *)createAccountNotNullFieldsDictionary;

- (NSDictionary <NSIndexPath *, NSNumber *> *)exchangeProductNotNullFieldsDictionary;

- (NSDictionary<NSIndexPath *, NSNumber *> *)renewNotNullFieldsDictionary;
@end
