//
//  IBLOrderDetailTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderDetailTableViewController.h"

@interface IBLOrderDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *relateUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderBizTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *proirtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *expireDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *handlerLabel;
@property (weak, nonatomic) IBOutlet UILabel *handlerPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateDateLabel;

@end

@implementation IBLOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.regionLabel.text = self.order.regionName;
    self.relateUserLabel.text = self.order.userAccount;
    self.userPhoneLabel.text = self.order.phone;
    self.orderTypeLabel.text = [self workOrderTypeNameWithStatus:self.order.type];
    self.orderBizTypeLabel.text = [self workOrderBizTypeNameWithStatus:self.order.bizType];
    self.orderStatusLabel.text = [self orderStatusNameWithStatus:self.order.status];
    self.proirtyLabel.text = [self orderProirtyNameWithProirty:self.order.priority];
    self.contentLabel.text = self.order.content;
    self.creatorLabel.text = self.order.creatorName;
    self.creatorPhoneLabel.text = self.order.creatorPhone;
    self.createDateLabel.text = self.order.createTime;
    self.expireDateLabel.text = self.order.expireTime;
    //???: 内容那里来
//    self.handlerLabel.text = self.order.
//    self.handlerPhoneLabel.text = self.order.
    self.lastUpdateDateLabel.text = self.order.lastModifyTime;
    
}

- (NSString *)orderProirtyNameWithProirty:(IBLPriorityStatus)status{
    NSDictionary *workOrderPriority = @{@(IBLPriorityStatusEmergency) : @"紧急",
                                      @(IBLPriorityStatusGeneral) : @"一般",
                                      @(IBLPriorityStatusNoEmergency) : @"不紧急",};
    

    return workOrderPriority[@(status)];
}
- (NSString *)orderStatusNameWithStatus:(IBLOrderStatus)status{
    NSDictionary *workOrderStatus = @{@(IBLOrderStatusUnsend) : @"未派单",
                                     @(IBLOrderStatusSended) : @"已派单",
                                     @(IBLOrderStatusForwarding) : @"转发中",
                                     @(IBLOrderStatusHandling) : @"处理中",
                                     @(IBLOrderStatusInvalid) : @"作废",
                                     @(IBLOrderStatusFinished) : @"完成",
                                     @(IBLOrderStatusFeedback) : @"反馈中"};
    return workOrderStatus[@(status)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell;
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


- (NSString *)workOrderTypeNameWithStatus:(IBLWorkOrderStatus)status{
    
    NSDictionary *workOrderTypes = @{@(IBLWorkOrderStatusUnknow) : @"",
                          @(IBLWorkOrderStatusProject) : @"工程",
                          @(IBLWorkOrderStatusMalfunction) : @"故障",
                          @(IBLWorkOrderStatusComplainn) : @"投诉",
                          @(IBLWorkOrderStatusAdvisory) : @"咨询",
                          @(IBLWorkOrderStatusReply) : @"回访",
                          @(IBLWorkOrderStatusRepair) : @"抢修"};
    return workOrderTypes[@(status)];
}

- (NSString *)workOrderBizTypeNameWithStatus:(IBLWorkOrderBizStatus)status{
    NSDictionary *workOrderBizTypes = @{@(IBLWorkOrderBizStatusUnknow) : @"",
                                        @(IBLWorkOrderBizStatusRepair) : @"报修",
                                        @(IBLWorkOrderBizStatusInstall) : @"报装",
                                        @(IBLWorkOrderBizStatusStop) : @"停机修复",
                                        @(IBLWorkOrderBizStatusReturn) : @"退网",
                                        @(IBLWorkOrderBizStatusMove) : @"移网",
                                        @(IBLWorkOrderBizStatusHandleMalfunction) : @"故障处理",
                                        @(IBLWorkOrderBizStatusHandleComplaints) : @"投诉处理",
                                        @(IBLWorkOrderBizStatusHandleAdvisory) : @"咨询处理",
                                        @(IBLWorkOrderBizStatusHandleReply) : @"回访处理",
                                        @(IBLWorkOrderBizStatusElectrical) : @"接电",
                                        @(IBLWorkOrderBizStatusAddBox) : @"加箱",
                                        @(IBLWorkOrderBizStatusChangeBox) : @"改箱",
                                        @(IBLWorkOrderBizStatusAddLock) : @"加锁",
                                        @(IBLWorkOrderBizStatusFlyLine) : @"飞线",
                                        @(IBLWorkOrderBizStatusSplice) : @"熔纤",
                                        @(IBLWorkOrderBizStatusThroughCable) : @"穿光缆",
                                        @(IBLWorkOrderBizStatusLightBarrier) : @"光不通",
                                        @(IBLWorkOrderBizStatusLineBarrier) : @"线不通穿线",
                                        @(IBLWorkOrderBizStatusCableBreak) : @"光缆断",
                                        @(IBLWorkOrderBizStatusOther) : @"其他"};
    return workOrderBizTypes[@(status)];
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
