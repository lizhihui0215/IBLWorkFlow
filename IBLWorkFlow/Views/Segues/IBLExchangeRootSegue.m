//
//  IBLExchangeRootSegue.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLExchangeRootSegue.h"
#import "IBLAppDelegate.h"

@implementation IBLExchangeRootSegue

- (void)perform{
    [IBLAppDelegate sharedDelegate].window.rootViewController = self.destinationViewController;
}

@end
