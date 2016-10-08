//
//  IBLFetchOrderRelatedUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUserListRepository.h"

@interface IBLFetchOrderRelatedUser : IBLUseCase

- (void)fetchOrderRelatedUserWithID:(NSString *)userID
                            account:(NSString *)account
                    completeHandler:(void (^)(IBLOrderRelateUser *, NSError *))handler;

@end
