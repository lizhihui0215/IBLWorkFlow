//
//  IBLOperatorSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchViewModel.h"
#import "IBLFetchOperatorList.h"
#import "IBLOrder.h"

@interface IBLOperatorSearchViewModel : IBLSearchViewModel

@property (nonatomic, strong, readonly) IBLOrder *order;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;

+ (instancetype)operatorSearchModelWithOrder:(IBLOrder *)order searchType:(IBLSearchType)searchType;
@end
