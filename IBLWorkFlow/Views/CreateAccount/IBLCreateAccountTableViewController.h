//
//  IBLCreateAccountTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@class IBLCreateAccountTableViewController;
@class IBLCreateAccountInfo;

@protocol IBLCreateAccountTableViewControllerDataSource <NSObject>

- (void)tableViewController:(IBLCreateAccountTableViewController *)controller
                     commit:(IBLCreateAccountInfo *)commit;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (IBLCreateAccountInfo *)createAccountInfoOfTableViewController:(IBLCreateAccountTableViewController *) controller;
@end

@interface IBLCreateAccountInfo : NSObject

/// 所属校区ID （报装工单特有）
@property (nonatomic, copy) NSString *residentialIdentifier;

/// 订购的销售品ID （报装工单特有）
@property (nonatomic, copy) NSString *productIdentifier;

/// 用户姓名 （报装工单特有）
@property (nonatomic, copy) NSString *username;

/// 小区名称 (报装工单特有)
@property (nonatomic, copy) NSString *regionName;

/// 销售品名称 (报装工单特有)
@property (nonatomic, copy) NSString *productName;

/// 身份证号 (报装工单特有)
@property (nonatomic, copy) NSString *identifierNumber;

/// 备注 (报装工单特有)
@property (nonatomic, copy) NSString *remark;

/// 生效方式 (报装工单特有)
@property (nonatomic, copy) NSString *effectType;

/// 生效日期 (报装工单特有)
@property (nonatomic, copy) NSString *effectDate;

/// 用户联系电话 (报装工单特有)
@property (nonatomic, copy) NSString *phone;

/// 用户联系地址 (报装工单特有)
@property (nonatomic, copy) NSString *address;

/// 是否标记处理 (报装工单特有)
@property (nonatomic, copy) NSString *handleMark;

/// 用户账号
@property (nonatomic, copy) NSString *account;

/// 密码
@property (nonatomic, copy) NSString *password;

/// 订购数量
@property (nonatomic, copy) NSString *count;

/// 销售品总额
@property (nonatomic, copy) NSString *sales;

/// 销售品总量
@property (nonatomic, copy) NSString *salesCount;

/// 合同号
@property (nonatomic, copy) NSString *contractNumebr;

/// 票据号
@property (nonatomic, copy) NSString *ticketNumber;

/// 优惠金额
@property (nonatomic, copy) NSString *give;

/// 临时赠送
@property (nonatomic, copy) NSString *discount;

/// 支付金额
@property (nonatomic, copy) NSString *pay;

+ (instancetype)infoWithResidentialIdentifier:(NSString *)residentialIdentifier
                            productIdentifier:(NSString *)productIdentifier
                                     username:(NSString *)username
                                   regionName:(NSString *)regionName
                                  productName:(NSString *)productName
                             identifierNumber:(NSString *)identifierNumber
                                       remark:(NSString *)remark
                                   effectType:(NSString *)effectType
                                   effectDate:(NSString *)effectDate
                                        phone:(NSString *)phone
                                      address:(NSString *)address
                                   handleMark:(NSString *)handleMark;


@end

@interface IBLCreateAccountTableViewController : UITableViewController

@property (nonatomic, weak) id<IBLCreateAccountTableViewControllerDataSource> tableViewDataSource;

@end
