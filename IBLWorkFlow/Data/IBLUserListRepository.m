//
//  IBLUserListRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserListRepository.h"

@implementation IBLFetchUserListInfo
- (instancetype)initWithAccount:(NSString *)account
                       username:(NSString *)username
                          phone:(NSString *)phone
                       areaName:(NSString *)areaName
                 areaIdentifier:(NSInteger)areaIdentifier
                 userIdentifier:(NSString *)userIdentifier
                        address:(NSString *)address {
    self = [super initWithStart:0 pageSize:0];
    if (self) {
        self.account = account;
        self.username = username;
        self.phone = phone;
        self.areaName = areaName;
        self.areaIdentifier = areaIdentifier;
        self.userIdentifier = userIdentifier;
        self.address = address;
    }

    return self;
}

+ (instancetype)infoWithAccount:(NSString *)account
                       username:(NSString *)username
                          phone:(NSString *)phone
                       areaName:(NSString *)areaName
                 areaIdentifier:(NSInteger)areaIdentifier
                 userIdentifier:(NSString *)userIdentifier
                        address:(NSString *)address {
    return [[self alloc] initWithAccount:account
                                username:username
                                   phone:phone
                                areaName:areaName
                          areaIdentifier:areaIdentifier
                          userIdentifier:userIdentifier
                                 address:address];
}


@end

@interface IBLUserListRepository ()

@property (nonatomic, strong) IBLSOAPMethod *fetchUserListMethod;

@property (nonatomic, strong) IBLSOAPMethod *createAccountMethod;

@end

@implementation IBLUserListRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"User"];
    if (self) {
        self.fetchUserListMethod = [IBLSOAPMethod methodWithRequestMethodName:@"getUserList" responseMethodName:@"getUserListResponse"];
        
        self.createAccountMethod = [IBLSOAPMethod methodWithRequestMethodName:@"openAccount"
                                                           responseMethodName:@"openAccountResponse"];

    }
    return self;
}

- (void)createAccountWithInfo:(IBLCreateAccountInfo *)createAccountInfo
              completeHandler:(void (^)(id, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"type"] = createAccountInfo.type;
        parameters[@"cardNo"] = createAccountInfo.cardNo;
        parameters[@"cardPwd"] = createAccountInfo.cardPwd;
        parameters[@"genarate"] = createAccountInfo.genarate;
        parameters[@"account"] = createAccountInfo.account;
        parameters[@"password"] = createAccountInfo.password;
        parameters[@"userName"] = createAccountInfo.userName;
        parameters[@"gender"] = createAccountInfo.gender;
        parameters[@"idNo"] = createAccountInfo.idNo;
        parameters[@"phone"] = createAccountInfo.phone;
        parameters[@"subPhone"] = createAccountInfo.subPhone;
        parameters[@"addr"] = createAccountInfo.addr;
        parameters[@"birthDate"] = createAccountInfo.birthDate;
        parameters[@"email"] = createAccountInfo.email;
        parameters[@"remark"] = createAccountInfo.remark;
        parameters[@"productId"] = createAccountInfo.productId;
        parameters[@"buyLength"] = createAccountInfo.buyLength;
        parameters[@"extraLength"] = createAccountInfo.extraLength;
        parameters[@"effType"] = createAccountInfo.effType;
        parameters[@"effDate"] = createAccountInfo.effDate;
        parameters[@"discountItems"] = createAccountInfo.discountItems;
        parameters[@"totalCost"] = createAccountInfo.totalCost;
        parameters[@"preCost"] = createAccountInfo.preCost;
        parameters[@"nodeId"] = createAccountInfo.nodeId;
        parameters[@"loginType"] = createAccountInfo.loginType;
        parameters[@"balanceType"] = createAccountInfo.balanceType;
        parameters[@"prompt"] = createAccountInfo.prompt;
        parameters[@"contractCode"] = createAccountInfo.contractCode;
        parameters[@"voiceCode"] = createAccountInfo.voiceCode;
        return parameters;
    }];
    

    [[self networkServicesMethods:self.createAccountMethod] POST:@"UserInterface"
                                                      parameters:parameters
                                                        progress:nil
                                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                             handler(responseObject[@"resultCode"], nil);
                                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                             handler(nil, error);
                                                         }];
}

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler {
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"account"] = result.account;
        parameters[@"userName"] = result.username;
        parameters[@"phone"] = result.phone;
        if (result.areaIdentifier != 0) parameters[@"nodeId"] = @(result.areaIdentifier);
//        parameters[@"areaName"] = result.areaName;
        parameters[@"idNo"] = result.userIdentifier;
        parameters[@"addr"] = result.address;
        parameters[kPageSize] = @(result.pageSize);
        parameters[kStart] = @(result.start);
        return parameters;
    }];
    
    [[self networkServicesMethods:self.fetchUserListMethod] POST:@"UserInterface"
                                                  parameters:parameters
                                                    progress:nil
                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                        NSArray *relateUserDictionarys = responseObject[@"userList"];
                                                         
                                                         
                                                         NSMutableArray<IBLRelateUser *> *relateUsers = [NSMutableArray array];
                                                         
                                                         for (NSDictionary *relateUserDictionary in relateUserDictionarys) {
                                                             IBLRelateUser *user = [[IBLRelateUser alloc] initWithDictionary:relateUserDictionary error:nil];
                                                             [relateUsers addObject:user];
                                                         }
                                                         
                                                         handler(relateUsers, nil);
                                                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                         handler(nil, error);
                                                     }];
}
@end
