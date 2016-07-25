//
//  IBLUserSearchTableViewController.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUserSearchTableViewController.h"
#import "IBLUserSearchResultViewController.h"

@interface IBLUserSearchTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *userIdentifierTextField;
@property (weak, nonatomic) IBOutlet UITextField *regionTextField;

@property(nonatomic, strong) IBLRegion *region;

@property (nonatomic, strong) IBLUserSearchResult *searchResult;
@end

@implementation IBLUserSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)regionTapped:(UITapGestureRecognizer *)sender {
    
}

- (IBAction)searchButtonPressed:(UIButton *)sender {
    
    IBLUserSearchType type = [self.delegate userSearchType];
    
    NSString *account = [NSString isNull:self.accountTextField.text]  ? nil : self.accountTextField.text;
    
    NSString *username = [NSString isNull:self.usernameTextField.text]  ? nil : self.usernameTextField.text;
    
    NSString *phone = [NSString isNull:self.phoneTextField.text]  ? nil : self.phoneTextField.text;
    
    self.searchResult = [IBLUserSearchResult resultWithSearchType:type region:self.region account:account username:username phone:phone userIdentifier:nil address:nil];
    
    [self.delegate userSearchTableViewController:self didEndSearch:self.searchResult];
    
    [self performSegueWithIdentifier:@"NavigationToResult" sender:self];
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
    
    IBLUserSearchType type = [self.delegate userSearchType];
    
    IBLUserSearchResultViewController *searchResultViewController = [segue destinationViewController];

    searchResultViewController.viewModel = [IBLUserSearchResultViewModel modelWithSearchType:type
                                                                                searchResult:self.searchResult];
    
}


@end
