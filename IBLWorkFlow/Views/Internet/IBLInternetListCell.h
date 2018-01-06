//
//  IBLInternetListCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewCell.h"

@interface IBLInternetListCell : PCCWTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scriptTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleResultLabel;
@property (weak, nonatomic) IBOutlet UIImageView *handleStatusImageView;
@property (weak, nonatomic) IBOutlet UILabel *lastModifyDateLabel;

@end
