//
//  IBLRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBLNetworkServices.h"

/** 唯一标识 */
static NSString * const kMCode = @"mCode";

/** 时间戳 */
static NSString * const kSessionID = @"sessionId";

@interface IBLFetchList : NSObject

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, assign) NSInteger pageSize;

- (instancetype)initWithStart:(NSInteger)start pageSize:(NSInteger)pageSize;

+ (instancetype)listWithStart:(NSInteger)start pageSize:(NSInteger)pageSize;


@end

@interface IBLRepository : PCCWRepository

@property (nonatomic, readonly, strong) NSString *SOAPFileName;

- (instancetype)initWithSOAPFileName:(NSString *)SOAPFileName;

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary * (^)(NSDictionary *))parameters;

@end
