//
//  IBLLoginViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"

@interface IBLLoginViewModel : IBLViewModel



- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
          completeHandler:(IBLViewModelCompleteHandler)handler;

- (NSString *)lastUsername;

- (NSString *)lastPassword;

- (void)setLAN:(NSString *)LAN;

- (void)setWLAN:(NSString *)WLAN;

- (NSString *)lastLAN;

- (NSString *)lastWLAN;
@end
