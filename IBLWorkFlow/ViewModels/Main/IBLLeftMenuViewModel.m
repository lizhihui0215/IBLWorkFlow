//
//  IBLLeftMenuViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLeftMenuViewModel.h"


@interface IBLLeftMenuViewModel ()
{
    NSMutableArray *_dataSource;
}
@property (nonatomic, strong) IBLGenerateLeftMenu *generateLeftMenu;

@end

@implementation IBLLeftMenuViewModel

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
        self.generateLeftMenu = [[IBLGenerateLeftMenu alloc] init];
        [self setupMenus];
    }
    return self;
}

- (NSMutableArray<PCCWSectionItem *> *)sectionItemWithMenus:(NSArray<IBLLeftMenu *> *)menus{
    NSMutableArray *sectionItems = [NSMutableArray array];
    
    for (IBLLeftMenu *menu in menus) {
       [sectionItems addObject:[PCCWSectionItem itemWithInfo:menu selected:NO]];
    }
    
    return sectionItems;
}

- (void)setupMenus{
    NSArray *menus = [self.generateLeftMenu menus];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.parentIndex = %@",@(NSNotFound)];
    
    NSArray *firstMenus = [menus filteredArrayUsingPredicate:predicate];
    
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF.parentIndex = %@",@(IBLLeftMenuSectionActionBusinessManaged)];
    
    NSMutableArray<IBLLeftMenu *> *secondMenus = [[menus filteredArrayUsingPredicate:predicate1] mutableCopy];
    
    NSArray *orderedFirstMenus = [firstMenus sortedArrayUsingSelector:@selector(compare:)];

    for (IBLLeftMenu *menu in orderedFirstMenus) {
        PCCWSection *section = nil;
        if (menu.index == IBLLeftMenuSectionActionBusinessManaged) {
            section = [PCCWSection sectionWithInfo:menu items:[self sectionItemWithMenus:[secondMenus sortedArrayUsingSelector:@selector(compare:)]]];
        }else{
            section = [PCCWSection sectionWithInfo:menu items:nil];
        }
        [self.dataSource addObject:section];
    }
//    // 我的工单
//    PCCWSection *section = [PCCWSection sectionWithInfo:@"" items:[@[] mutableCopy]];
//
//    // 工单管理
//    PCCWSection *section1 = [PCCWSection sectionWithInfo:@"" items:[@[] mutableCopy]];
//
//    // 营业管理
//    PCCWSection *section1 = [PCCWSection sectionWithInfo:@"" items:[@[] mutableCopy]];
//
//        // 新增工单
//        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:@"" selected:NO];
//
//        // 开户
//        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:@"" selected:NO];
//
//        // 续费
//        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:@"" selected:NO];
//
//        // 换销售品
//        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:@"" selected:NO];
//
//       // 上网记录
//
//    // 关于我们
//    PCCWSection *section1 = [PCCWSection sectionWithInfo:@"" items:[@[] mutableCopy]];
//
//    // 退出登录
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    PCCWSectionItem *item = [self sectionItemAtIndexPath:indexPath];
    IBLLeftMenu *menu = item.info;
    return menu.title;
}

- (UIImage *)imageAtIndexPath:(NSIndexPath *)idnexPath {
        PCCWSectionItem *item = [self sectionItemAtIndexPath:idnexPath];
    IBLLeftMenu *menu = item.info;
    return menu.icon;
}

- (NSString *)username {
    return [self.generateLeftMenu username];
}

- (NSString *)roleOfUser {
    return [self.generateLeftMenu roleOfUser];
}


@end
