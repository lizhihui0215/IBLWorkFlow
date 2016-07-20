//
// Created by 李智慧 on 7/19/16.
// Copyright (c) 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@interface IBLTrashOrder : IBLUseCase

- (void)trashOrderWith:(IBLOrder *)order completeHandler:(void (^)(NSError *))handler;
@end