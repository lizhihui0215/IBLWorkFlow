//
//  IBLNetworkRecord.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLNetworkRecord.h"

@implementation IBLNetworkRecord
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"USER_NAME" : @"username",
                                                       @"FRAMED_IP" : @"userIP",
                                                       @"MAC_ADDR" : @"MACAddress",
                                                       @"NAS_IP" : @"NASIP",
                                                       @"SCRIPT_TYPE" : @"scriptType",
                                                       @"ERROR_CODE" : @"errorCode",
                                                       @"ERROR_MSG" : @"errorMessage",
                                                       @"LAST_MODIFY_TIMESTAMP" : @"lastModifyDate",}];
}
@end
