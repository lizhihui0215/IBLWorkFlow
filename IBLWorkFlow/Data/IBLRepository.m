//
//  IBLRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "UIDevice+IBLExtension.h"

/** 时间戳 */
static NSString * const kSessionID = @"sessionId";

/** 签名 */
static NSString * const kSign = @"sign";

/** 唯一标识 */
static NSString * const kMCode = @"mCode";

/** 服务器API认证ID */
static NSString * const kAuthID = @"authId";

static NSString * const AuthID = @"a05e74898131bd1c";

static NSString * const kSignKey = @"48e5be901c6692bf46fd2bba3b04d56b";

/** 登录后分配ID */
static NSString * const kAllocID = @"allocId";

@interface IBLRepository ()

@end

@implementation IBLRepository

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary * (^)(NSDictionary *))parameters{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    
    NSDictionary *dictionary = parameters(@{kSessionID : [@(interval) stringValue],
                                            kMCode : [UIDevice UUID],
                                            kAuthID : AuthID});
    NSMutableDictionary *signedParameters = [dictionary mutableCopy];
    
    [signedParameters addEntriesFromDictionary:@{kSign : [self siginWithParameters:dictionary]}];
    
    NSError *error = nil;
    
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:signedParameters options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *signedParametersString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    return @{@"arg0" : signedParametersString};
}

- (NSString *)siginWithParameters:(NSDictionary *)aParameters{
    
    NSMutableDictionary *parameters = [aParameters mutableCopy];
    
    [parameters removeObjectForKey:kSign];
    
    NSMutableArray *list = [NSMutableArray array];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull value, BOOL * _Nonnull stop) {
        if (![NSString isNull:value]) {
            NSString *formatted = [NSString stringWithFormat:@"%@=%@&",key,value];
            [list addObject:formatted];
        }
    }];
    
    [list sortUsingSelector:@selector(caseInsensitiveCompare:)];

    NSString *result = [list componentsJoinedByString:@""];
    
    result = [NSString stringWithFormat:@"%@key=%@",result,kSignKey];
    
    CocoaSecurityResult *securityResult = [CocoaSecurity md5:result];
    
    return securityResult.hex.uppercaseString;
}

- (IBLNetworkServices *)networkServices{
    return [IBLNetworkServices sharedServices];
}

@end
