//
//  IBLAppRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAppRepository.h"

@interface IBLAppRepository ()
@property (nonatomic, strong) IBLSOAPMethod *fetchAppConfiguration;

@end

@implementation IBLAppRepository
//+ (IBLUser *)user{
//    return _user;
//}
//
//+ (void)setUser:(IBLUser *)user{
//    _user = user;
//}

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"Configuration"];
    if (self) {
        self.fetchAppConfiguration = [IBLSOAPMethod methodWithRequestMethodName:@"getAPPConfig" responseMethodName:@"getAPPConfigResponse"];

    }
    return self;
}

- (void)fetchWithConfigurationWithCompleteHandler:(void (^)(id, NSError *))handler {
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        [parameters removeObjectForKey:kMCode];
        [parameters removeObjectForKey:kSessionID];
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchAppConfiguration] POST:@"ConfigInterface"
                                                        parameters:parameters
                                                          progress:nil
                                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                               
                                                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                               handler(nil, error);
                                                           }];
}

@end
