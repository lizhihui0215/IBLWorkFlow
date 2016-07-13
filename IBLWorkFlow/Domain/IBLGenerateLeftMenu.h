//
//  IBLGenerateLeftMenu.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

@interface IBLLeftMenu : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, assign) NSInteger parentIndex;

@property (nonatomic, assign) NSInteger index;

+ (instancetype)menuWithTitle:(NSString *)title
                         icon:(UIImage *)icon
                  parentIndex:(NSInteger)parentIndex
                        index:(NSInteger)index;

- (NSComparisonResult)compare:(IBLLeftMenu *)menu;

@end

@interface IBLGenerateLeftMenu : IBLUseCase

- (NSArray *)menus;

- (NSString *)username;

- (NSString *)roleOfUser;

@end
