//
//  IBLSegmentControl.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 26/11/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IBLSegmentControl;
static CGFloat const IBLOrderSegmentControlTitleWidth = 10;

typedef void (^IndexChangeBlock)(NSInteger index);
typedef NSAttributedString *(^IBLTitleFormatterBlock)(IBLSegmentControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected);

@interface IBLSegmentControl : UIView

@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

@property (nonatomic, copy) IBLTitleFormatterBlock titleFormatter;

- (void)setActionTitles:(NSArray *)titles;

@end
