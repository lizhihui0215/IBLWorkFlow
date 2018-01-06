//
//  IBLLeftMenuTableHeaderView.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWTableViewHeaderFooterView.h"

static NSString * const IBLLeftMenuTableHeaderNibName = @"IBLLeftMenuTableHeaderView";

static NSString * const IBLLeftMenuTableHeaderIdentifier = @"IBLLeftMenuTableHeaderView";

@class IBLLeftMenuTableHeaderView;

@protocol IBLLeftMenuTableHeaderViewDelegate <NSObject>

- (void)headerView:(IBLLeftMenuTableHeaderView *)headerView tappedAtSection:(NSInteger)sectionIndex;

@end

@interface IBLLeftMenuTableHeaderView : PCCWTableViewHeaderFooterView

@property (nonatomic, assign) NSInteger sectionIndex;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) id<IBLLeftMenuTableHeaderViewDelegate> delegate;


@end
