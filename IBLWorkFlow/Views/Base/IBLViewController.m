//
//  IBLViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewController.h"
#import "IBLException.h"
#import "IBLHUDHandler.h"

@interface IBLViewController ()

@property (nonatomic, strong) IBLException *exception;

@property (nonatomic, strong) IBLHUDHandler *HUDHandler;

@end

@implementation IBLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.exception = [IBLException exceptionWithHandler:self];
    
    self.HUDHandler = [IBLHUDHandler handlerWithLoadingHandler:self];
}

- (BOOL)showAlertWithError:(NSError *)error{
    return [self.exception handleExceptionWithError:error];
}

- (void)showAlertWithError:(NSError *)error
           completeHandler:(void (^)(BOOL isShowError, NSError *error)) handler{
    [self.exception handleExceptionWithError:error completeHandler:handler];
}

- (void)showHUDWithMessage:(NSString *)message forView:(UIView *)view{
    [self.HUDHandler showHUDWithMessage:message forView:view];
}

- (void)showHUDWithMessage:(NSString *)message{
    [self.HUDHandler showHUDWithMessage:message];
}

- (void)hidHUD{
    [self.HUDHandler hidenHUD];
}

- (void)hidHUDForView:(UIView *)view{
    [self.HUDHandler hidenHUDFor:view];
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
