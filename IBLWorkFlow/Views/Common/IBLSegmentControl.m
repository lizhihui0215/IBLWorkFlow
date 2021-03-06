//
//  IBLSegmentControl.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 26/11/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLSegmentControl.h"
#import <Masonry/Masonry.h>


@implementation IBLSegmentControl

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)setActionTitles:(NSArray *)titles{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    UIButton *previousButton = nil;
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        [button setTitle:title forState:UIControlStateNormal];
        UIColor *titleColor = [UIColor colorWithHex:0x2289E6];
        [button setFont:[UIFont systemFontOfSize:13]];
        
        [button setTitleColor:titleColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(titlePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(self.mas_leading);
                make.centerY.equalTo(self.mas_centerY);
            }];
        }else{
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(previousButton.mas_trailing).with.offset(IBLOrderSegmentControlTitleWidth);
                make.centerY.equalTo(self.mas_centerY);
            }];
        }
        previousButton = button;
    }
    
    //    for (NSString *title in titles) {
    //        UIButton *button = [[UIButton alloc] init];
    //
    //        button.tag = [titles indexOfObject:title];
    //        [button setTitle:title forState:UIControlStateNormal];
    //            UIColor *titleColor = [UIColor colorWithHex:0x2289E6];
    //        [button setFont:[UIFont systemFontOfSize:13]];
    //
    //
    //
    //        [button setTitleColor:titleColor forState:UIControlStateNormal];
    //        [button addTarget:self action:@selector(titlePressed:) forControlEvents:UIControlEventTouchUpInside];
    //        [self addSubview:button];
    //
    //        [button mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.centerY.equalTo(self.mas_centerY);
    //            make.centerX.equalTo(self.mas_leading).with.offset(center * ([titles indexOfObject:title] + 1));
    //        }];
    //    }
}

- (void)titlePressed:(UIButton *)button{
    self.indexChangeBlock(button.tag);
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
