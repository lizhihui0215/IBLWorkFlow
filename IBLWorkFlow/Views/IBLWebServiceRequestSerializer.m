//
//  IBLWebServiceRequestSerializer.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWebServiceRequestSerializer.h"

@interface IBLWebServiceRequestSerializer ()

@property (nonatomic, copy) NSString *fileName;

@end

@implementation IBLWebServiceRequestSerializer
+ (instancetype)serializerWithWritingOptions:(NSString *)fileName{
    
    IBLWebServiceRequestSerializer * a = [[IBLWebServiceRequestSerializer alloc] initFileName:fileName];
    
    
    return a;
    
}

- (instancetype)initFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
