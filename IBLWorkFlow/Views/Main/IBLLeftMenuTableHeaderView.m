//
//  IBLLeftMenuTableHeaderView.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/12/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLLeftMenuTableHeaderView.h"

@interface IBLLeftMenuTableHeaderView ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation IBLLeftMenuTableHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(sectionHeaderTapped:)];
    
    [self.containerView addGestureRecognizer:tap];
}

- (IBAction)sectionHeaderTapped:(UITapGestureRecognizer *)sender {
    if([self.delegate respondsToSelector:@selector(headerView:tappedAtSection:)]){
        [self.delegate headerView:self tappedAtSection:self.sectionIndex];
    }
}

@end
