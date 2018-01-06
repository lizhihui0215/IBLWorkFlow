//
//  IBLSearchFieldCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/18/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewCell.h"

static NSString *const IBLSearchFieldCellIdentifier = @"IBLSearchFieldCell";

@interface IBLSearchFieldCell : PCCWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
