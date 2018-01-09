//
//  IBLOperatorSearchViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOperatorSearchViewModel.h"

@interface IBLOperatorSearchViewModel ()

@property (nonatomic, strong) IBLFetchOperatorList *fetchOperator;

@property (nonatomic, strong, readwrite) IBLOrder *order;

@end

@implementation IBLOperatorSearchViewModel

- (instancetype)initWithWorkOrder:(IBLOrder *)order searchType:(IBLSearchType)searchType {
    self = [super init];
    if (self) {
        
        self.searchType = searchType;
        
        self.order = order;
        
        self.fetchOperator = [[IBLFetchOperatorList alloc] init];
        
        PCCWSection *section = [PCCWSection sectionWithInfo:nil items:nil];
        
        [self.dataSource addObject:section];
    }
    return self;
}

- (NSString *)title{
    
    NSString  *title = NSLocalizedStringFromTable(@"IBLOperatorSearchViewModel.title", @"Main", "not found");

    return title;
}

+ (instancetype)operatorSearchModelWithOrder:(IBLOrder *)order searchType:(IBLSearchType)searchType {
    return [[self alloc] initWithWorkOrder:order searchType:searchType];
}

- (void)fetchSearchContentWithSearchInfo:(id)searchInfo
                               isRefresh:(BOOL)isRefresh
                         completeHandler:(PCCWViewModelCompleteHandler)handler{
    NSString *operatorName = searchInfo[kSearchOperatorName];
    
    [self.fetchOperator fetchOperatorsWithIsRefresh:isRefresh
                                       operatorName:operatorName
                                    completeHandler:^(NSArray<IBLOperator *> *operators, NSError *error) {
                                        PCCWSection *section = [self sectionAt:0];
                                        NSMutableArray<PCCWSectionItem *> * sectionItems =[self sectionItemsWithOperators:operators];

                                        if (isRefresh) {
                                            section.items = sectionItems;
                                        }else{
                                            [section.items addObjectsFromArray:sectionItems];
                                        }
                                        
                                        handler(error);
                                    }];
}


- (id)searchResultAtIndexPath:(NSIndexPath *)indexPath {
    return [self operatorAtIndexPath:indexPath];;
}

- (NSMutableArray<PCCWSectionItem *> *)sectionItemsWithOperators:(NSArray<IBLOperator *> *)operators {
    
    NSMutableArray<PCCWSectionItem *> *sectionItems = [NSMutableArray array];
    
    for (IBLOperator *operator in operators) {
        PCCWSectionItem *item = [PCCWSectionItem itemWithInfo:operator selected:NO];
        [sectionItems addObject:item];
    }
    
    return sectionItems;
}

- (IBLOperator *)operatorAtIndexPath:(NSIndexPath *)indexPath{
    PCCWSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];
    
    return sectionItem.info;
}

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath {
    IBLOperator *operator = [self operatorAtIndexPath:indexPath];
    
    return operator.name;
}
@end
