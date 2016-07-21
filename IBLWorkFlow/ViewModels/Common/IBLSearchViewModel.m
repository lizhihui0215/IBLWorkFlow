//
//  IBLSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchViewModel.h"

@interface IBLSearchViewModel ()
{
    NSMutableArray *_dataSource;
}
@end

@implementation IBLSearchViewModel

- (NSMutableArray *)dataSource{
    return _dataSource;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

@end
