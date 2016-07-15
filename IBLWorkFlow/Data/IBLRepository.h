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

@interface IBLSOAPMethod : NSObject
@property (nonatomic, copy) NSString *requestMethodName;

@property (nonatomic, copy) NSString *responseMethodName;

- (instancetype)initWithRequestMethodName:(NSString *)requestMethodName responseMethodName:(NSString *)responseMethodName;

+ (instancetype)methodWithRequestMethodName:(NSString *)requestMethodName responseMethodName:(NSString *)responseMethodName;

@end

@interface IBLRepository : NSObject

@property (nonatomic, readonly, strong) NSString *SOAPFileName;

- (instancetype)initWithSOAPFileName:(NSString *)SOAPFileName;


- (IBLNetworkServices *)networkServicesMethods:(IBLSOAPMethod *)SOAPmethod;

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary * (^)(NSDictionary *))parameters;


@end
