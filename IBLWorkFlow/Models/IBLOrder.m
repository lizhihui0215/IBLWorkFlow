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
                                                       @"op_suggest" : @"suggest",
                                                       @"CREATE_TIME" : @"createTime",
                                                       @"EXPIRE_TIME" : @"expireTime",
                                                       @"LAST_MODIFY_TIMESTAMP" : @"lastModifyTime",
                                                       @"SERV_ID" : @"userIdentifier",
                                                       @"USER_ACCOUNT" : @"userAccount",
                                                       @"CREATE_OPER_NAME" : @"creatorName",
                                                       @"CREATE_OPER_PHONE" : @"creatorPhone",
                                                       @"NODE_ID" : @"residentialIdentifier",
                                                       @"OFFER_ID" : @"productIdentifier",
                                                       @"USER_NAME" : @"username"}];
}

@end
