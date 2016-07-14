//
//  IBLRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBLNetworkServices.h"


@interface IBLRepository : NSObject

@property (nonatomic, readonly) IBLNetworkServices *networkServices;

- (NSDictionary *)signedParametersWithPatameters:(NSDictionary * (^)(NSDictionary *))parameters;


@end
