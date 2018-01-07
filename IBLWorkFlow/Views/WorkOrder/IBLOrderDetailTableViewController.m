//
//  IBLOrderDetailTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLOrderDetailTableViewController.h"
#import "IBLUserDetailTableViewController.h"
#import "IBLWorkOrderBussinessType.h"
#import "IBLAppRepository.h"

@interface IBLOrderDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UIButton *userAccountButton;
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
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *adviceUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeTextField;
@property (weak, nonatomic) IBOutlet UILabel *tvTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ftthLabel;
@property (weak, nonatomic) IBOutlet UILabel *troubleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addrLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *relateUserTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *adviceUserTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bizTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tvTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ffthTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *troubleTypeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *proirtyTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderContentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatorPhoneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *expDateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleNameTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *handlePhoneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateDateTitleLabel;


@end

@implementation IBLOrderDetailTableViewController

- (IBAction)userAccountButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"NavigationToUserDetail" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.userAccountButton setTitle:self.order.userAccount forState:UIControlStateNormal];
    self.orderTypeLabel.text = [self workOrderTypeNameWithStatus:self.order.type];
    self.orderBizTypeLabel.text = [self workOrderBizTypeNameWithStatus:self.order.bizType];
    self.orderStatusLabel.text = [self orderStatusNameWithStatus:self.order.status];
    self.proirtyLabel.text = [self orderProirtyNameWithProirty:self.order.priority];
    self.contentLabel.text = self.order.content;
    self.creatorLabel.text = self.order.creatorName;
    self.creatorPhoneLabel.text = self.order.creatorPhone;
    self.createDateLabel.text = self.order.createTime;
    self.expireDateLabel.text = self.order.expireTime;
    self.adviceUserNameLabel.text = self.order.username;
    self.serviceTypeTextField.text = self.order.serviceType;
    self.tvTypeLabel.text = self.order.tvType;
    self.ftthLabel.text = self.order.ftth;
    self.troubleTypeLabel.text = self.order.troubleType;
    
//    if (self.order.custType == 0) {
//        self.nameTitleLabel.text = @"用户姓名:";
//        self.nameLabel.text = self.order.username;
//        self.phoneTitleLabel.text = @"联系电话:";
//        self.phoneLabel.text = self.order.phone;
//        self.addrLabel.text = self.order.address;
//    }else{
//        self.nameTitleLabel.text = @"企业名称:";
//        self.nameLabel.text = self.order.comName;
//        self.phoneTitleLabel.text = @"联系电话:";
//        self.phoneLabel.text = self.order.comContactPhone;
//        self.addrLabel.text = self.order.comAddr;
//    }
    
    self.regionLabel.text = self.order.regionName;
    
    //???: 内容那里来
    self.handlerLabel.text = self.order.curOperName;
    self.handlerPhoneLabel.text = self.order.curOperPhone;
    self.lastUpdateDateLabel.text = self.order.lastModifyTime;
    
}

