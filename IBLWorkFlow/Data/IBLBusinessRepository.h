//
//  IBLBusinessRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "IBLUser.h"

static NSString *const IBLWorkOrderInterface = @"WorkOrderInterface";

static NSString *const IBLWorkOrderSOAPFileName = @"WorkOrder";

static NSString *const IBLChannelSOAPFileName = @"ChannelInterface";

static NSString *const kStart = @"start";

static NSString *const kPageSize = @"pageSize";

@interface IBLBusinessRepository : IBLRepository

@property (nonatomic, readonly) IBLUser *user;

@end
