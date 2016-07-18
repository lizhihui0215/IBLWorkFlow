//
//  IBLBusinessRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLUserRepository.h"

/** 登录后分配ID */
static NSString * const kAllocID = @"allocId";

@interface IBLBusinessRepository ()

@end

@implementation IBLBusinessRepository

- (IBLUser *)user{
    return [IBLUserRepository user];
}

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary *(^)(NSDictionary *))aParameters{
    return [super signedParametersWithPatameters:^(NSDictionary *parameters){
        NSMutableDictionary *allocIdParameters = [aParameters(parameters) mutableCopy];
        
        [allocIdParameters addEntriesFromDictionary:@{kAllocID : self.user.identifier}];
        return allocIdParameters;
    }];
}

@end