- (void)languageDidChanged:(NSNotification *)notification {
    NSString *usernameTitle= NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.nameTitleLabel.text", @"Main", "not found");
    NSString *phoneTitle= NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.phoneTitleLabel.text", @"Main", "not found");
    NSString *comTitle= NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.comTitle.text", @"Main", "not found");
    NSString *comPhone= NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.comPhone.text", @"Main", "not found");

    if (self.order.custType == 0) {
        self.nameTitleLabel.text = usernameTitle;
        self.phoneTitleLabel.text = phoneTitle;
    }else{
        self.nameTitleLabel.text = comTitle;
        self.phoneTitleLabel.text = comPhone;
    }
    
    
    
    
    self.relateUserTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.relateUserTitleLabel.text", @"Main", "not found");
    self.adviceUserTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.adviceUserTitleLabel.text", @"Main", "not found");
    self.usernameTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.usernameTitleLabel.text", @"Main", "not found");
    self.addressTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.addressTitleLabel.text", @"Main", "not found");
    self.regionTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.regionTitleLabel.text", @"Main", "not found");
    self.bizTypeTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.bizTypeTitleLabel.text", @"Main", "not found");
    self.serviceTypeTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.serviceTypeTitleLabel.text", @"Main", "not found");
    self.tvTypeTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.tvTypeTitleLabel.text", @"Main", "not found");
    self.ffthTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.ffthTitleLabel.text", @"Main", "not found");
    self.troubleTypeTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.troubleTypeTitleLabel.text", @"Main", "not found");
    self.orderStatusTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.orderStatusTitleLabel.text", @"Main", "not found");
    self.proirtyTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.proirtyTitleLabel.text", @"Main", "not found");
    self.orderContentTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.orderContentTitleLabel.text", @"Main", "not found");
    self.creatorTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.creatorTitleLabel.text", @"Main", "not found");
    
    self.creatorPhoneTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.creatorPhoneTitleLabel.text", @"Main", "not found");
    self.createDateTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.createDateTitleLabel.text", @"Main", "not found");
    self.expDateTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.expDateTitleLabel.text", @"Main", "not found");
    self.handleNameTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.handleNameTitleLabel.text", @"Main", "not found");
    self.handlePhoneTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.handlePhoneTitleLabel.text", @"Main", "not found");
    self.lastUpdateDateTitleLabel.text = NSLocalizedStringFromTable(@"IBLOrderDetailTableViewController.lastUpdateDateTitleLabel.text", @"Main", "not found");
}

- (NSString *)orderProirtyNameWithProirty:(IBLPriorityStatus)status{
    
   NSString *high= NSLocalizedStringFromTable(@"IBLOrderLevel.high", @"Main", "not found");
   NSString *normal = NSLocalizedStringFromTable(@"IBLOrderLevel.normal", @"Main", "not found");
   NSString *low = NSLocalizedStringFromTable(@"IBLOrderLevel.low", @"Main", "not found");

    NSDictionary *workOrderPriority = @{@(IBLPriorityStatusEmergency) : high,
                                      @(IBLPriorityStatusGeneral) : normal,
                                      @(IBLPriorityStatusNoEmergency) : low,};
    

    return workOrderPriority[@(status)];
}
- (NSString *)orderStatusNameWithStatus:(IBLOrderStatus)status{
    NSString *orderStatusUnsend = NSLocalizedStringFromTable(@"IBLOrderStatus.unsend", @"Main", "not found");
    NSString *orderStatusSended = NSLocalizedStringFromTable(@"IBLOrderStatus.sended", @"Main", "not found");
    NSString *orderStatusHandling = NSLocalizedStringFromTable(@"IBLOrderStatus.handling", @"Main", "not found");
    NSString *orderStatusInvalid = NSLocalizedStringFromTable(@"IBLOrderStatus.invalid", @"Main", "not found");
    NSString *orderStatusFinished = NSLocalizedStringFromTable(@"IBLOrderStatus.finished", @"Main", "not found");
    NSString *orderStatusFeedback = NSLocalizedStringFromTable(@"IBLOrderStatus.feedback", @"Main", "not found");

    NSDictionary *workOrderStatus = @{@(IBLOrderStatusUnsend) : orderStatusUnsend,
                                     @(IBLOrderStatusSended) : orderStatusSended,
//                                     @(IBLOrderStatusForwarding) : @"转发中",
                                     @(IBLOrderStatusHandling) : orderStatusHandling,
                                     @(IBLOrderStatusInvalid) : orderStatusInvalid,
                                     @(IBLOrderStatusFinished) : orderStatusFinished,
                                     @(IBLOrderStatusFeedback) : orderStatusFeedback};
    return workOrderStatus[@(status)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =  [super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if ([self isHiddenAtIndexPath:indexPath]) {
        return 0;
    }
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    if (size.height < tableView.estimatedRowHeight) {
        return tableView.estimatedRowHeight;
    }
    
    NSLog(@"hight %f",size.height);
    
    return size.height + 0.5;
}

- (BOOL)isHiddenAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *adviceUserNameIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    NSIndexPath *serviceTypeIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
    NSIndexPath *tvTypeIndexPath = [NSIndexPath indexPathForRow:8 inSection:0];
    NSIndexPath *ftthIndexPath = [NSIndexPath indexPathForRow:9 inSection:0];
    NSIndexPath *troubleTypeIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];

    NSArray *repairIndexPath = @[serviceTypeIndexPath,
                                 tvTypeIndexPath,
                                 ftthIndexPath,
                                 troubleTypeIndexPath];
    
    if (self.order.bizType == IBLWorkOrderBizStatusHandleAdvisory) {
        if ([repairIndexPath containsObject:indexPath] ) {
            return YES;
        }
        return NO;
    }else if (self.order.bizType == IBLWorkOrderBizStatusRepair) {
        if([NSString isNull:self.order.serviceType] && [indexPath isEqual:serviceTypeIndexPath]) {
            return YES;
        }else if ([NSString isNull:self.order.tvType] && [indexPath isEqual:tvTypeIndexPath]){
            return YES;
        }else if ([NSString isNull:self.order.ftth] && [indexPath isEqual:ftthIndexPath]){
            return YES;
        }else if ([NSString isNull:self.order.troubleType] && [indexPath isEqual:troubleTypeIndexPath]){
            return YES;
        }
    }else {
        if ([repairIndexPath containsObject:indexPath]) {
            return YES;
        }
    }
    
    if ([indexPath isEqual:adviceUserNameIndexPath]) {
        return YES;
    }
    
    return NO;
}


