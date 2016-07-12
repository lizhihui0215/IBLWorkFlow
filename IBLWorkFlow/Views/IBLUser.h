//
//  IBLUser.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"
#import "IBLPremission.h"

@protocol IBLPremission <NSObject>

@end

@interface IBLUser : IBLModel

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *roleName;

@property (nonatomic, copy) NSString *identifier;

@property (nonatomic, strong) NSArray<IBLPremission> *permissions;

@end
