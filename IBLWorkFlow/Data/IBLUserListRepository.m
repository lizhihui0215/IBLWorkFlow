//
//  IBLUserListRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserListRepository.h"
#import "IBLAppRepository.h"

@implementation IBLExchangeProductParameters

@end

@implementation IBLRenewParameters

@end

@implementation IBLCreateAccountInfo

@end

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

@property (nonatomic, strong) IBLSOAPMethod *fetchOnline;

@property (nonatomic, strong) IBLSOAPMethod *renewMethod;

@property (nonatomic, strong) IBLSOAPMethod *exchangeProductMethod;

@property (nonatomic, strong) IBLSOAPMethod *fetchOrderRelatedUserMethod;

@end

@implementation IBLUserListRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"User"];
    if (self) {
        self.fetchUserListMethod = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                             fileName:@"User"
                                                    requestMethodName:@"getUserList"
                                                   responseMethodName:@"getUserListResponse" ];
        
        self.createAccountMethod = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                             fileName:@"User"
                                                    requestMethodName:@"openAccount"
                                                   responseMethodName:@"openAccountResponse" ];
        
        self.fetchOnline = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                     fileName:@"User"
                                            requestMethodName:@"getOnlineRecord"
                                           responseMethodName:@"getOnlineRecordResponse" ];
        
        self.renewMethod = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                     fileName:@"User"
                                            requestMethodName:@"renew"
                                           responseMethodName:@"renewResponse" ];
        
        self.exchangeProductMethod = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                               fileName:@"User"
                                                      requestMethodName:@"change"
                                                     responseMethodName:@"changeResponse" ];
        
        self.fetchOrderRelatedUserMethod = [IBLSOAPMethod methodWithURLString:@"UserInterface"
                                                                     fileName:@"User"
                                                            requestMethodName:@"getUserInfo"
                                                           responseMethodName:@"getUserInfoResponse" ];
    }
    return self;
}

- (void)fetchOrderRelatedUserWithID:(NSString *)userID
                            account:(NSString *)account
                    completeHandler:(void (^)(IBLOrderRelateUser *, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"servId"] = userID;
        parameters[@"account"] = account;
        return parameters;
    }];
    [[IBLNetworkServices networkServicesWithMethod:self.fetchOrderRelatedUserMethod] POST:parameters
                                                                                 progress:nil
                                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                      IBLOrderRelateUser *user = [[IBLOrderRelateUser alloc] initWithDictionary:responseObject error:nil];
                                                                                      handler(user, nil);
                                                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                      handler(nil, error);
                                                                                  }];
}


- (void)fetchOnlineWithAccount:(NSString *)account
                          date:(NSString *)date
                         start:(NSInteger)start
                      pageSize:(NSInteger)pageSize
            completeHandler:(void (^)(NSArray<IBLNetworkRecord *> *, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"dateStr"] = [date stringByReplacingOccurrencesOfString:@"-" withString:@""];
        parameters[@"userName"] = account;
        parameters[kStart] = @(start * pageSize);
        parameters[kPageSize] =  @(pageSize);
        return parameters;
    }];
    [[IBLNetworkServices networkServicesWithMethod:self.fetchOnline] POST:parameters
                                                                                 progress:nil
                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                      NSArray *recordListDictionary = responseObject[@"recordList"];
                                                                      
                                                                      NSMutableArray<IBLNetworkRecord *> *records = [NSMutableArray array];
                                                                      
                                                                      for (NSDictionary *dictionary in recordListDictionary) {
                                                                          IBLNetworkRecord *networkRecord = [[IBLNetworkRecord alloc] initWithDictionary:dictionary error:nil];
                                                                          [records addObject:networkRecord];
                                                                      }
                                                                      
                                                                      handler(records, nil);
                                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                      handler(nil, error);
                                                                  }];
}