- (NSString *)workOrderTypeNameWithStatus:(IBLWorkOrderStatus)status{
    for (IBLWorkOrderType *type in [IBLAppRepository appConfiguration].workOrderTypes) {
        if (status == type.status) {
            return type.name;
        }
    }
    
    return @"";
    
//    NSString  *orderTypeProject= NSLocalizedStringFromTable(@"IBLOrder.type.project", @"Main", "not found");
//    NSString  *orderTypeMalfunction = NSLocalizedStringFromTable(@"IBLOrder.type.malfunction", @"Main", "not found");
//    NSString  *orderTypeComplainn = NSLocalizedStringFromTable(@"IBLOrder.type.complainn", @"Main", "not found");
//    NSString  *orderTypeAdvisory = NSLocalizedStringFromTable(@"IBLOrder.type.advisory", @"Main", "not found");
//    NSString  *orderTypeReply = NSLocalizedStringFromTable(@"IBLOrder.type.reply", @"Main", "not found");
//    NSString  *orderTypeRepair = NSLocalizedStringFromTable(@"IBLOrder.type.repair", @"Main", "not found");
//
//    NSDictionary *workOrderTypes = @{@(IBLWorkOrderStatusUnknow) : @"",
//                          @(IBLWorkOrderStatusProject) : orderTypeProject,
//                          @(IBLWorkOrderStatusMalfunction) : orderTypeMalfunction,
//                          @(IBLWorkOrderStatusComplainn) : orderTypeComplainn,
//                          @(IBLWorkOrderStatusAdvisory) : orderTypeAdvisory,
//                          @(IBLWorkOrderStatusReply) : orderTypeReply,
//                          @(IBLWorkOrderStatusRepair) : orderTypeRepair};
//    return workOrderTypes[@(status)];
}

