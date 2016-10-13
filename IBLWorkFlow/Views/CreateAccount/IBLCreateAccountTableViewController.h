//
//  IBLCreateAccountTableViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "IBLOrder.h"
#import "IBLProductPrice.h"
#import "IBLStaticTableViewController.h"

@class IBLCreateAccountTableViewController;
@class IBLCreateAccountTableViewInfo;

/**
 *  销售品金额输入类型
 */
typedef NS_ENUM(NSInteger, IBLCreateAccountTextFieldType) {
    /**
     *  支付金额
     */
    IBLCreateAccountTextFieldTypePay,
    /**
     *  优惠金额
     */
    IBLCreateAccountTextFieldTypeDiscount,
    /**
     *  销售品总金额
     */
    IBLCreateAccountTextFieldTypeAmmount,
};

@protocol IBLCreateAccountTableViewControllerDataSource <NSObject>

- (void)tableViewController:(IBLCreateAccountTableViewController *)controller
                     commit:(IBLCreateAccountTableViewInfo *)commit;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;

- (IBLCreateAccountType)createAccountTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller;

@optional
- (IBLCreateAccountTableViewInfo *)createAccountInfoOfTableViewController:(IBLCreateAccountTableViewController *) controller;

- (IBLOrderEffectType)defaultEffectTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller;

- (NSString *)defaultEffectDateOfTableViewController:(IBLCreateAccountTableViewController *)controller;

- (void)productPriceOfTableViewController:(IBLCreateAccountTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler;

- (NSDictionary<NSIndexPath *, NSString *> *)notNullFieldsDictionary;
@end

@interface IBLCreateAccountTableViewInfo : NSObject

/// 小区ID （报装工单特有）
@property (nonatomic, assign) NSInteger residentialIdentifier;

/// 订购的销售品ID （报装工单特有）
@property (nonatomic, assign) NSInteger productIdentifier;

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
@property (nonatomic, assign) IBLOrderEffectType effectType;

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
@property (nonatomic, assign) NSInteger count;

/// 销售品总额
@property (nonatomic, assign) CGFloat sales;

/// 销售品总量
@property (nonatomic, assign) NSInteger salesCount;

/// 合同号
@property (nonatomic, copy) NSString *contractNumebr;

/// 票据号
@property (nonatomic, copy) NSString *ticketNumber;

/// 优惠金额
@property (nonatomic, assign) CGFloat give;

/// 临时赠送
@property (nonatomic, assign) CGFloat discount;

/// 支付金额
@property (nonatomic, assign) CGFloat pay;

+ (instancetype)infoWithResidentialIdentifier:(NSInteger)residentialIdentifier
                            productIdentifier:(NSInteger)productIdentifier
                                     username:(NSString *)username
                                   regionName:(NSString *)regionName
                                  productName:(NSString *)productName
                             identifierNumber:(NSString *)identifierNumber
                                       remark:(NSString *)remark
                                   effectType:(IBLOrderEffectType)effectType
                                   effectDate:(NSString *)effectDate
                                        phone:(NSString *)phone
                                      address:(NSString *)address
                                   handleMark:(NSString *)handleMark;


@end

@interface IBLCreateAccountTableViewController : IBLStaticTableViewController

@property (nonatomic, weak) id<IBLCreateAccountTableViewControllerDataSource> tableViewDataSource;

@property (nonatomic, strong, readonly) IBLCreateAccountTableViewInfo *createAccountInfo;

@end
