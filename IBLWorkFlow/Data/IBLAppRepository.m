//
//  IBLAppRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAppRepository.h"

static IBLAppConfiguration *_appConfiguration;

@interface IBLAppRepository ()
@property (nonatomic, strong) IBLSOAPMethod *fetchAppConfiguration;

@end

@implementation IBLAppRepository

+ (IBLAppConfiguration *)appConfiguration{
    return _appConfiguration;
}

+ (void)setAppConfiguration:(IBLAppConfiguration *)appConfiguration{
    _appConfiguration = appConfiguration;
}

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"Configuration"];
    if (self) {
        self.fetchAppConfiguration = [IBLSOAPMethod methodWithURLString:@"ConfigInterface"
                                                               fileName:@"Configuration"
                                                      requestMethodName:@"getAPPConfig"
                                                     responseMethodName:@"getAPPConfigResponse"];
    }
    return self;
}

- (void)fetchWithConfigurationWithCompleteHandler:(void (^)(IBLAppConfiguration *, NSError *))handler {
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        [parameters removeObjectForKey:kMCode];
        [parameters removeObjectForKey:kSessionID];
        return parameters;
    }];
    
    [[IBLNetworkServices networkServicesWithMethod:self.fetchAppConfiguration] POST:parameters
                                                                           progress:nil
                                                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                NSError *error = nil;
                                                                                
                                                                                IBLAppConfiguration *configuration = [[IBLAppConfiguration alloc] initWithDictionary:responseObject error:&error];
                                                                                
                                                                                [IBLAppRepository setAppConfiguration:configuration];
                                                                                handler(configuration, error);
                                                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                
                                                                                handler(nil, error);
                                                                            }];
}

@end
