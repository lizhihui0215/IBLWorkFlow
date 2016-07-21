//
//  IBLRegionSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchViewModel.h"
#import "IBLRegion.h"

@interface IBLRegionSearchViewModel : IBLSearchViewModel
+ (instancetype)regionSearchModelWithSearchType:(IBLSearchType)searchType;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;
@end
