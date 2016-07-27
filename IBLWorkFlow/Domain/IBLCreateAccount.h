//
//  IBLCreateAccount.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/27/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"
#import "IBLUserListRepository.h"

@interface IBLCreateAccount : IBLUseCase

- (void)createAccountWithInfo:(IBLCreateAccountInfo *)createAccountInfo;

@end
