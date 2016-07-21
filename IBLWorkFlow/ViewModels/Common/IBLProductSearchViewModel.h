//
//  IBLProductSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSearchViewModel.h"
#import "IBLFetchProduct.h"

@interface IBLProductSearchViewModel : IBLSearchViewModel
+ (instancetype)productSearchModelWithSearchType:(IBLSearchType)searchType
                                       productId:(NSInteger)productId
                                        regionId:(NSInteger)regionId;

- (NSString *)nameAtIndexPath:(NSIndexPath *)indexPath;
@end
