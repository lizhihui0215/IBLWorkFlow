//
//  IBLUserListRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLRelateUser.h"

@interface IBLCreateAccountInfo :NSObject

@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *cardNo;
@property(nonatomic, copy) NSString *gender;
@property(nonatomic, copy) NSString *cardPwd;
@property(nonatomic, copy) NSString *genarate;
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *userName;
@property(nonatomic, copy) NSString *idNo;
@property(nonatomic, copy) NSString *phone;
@property(nonatomic, copy) NSString *subPhone;
@property(nonatomic, copy) NSString *addr;
@property(nonatomic, copy) NSString *birthDate;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *remark;
@property(nonatomic, copy) NSString *productId;
@property(nonatomic, copy) NSString *buyLength;
@property(nonatomic, copy) NSString *extraLength;
@property(nonatomic, copy) NSString *effType;
@property(nonatomic, copy) NSString *effDate;
@property(nonatomic, copy) NSString *discountItems;
@property(nonatomic, copy) NSString *totalCost;
@property(nonatomic, copy) NSString *preCost;
@property(nonatomic, copy) NSString *nodeId;
@property(nonatomic, copy) NSString *loginType;
@property(nonatomic, copy) NSString *balanceType;
@property(nonatomic, copy) NSString *prompt;
@property(nonatomic, copy) NSString *contractCode;
@property(nonatomic, copy) NSString *voiceCode;
@end

@interface IBLFetchUserListInfo : IBLFetchList
/// 用户账号 （支持迷糊查询）
@property (nonatomic, copy) NSString *account;
/// 用户姓名 （支持迷糊查询）
@property (nonatomic, copy) NSString *username;
/// 用户电话 （支持迷糊查询）
@property (nonatomic, copy) NSString *phone;
/// 用户小区名称 （支持迷糊查询）
@property (nonatomic, copy) NSString *areaName;
/// 用户小区Id （支持迷糊查询）
@property (nonatomic, assign) NSInteger areaIdentifier;
/// 用户身份证号 （支持迷糊查询）
@property (nonatomic, copy) NSString *userIdentifier;
/// 用户地址 （支持迷糊查询）
@property (nonatomic, copy) NSString *address;

+ (instancetype)infoWithAccount:(NSString *)account
                       username:(NSString *)username
                          phone:(NSString *)phone
                       areaName:(NSString *)areaName
                 areaIdentifier:(NSInteger)areaIdentifier
                 userIdentifier:(NSString *)userIdentifier
                        address:(NSString *)address;


@end

@interface IBLUserListRepository : IBLBusinessRepository

- (void)createAccountWithInfo:(IBLCreateAccountInfo *)createAccountInfo
              completeHandler:(void (^)(id, NSError *))handle;

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler;
@end
