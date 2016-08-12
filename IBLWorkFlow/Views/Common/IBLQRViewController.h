//
//  IBLQRViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewController.h"

typedef NS_ENUM(NSInteger, IBLPay) {
    IBLPayWeChat,
    IBLPayAilPay,
};

@interface IBLQRViewController : IBLViewController
@property (nonatomic, strong) NSString *encodeQRImageData;
@property (nonatomic, assign) IBLPay pay;
@end
