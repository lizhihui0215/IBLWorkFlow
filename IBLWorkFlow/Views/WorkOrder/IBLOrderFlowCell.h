//
//  IBLOrderFlowCell.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewCell.h"

@interface IBLOrderFlowCell : IBLTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *operatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *suggestLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleDateLabel;

@end
