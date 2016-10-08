//
// Created by 李智慧 on 7/19/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@class IBLOrder;
@interface IBLTrashOrder : IBLUseCase

- (void)trashOrderWith:(IBLOrder *)order content:(NSString *)content completeHandler:(void (^)(NSError *))handler;
@end