- (NSString *)workOrderBizTypeNameWithStatus:(IBLWorkOrderBizStatus)status{
    for (IBLWorkOrderBussinessType *bizType in [IBLAppRepository appConfiguration].workOrderBizTypes) {
        if (status == bizType.status) {
            return bizType.name;
        }
    }
    
    return @"";
//    NSString  *orderBizRepair = NSLocalizedStringFromTable(@"IBLOrder.bizType.repair", @"Main", "not found");
//    NSString  *orderBizInstall = NSLocalizedStringFromTable(@"IBLOrder.bizType.install", @"Main", "not found");
//
//
//    NSString  *orderBizStop = NSLocalizedStringFromTable(@"IBLOrder.bizType.stop", @"Main", "not found");
//
//    NSString  *orderBizReturn = NSLocalizedStringFromTable(@"IBLOrder.bizType.return", @"Main", "not found");
//    NSString  *orderBizMove = NSLocalizedStringFromTable(@"IBLOrder.bizType.move", @"Main", "not found");
//
//    NSString  *orderBizHandleMalfunction = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleMalfunction", @"Main", "not found");
//
//    NSString  *orderBizHandleComplaints = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleComplaints", @"Main", "not found");
//    NSString  *orderBizHandleAdvisory = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleAdvisory", @"Main", "not found");
//    NSString  *orderBizHandleReply = NSLocalizedStringFromTable(@"IBLOrder.bizType.handleReply", @"Main", "not found");
//    NSString  *orderBizElectrical = NSLocalizedStringFromTable(@"IBLOrder.bizType.electrical", @"Main", "not found");
//    NSString  *orderBizAddBox = NSLocalizedStringFromTable(@"IBLOrder.bizType.addBox", @"Main", "not found");
//    NSString  *orderBizChangeBox = NSLocalizedStringFromTable(@"IBLOrder.bizType.changeBox", @"Main", "not found");
//
//    NSString  *orderBizAddLock = NSLocalizedStringFromTable(@"IBLOrder.bizType.addLock", @"Main", "not found");
//    NSString  *orderBizFlyLine = NSLocalizedStringFromTable(@"IBLOrder.bizType.flyLine", @"Main", "not found");
//    NSString  *orderBizSplice = NSLocalizedStringFromTable(@"IBLOrder.bizType.splice", @"Main", "not found");
//
//    NSString  *orderBizThroughCable = NSLocalizedStringFromTable(@"IBLOrder.bizType.throughCable", @"Main", "not found");
//    NSString  *orderBizLightBarrier = NSLocalizedStringFromTable(@"IBLOrder.bizType.lightBarrier", @"Main", "not found");
//    NSString  *orderBizLineBarrier = NSLocalizedStringFromTable(@"IBLOrder.bizType.lineBarrier", @"Main", "not found");
//    NSString  *orderBizCableBreak = NSLocalizedStringFromTable(@"IBLOrder.bizType.cableBreak", @"Main", "not found");
//    NSString  *orderBizOther = NSLocalizedStringFromTable(@"IBLOrder.bizType.other", @"Main", "not found");
//
//    NSDictionary *workOrderBizTypes = @{@(IBLWorkOrderBizStatusUnknow) : @"",
//                                        @(IBLWorkOrderBizStatusRepair) : orderBizRepair,
//                                        @(IBLWorkOrderBizStatusInstall) : orderBizInstall,
//                                        @(IBLWorkOrderBizStatusStop) : orderBizStop,
//                                        @(IBLWorkOrderBizStatusReturn) : orderBizReturn,
//                                        @(IBLWorkOrderBizStatusMove) : orderBizMove,
//                                        @(IBLWorkOrderBizStatusHandleMalfunction) : orderBizHandleMalfunction,
//                                        @(IBLWorkOrderBizStatusHandleComplaints) : orderBizHandleComplaints,
//                                        @(IBLWorkOrderBizStatusHandleAdvisory) : orderBizHandleAdvisory,
//                                        @(IBLWorkOrderBizStatusHandleReply) : orderBizHandleReply,
//                                        @(IBLWorkOrderBizStatusElectrical) : orderBizElectrical,
//                                        @(IBLWorkOrderBizStatusAddBox) : orderBizAddBox,
//                                        @(IBLWorkOrderBizStatusChangeBox) : orderBizChangeBox,
//                                        @(IBLWorkOrderBizStatusAddLock) : orderBizAddLock,
//                                        @(IBLWorkOrderBizStatusFlyLine) : orderBizFlyLine,
//                                        @(IBLWorkOrderBizStatusSplice) : orderBizSplice,
//                                        @(IBLWorkOrderBizStatusThroughCable) : orderBizThroughCable,
//                                        @(IBLWorkOrderBizStatusLightBarrier) : orderBizLightBarrier,
//                                        @(IBLWorkOrderBizStatusLineBarrier) : orderBizLineBarrier,
//                                        @(IBLWorkOrderBizStatusCableBreak) : orderBizCableBreak,
//                                        @(IBLWorkOrderBizStatusOther) : orderBizOther};
//    return workOrderBizTypes[@(status)];
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
    if ([segue.identifier isEqualToString:@"NavigationToUserDetail"]) {
        IBLUserDetailTableViewController *userDetailTableViewController = [segue destinationViewController];
        userDetailTableViewController.order = self.order;
    }
}


@end
