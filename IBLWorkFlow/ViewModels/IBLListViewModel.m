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
        self.dataSource = [NSMutableArray array];
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

- (NSIndexPath *)indexPathOfItem:(id)item{
    
    NSIndexPath *indexPath = nil;
    
    IBLSectionItem *sectionItem = [IBLSectionItem itemWithInfo:item selected:NO];
    
    for (IBLSection *section in self.delegate.dataSource) {
        NSInteger index = [section.items indexOfObject:sectionItem];
        if(index != NSNotFound){
            NSInteger sectionIndex = [self.delegate.dataSource indexOfObject:section];
            indexPath = [NSIndexPath indexPathForRow:index inSection:sectionIndex];
            break;
        }
    }
    
    return indexPath;
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

- (BOOL)isEqual:(IBLSection *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.items) return [self.items isEqualToArray:object.items];
    
    //default isEqual implementation
    return [super isEqual:object];
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

- (BOOL)isEqual:(IBLSectionItem *)object{
    if (![object isMemberOfClass:[self class]]) return NO;
    
    if (self.info) return [self.info isEqual:object.info];
    
    //default isEqual implementation
    return [super isEqual:object];
}

@end