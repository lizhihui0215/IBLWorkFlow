//
//  IBLMineOrderCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewCell.h"

typedef NS_ENUM(NSInteger, IBLOrderCellAction) {
    IBLOrderCellActionCreate,
};

static NSString * const MineWorkFlowCellIdentifier = @"IBLMineOrderCell";

static NSString * const MineWorkFlowCellNibName = @"IBLMineOrderCell";

@interface IBLMineOrderCell : IBLTableViewCell

@end
