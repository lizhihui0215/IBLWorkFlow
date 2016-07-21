//
//  IBLCreateAccountViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountViewModel.h"
#import "IBLCreateAccountHiddenFields.h"

@interface IBLCreateAccountViewModel ()

@property (nonatomic, assign, readwrite) IBLCreateAccountType createAccountType;

@property (nonatomic, strong, readwrite) IBLOrder *order;

@property (nonatomic, strong) IBLCreateAccountHiddenFields *hiddenFields;

@end

@implementation IBLCreateAccountViewModel

- (NSMutableArray *)dataSource{
    return nil;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    
}

- (instancetype)initWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                    order:(IBLOrder *)order{
    self = [super init];
    if (self) {
        self.createAccountType = createAccountType;
        self.order = order;
        self.hiddenFields = [[IBLCreateAccountHiddenFields alloc] init];
    }

    return self;
}

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order{
    return [[self alloc] initWithCreateAccountType:createAccountType
                                             order:order];
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath {
    if([self.hiddenFields createAccountHiddenFieldsDictionary][indexPath]){
        return YES;
    }
    return NO;
}

@end
