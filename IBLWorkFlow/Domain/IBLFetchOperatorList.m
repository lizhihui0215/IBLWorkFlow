//
//  IBLFetchOperatorList.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchOperatorList.h"

@interface IBLFetchOperatorList ()

@property (nonatomic, assign) NSInteger start;

@property (nonatomic, strong) IBLSearchRepository *searchRepository;

@end

@implementation IBLFetchOperatorList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.searchRepository = [[IBLSearchRepository alloc] init];
    }
    return self;
}

- (void)fetchOperatorsWithIsRefresh:(BOOL)isRefresh
                       operatorName:(NSString *)operatorName
                    completeHandler:(void (^)(NSArray<IBLOperator *>*, NSError *error))handler{
    if ([NSString isNull:operatorName]) operatorName = @"";
    
    __block NSInteger start = self.start;
    
    if (isRefresh) start = 0; else start += 1;
    
    [self.searchRepository fetchOperatorsWithOperatorName:operatorName
                                          completeHandler:^(NSArray<IBLOperator *> *operators, NSError *error) {
                                              if (!error) self.start = start;
                                              handler(operators, error);
                                          }];
}

@end
