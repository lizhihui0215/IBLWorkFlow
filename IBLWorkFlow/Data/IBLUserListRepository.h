//
//  IBLUserListRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLRelateUser.h"

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

- (void)fetchUserListWithIsRefresh:(BOOL)refresh fetchResult:(IBLFetchUserListInfo *)result completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler;
@end
