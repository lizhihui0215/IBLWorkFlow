//
//  IBLLeftMenuViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLGenerateLeftMenu.h"



@interface IBLLeftMenuViewModel : IBLListViewModel

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)imageAtIndexPath:(NSIndexPath *)idnexPath;

- (NSString *)username;

- (NSString *)roleOfUser;
@end
