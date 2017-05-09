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
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ACCOUNT" : @"account",
                                                       @"PASSWORD" : @"password",
                                                       @"USER_NAME" : @"userName",
                                                       @"PHONE" : @"phone",
                                                       @"EMAIL" : @"email",
                                                       @"ADDR" : @"addr",
                                                       @"ID_NO" : @"idNo",
                                                       @"AREA_NAME" : @"areaName",
                                                       @"BIZ_STATION" : @"bizStation",
                                                       @"OFFER_NAME" : @"offerName",
                                                       @"EFF_DATE" : @"exfDate",
                                                       @"EXP_DATE" : @"expDate",
                                                       @"OFFER_ID" : @"offerId",
                                                       @"STATE_NAME" : @"state",
                                                       @"REMARK" : @"remark",
                                                       @"CUST_TYPE": @"custType",
                                                       @"COM_NAME": @"comName",
                                                       @"COM_CONTACT_PHONE": @"comContactPhone",
                                                       @"COM_CONTACT": @"comContact",
                                                       @"COM_ADDR": @"comAddr",
                                                       @"CERT_TYPE": @"certType",
                                                       @"SIMPLE_COM_NAME": @"sampleComName"
                                                       }];
}

@end
