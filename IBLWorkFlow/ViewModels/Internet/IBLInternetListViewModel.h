//
//  IBLInternetListViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "PCCWListViewModel.h"
#import "IBLFetchOnlineRecord.h"

@interface IBLInternetListViewModel : PCCWListViewModel

@property (nonatomic, copy, readonly) NSString *account;

@property (nonatomic, copy, readonly) NSString *date;

- (instancetype)initWithAccount:(NSString *)account date:(NSString *)date;

- (void)fetchRecoredsWithIsRefresh:(BOOL)isRefresh
                   completeHandler:(PCCWViewModelCompleteHandler)handler;

- (NSString *)scriptTypeAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)handleResultAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)handleStatusImageAtIndexPath:(NSIndexPath *)indexPath;

- (NSString *)lastModifyDateAtIndexPath:(NSIndexPath *)indexPath;

- (IBLNetworkRecord *)networkRecordAtIndexPath:(NSIndexPath *)indexPath;
@end
