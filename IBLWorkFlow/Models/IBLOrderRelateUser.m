//
//  IBLOrderRelateUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderRelateUser.h"

@implementation IBLOrderRelateUser
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"account" : @"ACCOUNT",
                                                                  @"password" : @"PASSWORD",
                                                                  @"userName" : @"USER_NAME",
                                                                  @"phone" : @"PHONE",
                                                                  @"email" : @"EMAIL",
                                                                  @"addr" : @"ADDR",
                                                                  @"idNo" : @"ID_NO",
                                                                  @"areaName" : @"AREA_NAME",
                                                                  @"bizStation" : @"BIZ_STATION",
                                                                  @"offerName" : @"OFFER_NAME",
                                                                  @"exfDate" : @"EFF_DATE",
                                                                  @"expDate" : @"EXP_DATE",
                                                                  @"offerId" : @"OFFER_ID",
                                                                  @"state" : @"STATE_NAME",
                                                                  @"remark" : @"REMARK",
                                                                  @"custType": @"CUST_TYPE",
                                                                  @"comName": @"COM_NAME",
                                                                  @"comContactPhone": @"COM_CONTACT_PHONE",
                                                                  @"comContact": @"COM_CONTACT",
                                                                  @"comAddr": @"COM_ADDR",
                                                                  @"certType": @"CERT_TYPE",
                                                                  @"simpleComName": @"SIMPLE_COM_NAME"
                                                                  }];
}

@end
