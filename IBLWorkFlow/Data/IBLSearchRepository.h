//
//  IBLSearchRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLBusinessRepository.h"
#import "IBLOperator.h"

@interface IBLSearchRepository : IBLBusinessRepository

- (void)fetchOperatorsWithOperatorName:(NSString *)operatorName
                       completeHandler:(void (^)(NSArray<IBLOperator *>*, NSError *))handler;
@end
