//
//  IBLOrderSearchViewController.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLTableViewController.h"
#import "IBLOrderSearchViewModel.h"
#import "IBLOrder.h"

@class IBLOrderSearchViewController;
@class IBLOrderSearchResult;

@protocol IBLOrderSearchDelegate <NSObject>

- (void)orderSearchViewController:(IBLOrderSearchViewController *)searchViewController
                  didSearchResult:(IBLOrderSearchResult *)searchResult;

@end

@interface IBLOrderSearchResult : NSObject;

@property (nonatomic, assign) IBLOrderStatus status;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *bizType;

@property (nonatomic, copy) NSString *dateRange;

+ (instancetype)initWithStatus:(IBLOrderStatus)status
             resultWithAccount:(NSString *)account
                      username:(NSString *)username
                         phone:(NSString *)phone
                          type:(NSString *)type
                       bizType:(NSString *)bizType
                     dateRange:(NSString *)dateRange;

@end

@interface IBLOrderSearchViewController : IBLTableViewController

@property (nonatomic, strong) IBLOrderSearchViewModel *viewModel;

@property (nonatomic, weak) id<IBLOrderSearchDelegate> delegate;
@end
