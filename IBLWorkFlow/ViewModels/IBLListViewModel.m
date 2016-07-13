//
//  IBLListViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"

@implementation IBLListViewModel
@dynamic dataSource;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSections{
    return [self.delegate.dataSource count];
}

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex{
    IBLSection *section = self.delegate.dataSource[sectionIndex];
    return [section.items count];
}

- (IBLSection *)sectionAt:(NSInteger)section{
    return self.delegate.dataSource[section];
}

- (IBLSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath{
    IBLSection *section = [self sectionAt:indexPath.section];
    return section.items[indexPath.row];
}

@end

@implementation IBLSection

+ (IBLSection *)sectionWithInfo:(id)info items:(NSMutableArray<IBLSectionItem *> *)items {
    return [[self alloc] initWithInfo:info items:items];
}

- (instancetype)initWithInfo:(id)info items:(NSMutableArray<IBLSectionItem *> *)items
{
    self = [super init];
    if (self) {
        self.info = info;
        self.items = items;
    }
    return self;
}

@end

@implementation IBLSectionItem

+ (IBLSectionItem *)itemWithInfo:(id)info selected:(BOOL)selected {
    return [[self alloc] initWithInfo:info selected:selected];
}

- (instancetype)initWithInfo:(id)info selected:(BOOL)selected
{
    self = [super init];
    if (self) {
        self.info = info;
        self.selected = selected;
    }
    return self;
}
@end