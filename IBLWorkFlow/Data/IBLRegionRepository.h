//
//  IBLRegionRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLRegion.h"

@interface IBLRegionRepository : IBLBusinessRepository

- (void)fetchRegionWithRegionName:(NSString *)regionname
                  completeHandler:(void (^)(NSArray<IBLRegion *> *, NSError *))handler;

@end
