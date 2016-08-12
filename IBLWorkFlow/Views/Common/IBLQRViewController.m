//
//  IBLQRViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLQRViewController.h"
#import <CocoaSecurity/CocoaSecurity.h>

@interface IBLQRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@end

@implementation IBLQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.pay) {
        case IBLPayWeChat: {
            self.title = @"微信支付";
            break;
        }
        case IBLPayAilPay: {
            self.title = @"支付宝支付";
            break;
        }
    }
    
    CocoaSecurityDecoder *encode = [[CocoaSecurityDecoder alloc] init];
    NSData *data = [encode base64:self.encodeQRImageData];
    self.QRImageView.image = [UIImage imageWithData:data];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
