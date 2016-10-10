//
//  IBLAboutViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/23/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLAboutViewController.h"
#import "IBLAppRepository.h"


@interface IBLAboutViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation IBLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    IBLAppConfiguration *appConfiguration = [IBLAppRepository appConfiguration];
    
    NSURL *url = [NSURL URLWithString:appConfiguration.aboutUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
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
