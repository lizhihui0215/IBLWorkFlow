//
//  IBLGenerateLeftMenu.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUseCase.h"

/**
 *  TableViewHeader Actions
 */
typedef NS_ENUM(NSInteger, IBLLeftMenuSectionAction) {
    /**
     *  我的工单
     */
    IBLLeftMenuSectionActionMineOrder = 1,
    /**
     *  工单管理
     */
    IBLLeftMenuSectionActionManagedOrder,
    /**
     *  营业管理
     */
    IBLLeftMenuSectionActionBusinessManaged,
    /**
     *  关于我们
     */
    IBLLeftMenuSectionActionAbout
};

/**
 *  TableViewCell Actions
 */
typedef NS_ENUM(NSInteger, IBLLeftMenuItemAction) {
    /**
     *  新增工单
     */
    IBLLeftMenuItemActionAddOrder = 101,
    /**
     *  开户
     */
    IBLLeftMenuItemActionAddCreateAccount,
    /**
     *  续费
     */
    IBLLeftMenuItemActionAddRenew,
    /**
     *  换销售品
     */
    IBLLeftMenuItemActionAddChangeProduct,
};

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
