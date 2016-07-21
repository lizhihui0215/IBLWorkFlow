//
//  IBLCreateAccountHiddenFields.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@interface IBLCreateAccountHiddenFields : IBLUseCase
@property (nonatomic, strong) NSDictionary<NSIndexPath *, NSString *> *createAccountHiddenFieldsDictionary;

@end
