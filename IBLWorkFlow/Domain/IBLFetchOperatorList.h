//
//  IBLFetchOperatorList.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLSearchRepository.h"

@interface IBLFetchOperatorList : IBLUseCase

- (void)fetchOperatorsWithIsRefresh:(BOOL)isRefresh
                       operatorName:(NSString *)operatorName
                    completeHandler:(void (^)(NSArray<IBLOperator *>*, NSError *error))handler;

@end
