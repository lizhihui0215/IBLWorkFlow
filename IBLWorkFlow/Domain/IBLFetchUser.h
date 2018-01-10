//
//  IBLFetchUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUser.h"

@interface IBLFetchUser : IBLUseCase

- (void)setupLAN:(NSString *)LAN WLAN:(NSString *)WLAN;

- (NSError *)validateWithUsername:(NSString *)username
                         password:(NSString *)password;

- (void)startFetchWithUsername:(NSString *)username
                      password:(NSString *)password
               completeHandler:(void (^)(IBLUser *, NSError *))handler;

- (IBLUser *)lastUser;

- (NSString *)lastLAN;

- (NSString *)lastWLAN;
@end
