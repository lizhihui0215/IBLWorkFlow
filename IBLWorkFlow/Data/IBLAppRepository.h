//
//  IBLAppRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "IBLAppConfiguration.h"

@interface IBLAppRepository : IBLRepository

+ (IBLAppConfiguration *)appConfiguration;

+ (void)setAppConfiguration:(IBLAppConfiguration *)appConfiguration;

- (void)fetchWithConfigurationWithCompleteHandler:(void (^)(IBLAppConfiguration *, NSError *))handler;

@end
