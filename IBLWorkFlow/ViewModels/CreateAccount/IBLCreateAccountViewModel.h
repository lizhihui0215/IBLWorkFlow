//
//  IBLCreateAccountViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLOrder.h"

typedef NS_ENUM(NSInteger, IBLCreateAccountType) {
    IBLCreateAccountTypeFromOrder,
    IBLCreateAccountTypeFromLeftMenu,
};

@interface IBLCreateAccountViewModel : IBLListViewModel

@property (nonatomic, assign, readonly) IBLCreateAccountType createAccountType;
@property (nonatomic, strong, readonly) IBLOrder *order;

+ (instancetype)modelWithCreateAccountType:(IBLCreateAccountType)createAccountType
                                     order:(IBLOrder *)order;

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath;
@end
