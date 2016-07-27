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

@property(nonatomic, strong) id type;
@property(nonatomic, strong) id cardNo;
@property(nonatomic, strong) id gender;
@property(nonatomic, strong) id cardPwd;
@property(nonatomic, strong) id genarate;
@property(nonatomic, strong) id account;
@property(nonatomic, strong) id password;
@property(nonatomic, strong) id userName;
@property(nonatomic, strong) id idNo;
@property(nonatomic, strong) id phone;
@property(nonatomic, strong) id subPhone;
@property(nonatomic, strong) id addr;
@property(nonatomic, strong) id birthDate;
@property(nonatomic, strong) id email;
@property(nonatomic, strong) id remark;
@property(nonatomic, strong) id productId;
@property(nonatomic, strong) id buyLength;
@property(nonatomic, strong) id extraLength;
@property(nonatomic, strong) id effType;
@property(nonatomic, strong) id effDate;
@property(nonatomic, strong) id discountItems;
@property(nonatomic, strong) id totalCost;
@property(nonatomic, strong) id preCost;
@property(nonatomic, strong) id nodeId;
@property(nonatomic, strong) id loginType;
@property(nonatomic, strong) id balanceType;
@property(nonatomic, strong) id prompt;
@property(nonatomic, strong) id contractCode;
@property(nonatomic, strong) id voiceCode;
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

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler;
@end
