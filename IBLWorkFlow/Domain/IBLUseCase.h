//
//  IBLUseCase.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IBLUseCaseProtocol <NSObject>

@optional
- (BOOL)validateWithHandler:(void (^)(NSError *error))handler;

@end

@interface IBLUseCase : PCCWDomain<IBLUseCaseProtocol>

@end
