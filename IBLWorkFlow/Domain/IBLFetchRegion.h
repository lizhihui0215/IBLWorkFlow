//
//  IBLFetchRegion.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
@class IBLRegion;
@interface IBLFetchRegion : IBLUseCase

- (void)fetchRegionWithIsRefresh:(BOOL)refresh regionname:(NSString *)regionname completeHandler:(void (^)(NSArray<IBLRegion *> *, NSError *))handler;
@end
