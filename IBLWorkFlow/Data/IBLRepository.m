//
//  IBLRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "UIDevice+IBLExtension.h"


/** 签名 */
static NSString * const kSign = @"sign";

/** 服务器API认证ID */
static NSString * const kAuthID = @"authId";

static NSString * const AuthID = @"a05e74898131bd1c";

static NSString * const kSignKey = @"48e5be901c6692bf46fd2bba3b04d56b";



@interface IBLRepository ()

@property (nonatomic, strong) NSString *SOAPFileName;

@end

@implementation IBLFetchList

- (instancetype)initWithStart:(NSInteger)start pageSize:(NSInteger)pageSize {
    self = [super init];
    if (self) {
        self.start = start;
        self.pageSize = pageSize;
    }

    return self;
}

+ (instancetype)listWithStart:(NSInteger)start pageSize:(NSInteger)pageSize {
    return [[self alloc] initWithStart:start pageSize:pageSize];
}


@end

@implementation IBLSOAPMethod
- (instancetype)initWithRequestMethodName:(NSString *)requestMethodName responseMethodName:(NSString *)responseMethodName {
    self = [super init];
    if (self) {
        self.requestMethodName = requestMethodName;
        self.responseMethodName = responseMethodName;
    }

    return self;
}

+ (instancetype)methodWithRequestMethodName:(NSString *)requestMethodName responseMethodName:(NSString *)responseMethodName {
    return [[self alloc] initWithRequestMethodName:requestMethodName responseMethodName:responseMethodName];
}


@end

@implementation IBLRepository

- (instancetype)initWithSOAPFileName:(NSString *)SOAPFileName {
    self = [super init];
    if (self) {
        self.SOAPFileName = SOAPFileName;
    }

    return self;
}

- (IBLNetworkServices *)networkServicesMethods:(IBLSOAPMethod *)SOAPmethod{
    return [self networkServicesWithFileName:self.SOAPFileName
                           requestMethodName:SOAPmethod.requestMethodName
                          responseMethodName:SOAPmethod.responseMethodName];
}

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary * (^)(NSDictionary *))parameters{
    
    NSDictionary *dictionary = parameters(@{kSessionID : @(time(NULL)),
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
    
    NSLog(@"------------\n%@\n----------------",result);
    
    CocoaSecurityResult *securityResult = [CocoaSecurity md5:result];
    
    return securityResult.hex.uppercaseString;
}



- (IBLNetworkServices *)networkServicesWithFileName:(NSString *)fileName
                                  requestMethodName:(NSString *)requestMethodName
                                 responseMethodName:(NSString *)responseMethodName{
    return [IBLNetworkServices networkServicesWithFileName:fileName
                                         requestMethodName:requestMethodName
                                        responseMethodName:responseMethodName];
}

@end
