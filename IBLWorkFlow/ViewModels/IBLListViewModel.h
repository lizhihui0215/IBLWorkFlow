//
//  IBLListViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/13/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"

@class IBLSectionItem;

@protocol IBLListViewModelProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@interface IBLSection : NSObject

@property (nonatomic, strong) id info;

@property (nonatomic, strong) NSMutableArray<IBLSectionItem *> *items;

+ (IBLSection *)sectionWithInfo:(id)info items:(NSMutableArray<IBLSectionItem *> *)items;
@end

@interface IBLSectionItem : NSObject

@property (nonatomic, strong) id info;

@property (nonatomic, assign, getter=isSelected) BOOL selected;

+ (IBLSectionItem *)itemWithInfo:(id)info selected:(BOOL)selected;
@end

@interface IBLListViewModel : IBLViewModel<IBLListViewModelProtocol>

@property (nonatomic, weak) id<IBLListViewModelProtocol> delegate;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsInSection:(NSInteger)sectionIndex;

- (IBLSection *)sectionAt:(NSInteger)section;

- (IBLSectionItem *)sectionItemAtIndexPath:(NSIndexPath *)indexPath;
@end
