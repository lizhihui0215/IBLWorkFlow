//
//  IBLPayRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLPayRepository.h"
#import "IBLAppRepository.h"
@implementation IBLQRPayInfo

@end

@interface IBLPayRepository ()

@property (nonatomic, strong) IBLSOAPMethod *QRPayMethod;

@property (nonatomic, strong) IBLSOAPMethod *checkOrderMethod;

@property (nonatomic, strong) IBLSOAPMethod *fetchOrderDetailMethod;

@end

@implementation IBLPayRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"PayInterface"];
    if (self) {
        self.QRPayMethod = [IBLSOAPMethod methodWithURLString:@"IBLPayInterface"
                                                     fileName:@"PayInterface"
                                            requestMethodName:@"qrPay"
                                           responseMethodName:@"qrPayResponse"];
        self.checkOrderMethod = [IBLSOAPMethod  methodWithURLString:@"IBLPayInterface"
                                                           fileName:@"PayInterface"
                                                  requestMethodName:@"checkOrder"
                                                 responseMethodName:@"checkOrderResponse"];
        self.fetchOrderDetailMethod = [IBLSOAPMethod  methodWithURLString:@"IBLPayInterface"
                                                                 fileName:@"PayInterface"
                                                        requestMethodName:@"getOrderInfo"
                                                       responseMethodName:@"getOrderInfoResponse"];
    }
    return self;
}

- (void)payWithQRPayInfo:(IBLQRPayInfo *)QRPayInfo
         completeHandler:(void (^)(IBLPayResult *, NSError *))handler {
    IBLAppConfiguration *appConfigration = [IBLAppRepository appConfiguration];
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"orderType"] = QRPayInfo.orderType;
        parameters[@"payType"] = QRPayInfo.payType;
        parameters[@"offerId"] = QRPayInfo.offerId;
        parameters[@"offerName"] = QRPayInfo.offerName;
        parameters[@"genarate"] = [appConfigration.genarate toJSONString];;
        parameters[@"account"] = QRPayInfo.account;
        parameters[@"password"] = QRPayInfo.password;
        parameters[@"userName"] = QRPayInfo.userName;
        parameters[@"gender"] = QRPayInfo.gender;
        parameters[@"idNo"] = QRPayInfo.idNo;
        parameters[@"phone"] = QRPayInfo.phone;
        parameters[@"subPhone"] = QRPayInfo.subPhone;
        parameters[@"addr"] = QRPayInfo.addr;
        parameters[@"birthDate"] = QRPayInfo.birthDate;
        parameters[@"email"] = QRPayInfo.email;
        parameters[@"remark"] = QRPayInfo.remark;
        parameters[@"buyLength"] = @(QRPayInfo.buyLength);
        parameters[@"extraLength"] = @(QRPayInfo.extraLength);
        parameters[@"totalLength"] = @(QRPayInfo.totalLength);
        parameters[@"discountItems"] = QRPayInfo.discountItems;
        parameters[@"totalCost"] = @(QRPayInfo.totalCost  * 100); // 总金额
        parameters[@"payCost"] = @(QRPayInfo.payCost * 100); // 支付金额 900
        parameters[@"otherCost"] = @([QRPayInfo.otherCost doubleValue] * 100); // 优惠金额 - 值
        parameters[@"nodeId"] = QRPayInfo.nodeId;
        parameters[@"custType"] = @(QRPayInfo.custType);
        parameters[@"comName"] = QRPayInfo.comName;
        parameters[@"comContact"] = QRPayInfo.comContact;
        parameters[@"comContactPhone"] = QRPayInfo.comContactPhone;
        parameters[@"comAddr"] = QRPayInfo.comAddr;
        parameters[@"simpleComName"] = QRPayInfo.simpleComName;
        parameters[@"certType"] = @(QRPayInfo.certType);

        return parameters;
    }];
    
     [[IBLNetworkServices networkServicesWithMethod:self.QRPayMethod] POST:parameters
                                                                 progress:nil
                                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                      IBLPayResult *result = [[IBLPayResult alloc] initWithDictionary:responseObject error:nil];
                                                                      handler(result, nil);
                                                                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                      handler(nil, error);
                                                                  }];
}

- (NSURLSessionDataTask *)checkOrderWithNumber:(NSString *)orderNumber
                        completeHandler:(void (^)(IBLOrderPayStatus, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"orderNo"] = orderNumber;
        return parameters;
    }];
    
    return [[IBLNetworkServices networkServicesWithMethod:self.checkOrderMethod] POST:parameters
                                                                        progress:nil
                                                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                  handler([responseObject[@"state"] integerValue], nil);
                                                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                  handler(IBLOrderPayStatusError, error);
                                                                              }];
}


- (NSURLSessionDataTask *)fetchOrderDetailWithOrderNumber:(NSString *)orderNumber
                                          completeHandler:(void (^)(IBLOrderDetail *, NSError *))handler{
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
        NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[@"orderNo"] = orderNumber;
        return parameters;
    }];
    return [[IBLNetworkServices networkServicesWithMethod:self.fetchOrderDetailMethod] POST:parameters
                                                                             progress:nil
                                                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                                        
                                                                                        IBLOrderDetail *orderDetail = [[IBLOrderDetail alloc] initWithDictionary:responseObject error:nil];
                                                                                        
                                                                                        handler(orderDetail, nil);
                                                                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                                        handler(IBLOrderPayStatusError, error);
                                                                                    }];
}

@end
