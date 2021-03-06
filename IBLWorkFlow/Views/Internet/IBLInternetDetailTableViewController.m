//
//  IBLInternetDetailTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLInternetDetailTableViewController.h"

@interface IBLInternetDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *IPTextField;
@property (weak, nonatomic) IBOutlet UITextField *MACAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *BASAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *scriptTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *handleDateTextField;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *IPLabel;
@property (weak, nonatomic) IBOutlet UILabel *MACAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *BASLabel;
@property (weak, nonatomic) IBOutlet UILabel *scriptLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleDateLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation IBLInternetDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountTextField.text = self.networkRecord.username;
    self.IPTextField.text = self.networkRecord.userIP;
    self.MACAddressTextField.text = self.networkRecord.MACAddress;
    self.BASAddressTextField.text = self.networkRecord.NASIP;
    self.scriptTextField.text = self.networkRecord.scriptType;
    self.descriptionTextField.text = self.networkRecord.errorMessage;
    self.handleDateTextField.text = self.networkRecord.lastModifyDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)languageDidChanged:(NSNotification *)notification {
    self.navigationItem.title = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.title", @"Main", "not found");
    self.accountLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.accountLabel.text", @"Main", "not found");
    self.IPLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.IPLabel.text", @"Main", "not found");
    self.MACAddressLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.MACAddressLabel.text", @"Main", "not found");
    self.BASLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.BASLabel.text", @"Main", "not found");
    self.scriptLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.scriptLabel.text", @"Main", "not found");
    self.descriptionLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.descriptionLabel.text", @"Main", "not found");
    self.handleDateLabel.text = NSLocalizedStringFromTable(@"IBLInternetDetailTableViewController.handleDateLabel.text", @"Main", "not found");
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
