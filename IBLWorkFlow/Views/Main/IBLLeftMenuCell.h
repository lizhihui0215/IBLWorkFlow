//
//  IBLLeftMenuCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//



static NSString * const LeftMenuCellIdentifier = @"IBLLeftMenuCell";

@interface IBLLeftMenuCell : PCCWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
