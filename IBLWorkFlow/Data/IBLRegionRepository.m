//
//  IBLRegionRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRegionRepository.h"

static NSString *const IBLChannelInterface = @"ChannelInterface";

static NSString *const kRegionName = @"areaName";

@interface IBLRegionRepository ()
@property (nonatomic, strong) IBLSOAPMethod *fetchRegion;

@end

@implementation IBLRegionRepository
- (instancetype)init
{
    self = [super initWithSOAPFileName:IBLChannelSOAPFileName];
    if (self) {
        self.fetchRegion = [IBLSOAPMethod methodWithRequestMethodName:@"getChannelList"
                                                   responseMethodName:@"getChannelListResponse"];
    }
    return self;
}

- (void)fetchRegionWithRegionName:(NSString *)regionname
                  completeHandler:(void (^)(NSArray<IBLRegion *> *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kRegionName] = regionname;
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchRegion] POST:IBLChannelInterface
                                                parameters:parameters
                                                  progress:nil
                                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                       NSArray<NSDictionary *> *regionListDictionarys = responseObject[@"channelList"];
                                                       
                                                       NSMutableArray<IBLRegion *> *regions = [NSMutableArray array];
                                                       
                                                       for (NSDictionary *regionDictionary in regionListDictionarys) {
                                                           IBLRegion *region = [[IBLRegion alloc] initWithDictionary:regionDictionary error:nil];
                                                           [regions addObject:region];
                                                       }
                                                       
                                                       handler(regions, nil);
                                                   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                       handler(nil, error);
                                                   }];

}
@end
