//
//  IBLRelateUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRelateUser.h"

@implementation IBLRelateUser
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ACCOUNT" : @"account",
                                                       @"ADDR" : @"address",
                                                       @"AREA_NAME" : @"areaName",
                                                       @"COMMENTS" : @"comments",
                                                       @"CREATE_DATE" : @"createDateLabel",
                                                       @"EFF_DATE" : @"effDate",
                                                       @"EXP_DATE" : @"expDate",
                                                       @"IDNO" : @"userIdentifier",
                                                       @"NODE_ID" : @"areaIdentifier",
                                                       @"OFFER_ID" : @"offerIdentifier",
                                                       @"OFFER_NAME" : @"offerName",
                                                       @"PHONE" : @"phone",
                                                       @"SERV_ID" : @"servId",
                                                       @"STATE" : @"state",
                                                       @"USER_NAME" : @"username",
                                                       @"CUST_TYPE" : @"custType",
                                                       @"SIMPLE_COM_NAME" : @"sampleComName",
                                                       @"COM_CONTACT" : @"comContact",
                                                       @"COM_CONTACT_PHONE" : @"comContactPhone",
                                                       @"COM_ADDR" : @"comAddr",
                                                       @"CERT_TYPE" : @"certType",}];
}

@end
