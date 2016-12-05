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
#import "IBLPayDetailViewController.h"

@interface IBLQRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *QRImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *QRBackgroundView;

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
    self.QRBackgroundView.layer.cornerRadius = 3;
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                      style:UIBarButtonItemStylePlain
                                                                     target:self
                                                                     action:@selector(backButtonPressed:)];
    
    self.navigationItem.leftBarButtonItem = newBackButton;
    
    self.startDate = [NSDate date];
    
    switch (self.pay) {
        case IBLQRPayTypeWeChat: {
            self.title = @"微信支付";
            self.titleLabel.text = @"使用微信扫描二维码付款";
            break;
        }
        case IBLQRPayTypeAilPay: {
            self.title = @"支付宝支付";
            self.titleLabel.text = @"使用支付宝扫描二维码付款";
            break;
        }
    }
    
    CocoaSecurityDecoder *encode = [[CocoaSecurityDecoder alloc] init];
    NSData *data = [encode base64:self.payResult.codeUrl];
    self.QRImageView.image = [UIImage imageWithData:data];
    
    
    [self performSelectorInBackground:@selector(checkOrders:) withObject:@(NO)];
}

- (void)checkOrders:(NSNumber *)isStop{
    [NSThread sleepForTimeInterval:10];
    if ([isStop boolValue]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认" action:^(IBLButtonItem *item) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                            title:@"支付超时，请重新支付！"
                                                                          message:nil
                                                                 cancleButtonItem:cancel
                                                                 otherButtonItems:nil];
            [alert showInController:self];
        });
        return;
    }
    @weakify(self)
    [self.checkOrder checkOrderWithNumber:self.payResult.orderNo
                          completeHandler:^(IBLOrderPayStatus status, NSError *error) {
                              @strongify(self)
                              
                              switch (status) {
                                  case IBLOrderPayStatusPayed:
                                  case IBLOrderPayStatusClosed:
                                  case IBLOrderPayStatusFaild:{
                                      IBLButtonItem *cancel = [IBLButtonItem itemWithLabel:@"确认" action:^(IBLButtonItem *item) {
                                          [self.navigationController popViewControllerAnimated:YES];
                                      }];
                                      
                                      IBLAlertController *alert = [[IBLAlertController alloc] initWithStyle:IBLAlertStyleAlert
                                                                                                      title:@"支付失败，请联系管理员！"
                                                                                                    message:nil
                                                                                           cancleButtonItem:cancel
                                                                                           otherButtonItems:nil];
                                      [alert showInController:self];
                                      return ;

                                  }
                                  case IBLOrderPayStatusFinished:{
                                      [self performSegueWithIdentifier:@"NavigationToOrderDetail" sender:nil];
                                      return ;
                                  }
                                  default:
                                  {
                                      NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
                                      [self performSelectorInBackground:@selector(checkOrders:) withObject:@(interval > 60 * 3)];
                                      break;
                                  }
                              }
                          }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"NavigationToOrderDetail"]) {
        IBLPayDetailViewController *orderDetailViewController = [segue destinationViewController];
        orderDetailViewController.orderNumber = self.payResult.orderNo;
        orderDetailViewController.order = self.order;
        orderDetailViewController.payModel = self.pay == IBLQRPayTypeWeChat ? IBLQRPayDetailTypeWeChat : IBLQRPayDetailTypeAilPay;
        switch (self.type) {
            case IBLQRTypeFromOrderCreateAccount: {
                orderDetailViewController.type = IBLOrderDetailTypeFromOrderCreateAccount;
                break;
            }
            case IBLQRTypeFromCreateAccount: {
                orderDetailViewController.type = IBLOrderDetailTypeFromCreateAccount;
                break;
            }
            case IBLQRTypeFromRenew:{
                orderDetailViewController.type = IBLOrderDetailTypeFromRenew;
                break;
            }
            case IBLQRTypeFromExchangeProduct:{
                orderDetailViewController.type = IBLOrderDetailTypeFromExchangeProduct;
                break;
            }
        }
    }
}


@end
