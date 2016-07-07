//
//  IBLUserRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "IBLUser.h"

@interface IBLUserRepository : IBLRepository

- (void)fetchWithCompleteHandler:(void (^)(IBLUser *, NSError *))handler;
@end
