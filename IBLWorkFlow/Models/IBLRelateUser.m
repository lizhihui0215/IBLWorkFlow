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
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"account" : @"ACCOUNT",
                                                                  @"address" : @"ADDR",
                                                                  @"areaName" : @"AREA_NAME",
                                                                  @"comments" : @"COMMENTS",
                                                                  @"createDateLabel" : @"CREATE_DATE",
                                                                  @"effDate" : @"EFF_DATE",
                                                                  @"expDate" : @"EXP_DATE",
                                                                  @"userIdentifier" : @"IDNO",
                                                                  @"areaIdentifier" : @"NODE_ID",
                                                                  @"offerIdentifier" : @"OFFER_ID",
                                                                  @"offerName" : @"OFFER_NAME",
                                                                  @"phone" : @"PHONE",
                                                                  @"servId" : @"SERV_ID",
                                                                  @"state" : @"STATE",
                                                                  @"username" : @"USER_NAME",
                                                                  @"custType" : @"CUST_TYPE",
                                                                  @"comName" : @"COM_NAME",
                                                                  @"simpleComName" : @"SIMPLE_COM_NAME",
                                                                  @"comContact" : @"COM_CONTACT",
                                                                  @"comContactPhone" : @"COM_CONTACT_PHONE",
                                                                  @"comAddr" : @"COM_ADDR",
                                                                  @"certType" : @"CERT_TYPE",}];
}

@end
