//
//  IBLLeftMenuViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import "IBLGenerateLeftMenu.h"



@interface IBLLeftMenuViewModel : PCCWListViewModel

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)imageAtIndexPath:(NSIndexPath *)idnexPath;

- (UIViewController *)defaultBusinessManagedController;

- (NSString *)username;

- (NSString *)roleOfUser;
@end
