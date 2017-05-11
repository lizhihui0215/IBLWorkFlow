//
//  IBLOrder.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrder.h"

@implementation IBLOrder

+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"ORDER_ID" : @"identifier",
                                                       @"ORDER_TITLE" : @"title",
                                                       @"ORDER_TYPE" : @"type",
                                                       @"BIZ_TYPE" : @"bizType",
                                                       @"ORDER_CONTENT" : @"content",
                                                       @"ORDER_STATUS" : @"status",
                                                       @"ORDER_PRIORITY" : @"priority",
                                                       @"NOTE" : @"note",
                                                       @"OP_SUGGEST" : @"suggest",
                                                       @"CREATE_TIME" : @"createTime",
                                                       @"EXPIRE_TIME" : @"expireTime",
                                                       @"LAST_MODIFY_TIMESTAMP" : @"lastModifyTime",
                                                       @"SERV_ID" : @"userIdentifier",
                                                       @"USER_ACCOUNT" : @"userAccount",
                                                       @"CREATE_OPER_NAME" : @"creatorName",
                                                       @"CREATE_OPER_PHONE" : @"creatorPhoneLabel",
                                                       @"NODE_ID" : @"residentialIdentifier",
                                                       @"OFFER_ID" : @"productIdentifier",
                                                       @"USER_NAME" : @"username",
                                                       @"NODE_NAME" : @"regionName",
                                                       @"OFFER_NAME" : @"productName",
                                                       @"IDNO" : @"identifierNumber",
                                                       @"REMARK" : @"remark",
                                                       @"EFF_TYPE": @"effectType",
                                                       @"EFF_DATE" : @"effectDate",
                                                       @"PHONE" : @"phone",
                                                       @"ADDR" : @"address",
                                                       @"HANDLE_MARK" : @"handleMark",
                                                       @"CUST_TYPE" : @"custType",
                                                       @"COM_NAME" : @"comName",
                                                       @"SIMPLE_COM_NAME" : @"sampleComName",
                                                       @"COM_CONTACT" : @"comContact",
                                                       @"COM_CONTACT_PHONE" : @"comContactPhone",
                                                       @"COM_ADDR" : @"comAddr",
                                                       @"CERT_TYPE" : @"certType"}];
}

@end
