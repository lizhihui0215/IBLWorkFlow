//
//  IBLAlertController.h
//  CMCC
//
//  Created by 李智慧 on 11/22/15.
//  Copyright © 2015 PCCW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBLButtonItem.h"
typedef NS_ENUM(NSInteger, IBLAlertStyle){
    IBLAlertStyleAlert,
    IBLAlertStyleActionSheet
};
@interface IBLAlertController : NSObject
-(instancetype)initWithStyle:(IBLAlertStyle)style
                       title:(NSString *)title
                  message:(NSString *)message
         cancleButtonItem:(IBLButtonItem *)cancleButtonItem
         otherButtonItems:(IBLButtonItem *)inOtherButtonItems, ... NS_REQUIRES_NIL_TERMINATION;
- (void)showInController:(UIViewController *)viewController;
@end
