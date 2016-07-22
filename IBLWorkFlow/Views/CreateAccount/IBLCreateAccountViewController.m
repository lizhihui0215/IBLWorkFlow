//
//  IBLCreateAccountViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountViewController.h"
#import "IBLCreateAccountTableViewController.h"

static NSString *const IBLCreateAccountEmbedTableViewIdentifier = @"CreateAccountEmbedTableView";

@interface IBLCreateAccountViewController ()

@end

@implementation IBLCreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.viewModel.createAccountType == IBLCreateAccountTypeFromLeftMenu) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu"]
                                                                                 style:UIBarButtonItemStylePlain
                                                                                target:self action:@selector(presentLeftMenuViewController:)];
    }
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
    if ([segue.identifier isEqualToString:IBLCreateAccountEmbedTableViewIdentifier]) {
        IBLCreateAccountTableViewController *tableViewController = [segue destinationViewController];
        
        tableViewController.tableViewDataSource = self;
    }
}

- (void)tableViewController:(IBLCreateAccountTableViewController *)controller
                     commit:(IBLCreateAccountInfo *)commit {
    
}



- (IBLCreateAccountInfo *)createAccountInfoOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self createAccountInfoFromOrder:self.viewModel.order];
}

- (IBLOrderEffectType)defaultEffectTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self.viewModel defaultEffectType];
}

- (IBLCreateAccountType)createAccountTypeOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return self.viewModel.createAccountType;
}

- (NSString *)defaultEffectDateOfTableViewController:(IBLCreateAccountTableViewController *)controller{
    return [self.viewModel defaultEffectDate];
}

- (void)productPriceOfTableViewController:(IBLCreateAccountTableViewController *)controller
                          completeHandler:(void (^)(IBLProductPrice *productPrice))completeHandler {
    NSInteger productId = controller.createAccountInfo.productIdentifier;
    IBLFetchProductPriceInfo *fetchProductPrice = [IBLFetchProductPriceInfo priceWithProductId:productId
                                                                                   discountIds:@""
                                                                                         renew:NO];
    [self showHUDWithMessage:@""];
    [self.viewModel fetchProductPrice:fetchProductPrice
                      completeHandler:^(NSError *error){
                          IBLProductPrice *productPrice = [self.viewModel productPrice];
                          [self hidHUD];
                          [self showAlertWithError:error];
                          completeHandler(productPrice);
                      }];
}


- (IBLCreateAccountInfo *)createAccountInfoFromOrder:(IBLOrder *)order {
    IBLCreateAccountInfo *createAccountInfo = nil;
    if (order) {
        createAccountInfo = [IBLCreateAccountInfo infoWithResidentialIdentifier:order.residentialIdentifier
                                                              productIdentifier:order.productIdentifier
                                                                       username:order.username
                                                                     regionName:order.regionName
                                                                    productName:order.productName
                                                               identifierNumber:order.identifierNumber
                                                                         remark:order.remark
                                                                     effectType:order.effectType
                                                                     effectDate:order.effectDate
                                                                          phone:order.phone
                                                                        address:order.address
                                                                     handleMark:order.handleMark];
    }else{
        createAccountInfo = [[IBLCreateAccountInfo alloc] init];
    }
    
    return createAccountInfo;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
   return [self.viewModel isHiddenAtIndexPath:indexPath];
}



@end
