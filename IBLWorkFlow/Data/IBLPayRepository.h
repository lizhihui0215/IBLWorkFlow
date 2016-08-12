//
//  IBLPayRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/10/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"

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
@property (nonatomic, strong) NSString *buyLength;
@property (nonatomic, strong) NSString *extraLength;
@property (nonatomic, strong) NSString *totalLength;
@property (nonatomic, strong) NSString *discountItems;
@property (nonatomic, strong) NSString *totalCost;
@property (nonatomic, strong) NSString *payCost;
@property (nonatomic, strong) NSString *otherCost;
@property (nonatomic, strong) NSString *nodeId;

@end

@interface IBLPayRepository : IBLBusinessRepository

- (void)payWithQRPayInfo:(IBLQRPayInfo *)QRPayInfo
         completeHandler:(void (^)(NSString *, NSError *))handler;

@end
