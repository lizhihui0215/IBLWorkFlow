//
//  IBLFetchRegion.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchRegion.h"
#import "IBLRegionRepository.h"

@interface IBLFetchRegion ()
@property (nonatomic, assign) NSInteger start;

@property (nonatomic, strong) IBLRegionRepository *regionRepository;
@end

@implementation IBLFetchRegion

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.regionRepository = [[IBLRegionRepository alloc] init];
    }
    return self;
}


- (void)fetchRegionWithIsRefresh:(BOOL)refresh
                      regionname:(NSString *)regionname
                 completeHandler:(void (^)(NSArray<IBLRegion *> *, NSError *))handler {
    if ([NSString isNull:regionname]) regionname = @"";
    
    __block NSInteger start = self.start;
    
    if (refresh) start = 0; else start += 1;
    
    [self.regionRepository fetchRegionWithRegionName:regionname
                                     completeHandler:^(NSArray<IBLRegion *> *regions, NSError *error) {
                                         if (!error) self.start = start;
                                         handler(regions, error);
                                     }];
    
}
@end
