//
//  IBLSearchRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchRepository.h"

static NSString *const IBLMethodOfFetchOperatorList = @"getOperList";

static NSString *const IBLMethodOfFetchOperatorListReponse = @"getOperListResponse";


static NSString *const kOperatorName = @"operName";

@interface IBLSearchRepository ()

@property (nonatomic, strong) IBLSOAPMethod *fetchOperator;


@end

@implementation IBLSearchRepository

- (instancetype)init
{
    self = [super initWithSOAPFileName:IBLWorkOrderSOAPFileName];
    if (self) {
        self.fetchOperator = [IBLSOAPMethod methodWithURLString:IBLWorkOrderInterface
                                                       fileName:IBLWorkOrderSOAPFileName
                                              requestMethodName:IBLMethodOfFetchOperatorList
                                             responseMethodName:IBLMethodOfFetchOperatorListReponse];
    }
    return self;
}

- (void)fetchOperatorsWithOperatorName:(NSString *)operatorName
                       completeHandler:(void (^)(NSArray<IBLOperator *>*, NSError *))handler{
    
    NSDictionary *parameters = [self signedParametersWithPatameters:^NSDictionary *(NSDictionary *aParameters) {
       NSMutableDictionary *parameters = [aParameters mutableCopy];
        parameters[kOperatorName] = operatorName;
        return parameters;
    }];
    
    [[IBLNetworkServices networkServicesWithMethod:self.fetchOperator] POST:parameters
                                                                   progress:nil
                                                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                                        NSArray<NSDictionary *> *operatorListDictionarys = responseObject[@"operList"];
                                                                        
                                                                        NSMutableArray<IBLOperator *> *operators = [NSMutableArray array];
                                                                        
                                                                        for (NSDictionary *operatorDictionary in operatorListDictionarys) {
                                                                            IBLOperator *operator = [[IBLOperator alloc] initWithDictionary:operatorDictionary error:nil];
                                                                            [operators addObject:operator];
                                                                        }
                                                                        
                                                                        handler(operators, nil);
                                                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                                        handler(nil, error);
                                                                    }];
}


@end
