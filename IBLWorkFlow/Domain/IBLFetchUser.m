//
//  IBLFetchUser.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFetchUser.h"
#import "IBLUserRepository.h"
#import "IBLAppRepository.h"

@implementation IBLFetchUser

- (void)setupLAN:(NSString *)LAN WLAN:(NSString *)WLAN{
    [IBLNetworkServices setLANURL:LAN];
    [IBLNetworkServices setWLANURL:WLAN];
}

- (NSError *)validateWithUsername:(NSString *)username
                         password:(NSString *)password{
    NSError *error = nil;
    
    if ([NSString isNull:username]) {
        NSString  *usernameNotNull = NSLocalizedStringFromTable(@"IBLFetchUser.usernameNotNull", @"Main", "not found");
        error = errorWithCode(0, usernameNotNull);
    }
    
    if ([NSString isNull:password]) {
        NSString  *passwordNotNull = NSLocalizedStringFromTable(@"IBLFetchUser.passwordNotNull", @"Main", "not found");

        error = errorWithCode(0, passwordNotNull);

    }
    
    return error;
}

- (IBLUser *)lastUser{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[PCCWFileManager patchForLoginedUser]];
}

- (void)saveLastUser:(IBLUser *)user{
    [PCCWFileManager removeItemAtPath:[PCCWFileManager patchForLoginedUser] error:nil];
    [NSKeyedArchiver archiveRootObject:user toFile:[PCCWFileManager patchForLoginedUser]];
}

- (void)startFetchWithUsername:(NSString *)username
                      password:(NSString *)password
               completeHandler:(void (^)(IBLUser *, NSError *))handler {
    IBLUserRepository *user = [[IBLUserRepository alloc] init];
    
    
    NSError *error = [self validateWithUsername:username password:password];
    
    if (error) { handler(nil, error); return; }
    
    NSString *URLString = IBLNetworkServices.LANURL == nil ?  IBLNetworkServices.WLANURL : IBLNetworkServices.LANURL;
    
    [IBLNetworkServices setupURLWithURLString:URLString
                              completeHandler:^{
                                  [user fetchWithUsername:username
                                                 password:password
                                          completeHandler:^(IBLUser *user, NSError *error) {
                                              
                                              if (error) {
                                                  handler(nil, error);
                                                  return;
                                              }
                                              
                                              IBLAppRepository *appRepository = [[IBLAppRepository alloc] init];
                                              [appRepository fetchWithConfigurationWithCompleteHandler:^(IBLAppConfiguration *configuration, NSError *error) {
                                                  [IBLUserRepository setUser:user];
                                                  user.account = username;
                                                  user.password = password;
                                                  [self saveLastUser:user];
                                                  handler(user, error);
                                              }];
                                          }];
                                  
                              }];
}

- (NSString *)lastLAN {
    return IBLNetworkServices.LANURL;
}

- (NSString *)lastWLAN {
    return IBLNetworkServices.WLANURL;
}
@end
