//
//  IBLUserListRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLRelateUser.h"
#import "IBLOrderRelateUser.h"
#import "IBLNetworkRecord.h"

@interface IBLExchangeProductParameters : NSObject
/// 第三方类型（可选）
@property (nonatomic, copy) NSString *thirdType;
/// 第三方id
@property (nonatomic, copy) NSString *thirdId;
/// 用户ID
@property (nonatomic, copy) NSString *servId;
/// 用户账号
@property (nonatomic, copy) NSString *account;
/// 卡号ID集合，格式为以逗号为分割的ID字符串
@property (nonatomic, copy) NSString *cardNos;
/// 购买销售品数（可选）
@property (nonatomic, assign) NSInteger buyLength;
/// 所选优惠条目ID
@property (nonatomic, copy) NSString *discountItems;
/// 总金额，以分为单位（必选）
@property (nonatomic, assign) CGFloat totalCost;
/// 优惠金额，以分为单位（可选）
@property (nonatomic, assign) CGFloat preCost;
/// 其它金额，以分为单位（可选）
@property (nonatomic, copy) NSString *otherCost;
/// 临时赠送量
@property (nonatomic, assign) NSInteger extraLength;
/// 缴费类型
@property (nonatomic, copy) NSString *balanceType;
/// 是否立即开户
@property (nonatomic, copy) NSString *prompt;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 合同号
@property (nonatomic, copy) NSString *contractCode;
/// 票据号
@property (nonatomic, copy) NSString *voiceCode;
/// 更换类型
@property (nonatomic, copy) NSString *changeType;

@property (nonatomic, copy) NSString *offerId;

@end

@interface IBLRenewParameters : NSObject
/// 第三方类型（可选）
@property (nonatomic, copy) NSString *thirdType;
/// 第三方id
@property (nonatomic, copy) NSString *thirdId;
/// 用户ID
@property (nonatomic, assign) NSInteger servId;
/// 用户账号
@property (nonatomic, copy) NSString *account;
/// 卡号ID集合，格式为以逗号为分割的ID字符串
@property (nonatomic, copy) NSString *cardNos;
/// 购买销售品数（可选）
@property (nonatomic, assign) NSInteger buyLength;
/// 所选优惠条目ID
@property (nonatomic, copy) NSString *discountItems;
/// 总金额，以分为单位（必选）
@property (nonatomic, assign) CGFloat totalCost;
/// 优惠金额，以分为单位（可选）
@property (nonatomic, assign) CGFloat preCost;
/// 其它金额，以分为单位（可选）
@property (nonatomic, assign) NSInteger otherCost;
/// 临时赠送量
@property (nonatomic, assign) NSInteger extraLength;
/// 缴费类型
@property (nonatomic, copy) NSString *balanceSourceType;
/// 是否立即开户
@property (nonatomic, copy) NSString *prompt;
/// 备注
@property (nonatomic, copy) NSString *remark;
/// 合同号
@property (nonatomic, copy) NSString *contractCode;
/// 票据号
@property (nonatomic, copy) NSString *voiceCode;

@end

@interface IBLCreateAccountInfo : NSObject

//开户类型，0-默认，1-用户自助，2-账号卡开户（可选）
@property(nonatomic, copy) NSString *type;
//账号卡卡号（可选）
@property(nonatomic, copy) NSString *cardNo;
//账号卡密码（可选）
@property(nonatomic, copy) NSString *cardPwd;
//性别（可选）
@property(nonatomic, copy) NSString *gender;
/**
 *  对象类型（可选）
 type -- 账号密码生成方式
 0-	默认
 1-	根据前缀定制
 2-	小区
 typeval—type如果为0，该值为空，账号密码则由系统自动生成；如果为1，则需要填入前缀值；如果为2，需要填入区域的id，前提是区域有相应的账号生成规则
 accountLen – 账号长度
 pwdLen – 密码长度
 */
