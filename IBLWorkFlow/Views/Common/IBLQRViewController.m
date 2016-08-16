//
//  IBLQRViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLQRViewController.h"
#import <CocoaSecurity/CocoaSecurity.h>

#import "IBLCheckOrder.h"

@interface IBLQRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;

@property (nonatomic, strong) IBLCheckOrder *checkOrder;

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation IBLQRViewController

- (void)backButtonPressed:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.checkOrder = [[IBLCheckOrder alloc] init];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"]
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    self.startDate = [NSDate date];

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
    NSData *data = [encode base64:self.payResult.codeUrl];
    self.QRImageView.image = [UIImage imageWithData:data];
    
    [self checkOrders:NO];
    
}

- (void)checkOrders:(BOOL)isStop{
    if (isStop) {
        IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认"];
        
        
        IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleActionSheet
                                                                        title:@"支付超时，请重新支付！"
                                                                      message:nil
                                                             cancleButtonItem:cancel
                                                             otherButtonItems:nil];
        [alert showInController:self];

        return;
    }
    @weakify(self)
    [self.checkOrder checkOrderWithNumber:self.payResult.orderNo
                          completeHandler:^(IBLOrderPayStatus status, NSError *error) {
                              @strongify(self)
                              NSTimeInterval interval = [self.startDate timeIntervalSinceNow];
                              [self checkOrders:interval > 60 * 3];
                          }];
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
