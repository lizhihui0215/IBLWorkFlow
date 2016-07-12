//
//  IBLException.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const kExceptionCode;

FOUNDATION_EXPORT NSString * const kExceptionMessage;

@interface IBLException : NSObject

+ (instancetype)exceptionWithHandler:(UIViewController *)handler;

- (BOOL)handleExceptionWithError:(NSError *)error;

- (BOOL)handleExceptionWithError:(NSError *)error
                 completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler;

@end
