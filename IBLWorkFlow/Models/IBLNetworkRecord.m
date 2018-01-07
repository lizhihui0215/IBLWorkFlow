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
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"username" : @"USER_NAME",
                                                                  @"userIP" : @"FRAMED_IP",
                                                                  @"MACAddress" : @"MAC_ADDR",
                                                                  @"NASIP" : @"NAS_IP",
                                                                  @"scriptType" : @"SCRIPT_TYPE",
                                                                  @"errorCode" : @"ERROR_CODE",
                                                                  @"errorMessage" : @"ERROR_MSG",
                                                                  @"lastModifyDate" : @"LAST_MODIFY_TIMESTAMP",}];
}
@end
