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

+ (IBLUser *)user;

+ (void)setUser:(IBLUser *)user;

- (void)fetchWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(void (^)(IBLUser *, NSError *))handler;

@end
