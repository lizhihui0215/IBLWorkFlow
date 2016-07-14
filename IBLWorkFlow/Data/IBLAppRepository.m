//
//  IBLAppRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAppRepository.h"

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
    self = [super init];
    if (self) {
        self.networkServices.requestSerializer = [IBLWebServiceRequestSerializer serializerWithFilename:@"Operator" methodName:@"auth"];
        
        self.networkServices.responseSerializer = [IBLWebServiceResponseSerializer serializerWithMethodName:@"authResponse"];
    }
    return self;
}

- (void)fetchWithConfigurationWithCompleteHandler:(void (^)(id, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        return aParameters;
    }];
    
    [self.networkServices POST:@"OperatorInterface"
                    parameters:parameters
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           NSError *error = [self handleErrorWithResponseObject:responseObject];
                           
                           if (error) { handler(nil,error); return; }
                           
//                           IBLUser *user = [[IBLUser alloc] initWithDictionary:responseObject error:nil];
                           
//                           handler(user, nil);
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           handler(nil, error);
                       }];
}

@end
