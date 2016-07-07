//
//  IBLFetchUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUser.h"

@interface IBLFetchUser : IBLUseCase

- (void)startFetchWithCompleteHandler:(void (^)(IBLUser *, NSError *))handler;
@end
