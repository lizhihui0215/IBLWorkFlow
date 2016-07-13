//
//  IBLBusinessRepository.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLRepository.h"
#import "IBLUser.h"

@interface IBLBusinessRepository : IBLRepository

@property (nonatomic, readonly) IBLUser *user;

@end
