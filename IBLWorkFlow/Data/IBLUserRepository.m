//
//  IBLUserRepository.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserRepository.h"

@implementation IBLUserRepository

- (void)fetchWithCompleteHandler:(void (^)(IBLUser *, NSError *))handler {
    [self.networkServices POST:@""
                    parameters:nil
                      progress:nil
                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                           
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           
                       }];
}
@end
