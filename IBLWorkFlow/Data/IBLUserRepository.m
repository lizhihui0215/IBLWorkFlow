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

static IBLUser *_user = nil;

@interface IBLUserRepository ()
@property (nonatomic, strong) IBLSOAPMethod *fetchUserMethod;
@end

@implementation IBLUserRepository

+ (IBLUser *)user{
    return _user;
}

+ (void)setUser:(IBLUser *)user{
    _user = user;
}

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"Operator"];
    if (self) {
        self.fetchUserMethod = [IBLSOAPMethod methodWithRequestMethodName:@"auth" responseMethodName:@"authResponse"];

    }
    return self;
}

- (void)fetchWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(void (^)(IBLUser *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        NSString *deviceModel = DeviceVersionNames[[SDVersion deviceVersion]];
        NSString *OSVersion = [[UIDevice currentDevice] systemVersion];
        [parameters addEntriesFromDictionary:@{kUsername : username,
                                               kPassword : password,
                                               kPhoneModel : deviceModel,
                                               kOSVersion : OSVersion}];
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchUserMethod] POST:@"OperatorInterface"
                    parameters:parameters
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           IBLUser *user = [[IBLUser alloc] initWithDictionary:responseObject error:nil];
                           handler(user, nil);
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           handler(nil, error);
                       }];
}

@end
