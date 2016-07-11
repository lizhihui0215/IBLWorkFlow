//
//  IBLUserRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserRepository.h"
static NSString * const kUsername = @"loginName";

static NSString * const kPassword = @"password";

static NSString * const kPhoneModel = @"phoneModel";

static NSString * const kOSVersion = @"osVersion";



@implementation IBLUserRepository

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkServices.requestSerializer = [IBLWebServiceRequestSerializer serializerWithFilename:@"Operator" methodName:@"auth"];
        
        self.networkServices.responseSerializer = [IBLWebServiceResponseSerializer serializerWithMethodName:@"authResponse"];
    }
    return self;
}

- (void)fetchWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(void (^)(IBLUser *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        
        [parameters addEntriesFromDictionary:@{kUsername : username,
                                               kPassword : password,
                                               kPhoneModel : @"",
                                               kOSVersion : @""}];
        
        return parameters;
    }];
    
    [self.networkServices POST:@"OperatorInterface"
                    parameters:parameters
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           
                       }];
}
@end
