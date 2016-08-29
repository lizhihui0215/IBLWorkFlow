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

@end

@implementation IBLPayRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:@"PayInterface"];
    if (self) {
        self.QRPayMethod = [IBLSOAPMethod methodWithRequestMethodName:@"qrPay"
                                                   responseMethodName:@"qrPayResponse"];
        
        self.checkOrderMethod = [IBLSOAPMethod methodWithRequestMethodName:@"checkOrder"
                                                        responseMethodName:@"checkOrderResponse"];
        
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
        parameters[@"buyLength"] = QRPayInfo.buyLength;
        parameters[@"extraLength"] = QRPayInfo.extraLength;
        parameters[@"totalLength"] = QRPayInfo.totalLength;
        parameters[@"discountItems"] = QRPayInfo.discountItems;
        parameters[@"totalCost"] = @([QRPayInfo.totalCost floatValue] * 100);
        parameters[@"payCost"] = @([QRPayInfo.payCost floatValue] * 100);
        parameters[@"otherCost"] = @([QRPayInfo.otherCost floatValue] * 100);
        parameters[@"nodeId"] = QRPayInfo.nodeId;
        return parameters;
    }];
    
    [[self networkServicesMethods:self.QRPayMethod] POST:@"IBLPayInterface"
                                              parameters:parameters
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
    
    return  [[self networkServicesMethods:self.checkOrderMethod] POST:@"IBLPayInterface"
                                                           parameters:parameters
                                                             progress:nil
                                                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                  handler([responseObject[@"state"] integerValue], nil);
                                                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                  handler(IBLOrderPayStatusError, error);
                                                              }];
    
}

@end
