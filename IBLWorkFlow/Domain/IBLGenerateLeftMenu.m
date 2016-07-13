//
//  IBLGenerateLeftMenu.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLGenerateLeftMenu.h"
#import "IBLUserRepository.h"

static NSString const * kCreaetAccount = @"OPEN_USER";

static NSString const * kMineWorkOrder = @"MY_WORK_ORDER";

static NSString const * kMineWorkOrderManage = @"WORK_ORDER_MANAGE";

static NSString const * kAddOrder = @"ADD_ORDER";

static NSString const * kChangeProduct = @"CHANGE";

static NSString const * kRenew = @"RENEW";
//
//static NSString const * kMineWorkOrderManage = @"WORK_ORDER_MANAGE";

@implementation IBLGenerateLeftMenu

- (NSString *)username{
    IBLUser *user = [IBLUserRepository user];
    return user.userName;
}

- (NSString *)roleOfUser{
    IBLUser *user = [IBLUserRepository user];
    return user.roleName;
}

- (NSArray *)menus{
    NSMutableArray *menus = [NSMutableArray array];
    
    IBLUser *user = [IBLUserRepository user];
    
    for (IBLPremission *premission in user.permissions) {
        IBLLeftMenu *menu = [self menuMaps][premission.key];
        if (!menu) continue;
        [menus addObject:menu];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.parentIndex = %@",@(2)];
    
    NSArray *secondLevel = [menus filteredArrayUsingPredicate:predicate];
    
    if (secondLevel.count > 0) {
        IBLLeftMenu *menu = [IBLLeftMenu menuWithTitle:@"营业管理"
                                                   icon:[UIImage imageNamed:@"Icon"]
                                            parentIndex:NSNotFound
                                                  index:2];
        [menus addObject:menu];
    }
    
    IBLLeftMenu *about = [IBLLeftMenu menuWithTitle:@"关于我们"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:NSNotFound
                                              index:4];
    [menus addObject:about];
    
    return menus;
}

- (NSDictionary *)menuMaps{
    
    IBLLeftMenu *menu1 = [IBLLeftMenu menuWithTitle:@"我的工单"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:NSNotFound
                                              index:0];
    
    IBLLeftMenu *menu2 = [IBLLeftMenu menuWithTitle:@"工单管理"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:NSNotFound
                                              index:1];
    
    IBLLeftMenu *menu3 = [IBLLeftMenu menuWithTitle:@"新增工单"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:2
                                              index:0];
    
    IBLLeftMenu *menu4 = [IBLLeftMenu menuWithTitle:@"开户"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:2
                                              index:1];
    
    
    IBLLeftMenu *menu5 = [IBLLeftMenu menuWithTitle:@"续费"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:2
                                              index:2];
    
    IBLLeftMenu *menu6 = [IBLLeftMenu menuWithTitle:@"换销售品"
                                               icon:[UIImage imageNamed:@"Icon"]
                                        parentIndex:2
                                              index:3];
    
    return @{kMineWorkOrder : menu1,
             kMineWorkOrderManage : menu2,
             kAddOrder : menu3,
             kCreaetAccount : menu4,
             kRenew : menu5,
             kChangeProduct : menu6};
}

@end

@implementation IBLLeftMenu

- (NSComparisonResult)compare:(IBLLeftMenu *)menu{
    if (self.index == menu.index) return NSOrderedSame;
    
    if (self.index < menu.index) return NSOrderedAscending; else return NSOrderedDescending;
}


- (instancetype)initWithTitle:(NSString *)title icon:(UIImage *)icon parentIndex:(NSInteger)parentIndex index:(NSInteger)index {
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
        self.parentIndex = parentIndex;
        self.index = index;
    }

    return self;
}

+ (instancetype)menuWithTitle:(NSString *)title icon:(UIImage *)icon parentIndex:(NSInteger)parentIndex index:(NSInteger)index {
    return [[self alloc] initWithTitle:title icon:icon parentIndex:parentIndex index:index];
}


@end
