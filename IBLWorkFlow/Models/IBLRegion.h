//
//  IBLRegion.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLRegion : IBLModel

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger identifier;

@property (nonatomic, assign) NSInteger parentIdentifier;

@property (nonatomic, assign) NSInteger type;

@end
