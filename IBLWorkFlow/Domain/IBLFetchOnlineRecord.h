//
//  IBLFetchOnlineRecord.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUserListRepository.h"

@interface IBLFetchOnlineRecord : IBLUseCase

- (void)fetchOnlineWithAccount:(NSString *)account
                          date:(NSString *)date
                     isRefresh:(BOOL)isRefresh
               completeHandler:(void (^)(NSArray<IBLNetworkRecord *> *, NSError *))handler;

@end
