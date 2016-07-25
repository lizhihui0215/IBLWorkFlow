//
//  IBLFetchUserList.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUserListRepository.h"

@interface IBLFetchUserList : IBLUseCase

- (void)fetchUserListWithIsRefresh:(BOOL)refresh
                       fetchResult:(IBLFetchUserListInfo *)result
                   completeHandler:(void (^)(NSArray<IBLRelateUser *> *, NSError *))handler;
@end
