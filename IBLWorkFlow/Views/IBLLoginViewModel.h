//
//  IBLLoginViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWViewModel.h"

@interface IBLLoginViewModel : PCCWViewModel



- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(PCCWViewModelCompleteHandler)handler;

- (NSString *)lastUsername;

- (NSString *)lastPassword;

- (void)setLAN:(NSString *)LAN;

- (void)setWLAN:(NSString *)WLAN;

- (NSString *)lastLAN;

- (NSString *)lastWLAN;
@end
