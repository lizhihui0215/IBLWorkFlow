//
//  IBLLeftMenuTableHeaderView.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewHeaderFooterView.h"

static NSString * const IBLLeftMenuTableHeaderNibName = @"IBLLeftMenuTableHeaderView";

static NSString * const IBLLeftMenuTableHeaderIdentifier = @"IBLLeftMenuTableHeaderView";

@interface IBLLeftMenuTableHeaderView : IBLTableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
