//
//  IBLOrderFlowDetailViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 09/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderFlowDetailViewController.h"
#import "IBLOrder.h"
@interface IBLOrderFlowDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleCommentLabel;

@end

@implementation IBLOrderFlowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.statusLabel.text = [self orderStatusNameWithStatus:self.orderFlow.state];
    self.handleUserLabel.text = self.orderFlow.operatorName;
    self.phoneLabel.text = self.orderFlow.operatorPhone;
    self.handleDateLabel.text = self.orderFlow.creatorTime;
    self.handleCommentLabel.text = self.orderFlow.handleNote;
    [self removeFooterView];
    self.tableView.estimatedRowHeight = 40;
    [self.tableView reloadData];
}

- (NSString *)orderStatusNameWithStatus:(IBLOrderStatus)status{
    NSDictionary *workOrderStatus = @{@(IBLOrderStatusUnsend) : @"[未派单]",
                                      @(IBLOrderStatusSended) : @"[已派单]",
                                      @(IBLOrderStatusForwarding) : @"[转发中]",
                                      @(IBLOrderStatusHandling) : @"[处理中]",
                                      @(IBLOrderStatusInvalid) : @"[作废]",
                                      @(IBLOrderStatusFinished) : @"[完成]",
                                      @(IBLOrderStatusFeedback) : @"[反馈中]"};
    return workOrderStatus[@(status)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (size.height < tableView.estimatedRowHeight) {
        return tableView.estimatedRowHeight;
    }
    
    NSLog(@"hight %f",size.height);
    
    return size.height + 0.5;
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