- (void)createAccountWithInfo:(IBLCreateAccountInfo *)createAccountInfo
              completeHandler:(void (^)(id, NSError *))handler{
    IBLAppConfiguration *appConfigration = [IBLAppRepository appConfiguration];
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"type"] = createAccountInfo.type;
        parameters[@"cardNo"] = createAccountInfo.cardNo;
        parameters[@"cardPwd"] = createAccountInfo.cardPwd;
        parameters[@"genarate"] =  appConfigration.genarate.toJSONString;
        parameters[@"account"] = createAccountInfo.account;
        parameters[@"password"] = createAccountInfo.password;
        parameters[@"userName"] = createAccountInfo.userName;
        parameters[@"gender"] = createAccountInfo.gender;
        parameters[@"idNo"] = createAccountInfo.idNo;
        parameters[@"phone"] = createAccountInfo.phone;
        parameters[@"subPhone"] = createAccountInfo.subPhone;
        parameters[@"addr"] = createAccountInfo.addr;
        parameters[@"birthDate"] = createAccountInfo.birthDate;
        parameters[@"offerId"] = createAccountInfo.offerId;
        parameters[@"email"] = createAccountInfo.email;
        parameters[@"remark"] = createAccountInfo.remark;
        parameters[@"productId"] = createAccountInfo.productId;
        parameters[@"buyLength"] = @(createAccountInfo.buyLength);
        parameters[@"extraLength"] = @(createAccountInfo.extraLength);
        parameters[@"effType"] = createAccountInfo.effType;
        parameters[@"effDate"] = createAccountInfo.effDate;
        parameters[@"discountItems"] = createAccountInfo.discountItems;
        parameters[@"totalCost"] = @(createAccountInfo.totalCost);
        parameters[@"preCost"] = @(createAccountInfo.preCost);
        parameters[@"nodeId"] = createAccountInfo.nodeId;
        parameters[@"loginType"] = createAccountInfo.loginType;
        parameters[@"balanceType"] = createAccountInfo.balanceType;
        parameters[@"prompt"] = createAccountInfo.prompt;
        parameters[@"contractCode"] = createAccountInfo.contractCode;
        parameters[@"voiceCode"] = createAccountInfo.voiceCode;
        return parameters;
    }];
    
    [[IBLNetworkServices networkServicesWithMethod:self.createAccountMethod] POST:parameters
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
        parameters[kStart] = @(result.start * result.pageSize);
        return parameters;
    }];
    [[IBLNetworkServices networkServicesWithMethod:self.fetchUserListMethod] POST:parameters
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

- (void)exchangeProductWithParameters:(IBLExchangeProductParameters *)exchangeProductParameters
                      completeHandler:(void (^)(NSString *obj, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"thirdId"] = exchangeProductParameters.thirdId;
        parameters[@"thirdType"] = exchangeProductParameters.thirdType;
        parameters[@"servId"] = exchangeProductParameters.servId;
        parameters[@"account"] = exchangeProductParameters.account;
        parameters[@"cardNos"] = exchangeProductParameters.cardNos;
        parameters[@"buyLength"] = @(exchangeProductParameters.buyLength);
        parameters[@"discountItems"] = exchangeProductParameters.discountItems;
        parameters[@"totalCost"] = @(exchangeProductParameters.totalCost);
        parameters[@"preCost"] = @(exchangeProductParameters.preCost);
        parameters[@"otherCost"] = exchangeProductParameters.otherCost;
        parameters[@"extraLength"] = @(exchangeProductParameters.extraLength);
        parameters[@"offerId"] = exchangeProductParameters.offerId;
        parameters[@"prompt"] = exchangeProductParameters.prompt;
        parameters[@"remark"] = exchangeProductParameters.remark;
        parameters[@"contractCode"] = exchangeProductParameters.contractCode;
        parameters[@"voiceCode"] = exchangeProductParameters.voiceCode;
        parameters[@"changeType"] = exchangeProductParameters.changeType;
        return parameters;
    }];
    [[IBLNetworkServices networkServicesWithMethod:self.exchangeProductMethod] POST:parameters
                                                                         progress:nil
                                                                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                handler(@"", nil);
                                                                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                handler(nil, error);
                                                                            }];
}

- (void)renewWithRenewParameters:(IBLRenewParameters *)renewParameters
                 completeHandler:(void (^)(NSString *obj, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"thirdId"] = renewParameters.thirdId;
        parameters[@"thirdType"] = renewParameters.thirdType;
        parameters[@"servId"] = @(renewParameters.servId);
        parameters[@"account"] = renewParameters.account;
        parameters[@"cardNos"] = renewParameters.cardNos;
        parameters[@"buyLength"] = @(renewParameters.buyLength);
        parameters[@"discountItems"] = renewParameters.discountItems;
        parameters[@"totalCost"] = @(renewParameters.totalCost);
        parameters[@"preCost"] = @(renewParameters.preCost);
        parameters[@"otherCost"] = @(renewParameters.otherCost);
        parameters[@"extraLength"] = @(renewParameters.extraLength);
        parameters[@"prompt"] = renewParameters.prompt;
        parameters[@"remark"] = renewParameters.remark;
        parameters[@"contractCode"] = renewParameters.contractCode;
        parameters[@"voiceCode"] = renewParameters.voiceCode;
        return parameters;
    }];
    [[IBLNetworkServices networkServicesWithMethod:self.renewMethod] POST:parameters
                                                                           progress:nil
                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                      handler(@"", nil);
                                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                      handler(nil, error);
                                                                  }];
}

@end