@property(nonatomic, copy) NSString *genarate;
//用户账号（可选）
@property(nonatomic, copy) NSString *account;
//用户密码（可选）
@property(nonatomic, copy) NSString *password;
//用户姓名（根据配置）
@property(nonatomic, copy) NSString *userName;
//身份证号（根据配置）
@property(nonatomic, copy) NSString *idNo;
//电话号码，同时支持手机或者座机（必选）
@property(nonatomic, copy) NSString *phone;
//备用电话号码，同时支持手机或者座机（可选）
@property(nonatomic, copy) NSString *subPhone;
//联系地址（根据配置）
@property(nonatomic, copy) NSString *addr;
//生日（格式2010-01-01）（可选）
@property(nonatomic, copy) NSString *birthDate;
//Email（可选）
@property(nonatomic, copy) NSString *email;
//备注（可选）
@property(nonatomic, copy) NSString *remark;
//产品ID（可选）
@property(nonatomic, copy) NSString *productId;
//销售品ID（必选）
@property (nonatomic, copy) NSString *offerId;
//购买量（可选）
@property(nonatomic, assign) NSInteger buyLength;
//临时赠送量（可选）
@property(nonatomic, assign) NSInteger extraLength;
//生效方式：（必选）
//1-指定日期
//2-首次上线
//3-首次上线+最迟日期
@property(nonatomic, copy) NSString *effType;
//根据生效方式不同而不同，如果生效方式为指定日期，则该值为生效日期，并且生效日期不能在当前时间之前；如果生效方式为首次上线，则该值没有作用；如果生效方式为首次上线+最迟日期，则该值为最迟生效日期（可选）
@property(nonatomic, copy) NSString *effDate;
//所选优惠条目ID，格式为以逗号为分割的ID字符串，例如所选优惠条目的ID为14000111111111和14000111111112，那么传递参数应为” 14000111111111，14000111111112” （可选）
@property(nonatomic, copy) NSString *discountItems;
//支付金额，以分为单位（必选）totalCost = 销售品金额+其它金额-优惠金额
@property(nonatomic, assign) CGFloat totalCost;
//优惠金额，以分为单位（可选）
@property(nonatomic, assign) CGFloat preCost;

//其它金额，以分为单位（可选）
@property(nonatomic, assign) NSInteger otherCost;
//小区ID（必选）
@property(nonatomic, copy) NSString *nodeId;
//登录方式：（可选）
//1 – PPPOE
//2 –WEB
//默认为1
@property(nonatomic, copy) NSString *loginType;
//缴费方式（可选）
//5003000500  --人工收费
//5003000504  --套餐卡
//5003000505  --支付宝充值
//5003000506  --网银收入
//5003000510 – 微信
@property(nonatomic, copy) NSString *balanceType;
//是否立即开户，true
@property(nonatomic, copy) NSString *prompt;
//合同号
@property(nonatomic, copy) NSString *contractCode;
//票据号
@property(nonatomic, copy) NSString *voiceCode;

@property (nonatomic, assign) NSInteger custType;
@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *comAddr;

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

- (void)fetchOnlineWithAccount:(NSString *)account
                          date:(NSString *)date
                         start:(NSInteger)start
                      pageSize:(NSInteger)pageSize
               completeHandler:(void (^)(NSArray<IBLNetworkRecord *> *, NSError *))handler;

- (void)renewWithRenewParameters:(IBLRenewParameters *)renewParameters
                 completeHandler:(void (^)(NSString *obj, NSError *))handler;

- (void)exchangeProductWithParameters:(IBLExchangeProductParameters *)exchangeProductParameters
                      completeHandler:(void (^)(NSString *obj, NSError *))handler;

- (void)fetchOrderRelatedUserWithID:(NSString *)userID
                            account:(NSString *)account
                    completeHandler:(void (^)(IBLOrderRelateUser *, NSError *))handler;
@end
