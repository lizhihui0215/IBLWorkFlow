//
//  IBLPayRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLPayResult.h"
#import "IBLOrderDetail.h"

/**
 *  支付状态
 */
typedef NS_ENUM(NSInteger, IBLOrderPayStatus) {
    IBLOrderPayStatusError,
    /**
     *  未支付
     */
    IBLOrderPayStatusUnpay,
    /**
     *  支付中
     */
    IBLOrderPayStatusPaying,
    /**
     *  已付款
     */
    IBLOrderPayStatusPayed,
    /**
     *  已完成
     */
    IBLOrderPayStatusFinished,
    /**
     *  已关闭
     */
    IBLOrderPayStatusClosed,
    /**
     *  支付失败
     */
    IBLOrderPayStatusFaild = 7,
};

@interface IBLQRPayInfo : NSObject

@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, strong) NSString *offerId;
@property (nonatomic, strong) NSString *offerName;
@property (nonatomic, strong) NSString *genarate;
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *idNo;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *subPhone;
@property (nonatomic, strong) NSString *addr;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) NSInteger buyLength;
@property (nonatomic, assign) NSInteger extraLength;
@property (nonatomic, assign) NSInteger totalLength;
@property (nonatomic, strong) NSString *discountItems;
@property (nonatomic, assign) CGFloat totalCost;
@property (nonatomic, assign) CGFloat payCost;
@property (nonatomic, strong) NSString *otherCost;
@property (nonatomic, strong) NSString *nodeId;

@property (nonatomic, assign) NSInteger custType;
@property (nonatomic, copy) NSString *comName;
@property (nonatomic, copy) NSString *comContact;
@property (nonatomic, copy) NSString *comContactPhone;
@property (nonatomic, copy) NSString *comAddr;




@end

@interface IBLPayRepository : IBLBusinessRepository

- (void)payWithQRPayInfo:(IBLQRPayInfo *)QRPayInfo
         completeHandler:(void (^)(IBLPayResult *, NSError *))handler;

- (NSURLSessionDataTask *)checkOrderWithNumber:(NSString *)orderNumber
                               completeHandler:(void (^)(IBLOrderPayStatus, NSError *))handler;

- (NSURLSessionDataTask *)fetchOrderDetailWithOrderNumber:(NSString *)orderNumber
                                          completeHandler:(void (^)(IBLOrderDetail *, NSError *))handler;

@end
