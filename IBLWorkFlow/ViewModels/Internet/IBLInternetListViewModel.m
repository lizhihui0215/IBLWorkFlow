//
//  IBLInternetListViewModel.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLInternetListViewModel.h"

@interface IBLInternetListViewModel ()
{
    NSMutableArray<IBLSection *> *_dataSource;
}
@property (nonatomic, copy, readwrite) NSString *account;

@property (nonatomic, copy, readwrite) NSString *date;

@property (nonatomic, strong) IBLFetchOnlineRecord *fetchOnlineRecords;


@end

@implementation IBLInternetListViewModel

- (instancetype)initWithAccount:(NSString *)account date:(NSString *)date
{
    self = [super init];
    if (self) {
        self.account = account;
        self.date = date;
        self.fetchOnlineRecords = [[IBLFetchOnlineRecord alloc] init];
        IBLSection *section = [IBLSection sectionWithInfo:nil items:nil];
        
        self.dataSource = [@[section] mutableCopy];
    }
    return self;
}

- (void)setDataSource:(NSMutableArray<IBLSection *> *)dataSource{
    _dataSource = dataSource;
}

- (NSMutableArray<IBLSection *> *)dataSource{
    return _dataSource;
}

- (void)fetchRecoredsWithIsRefresh:(BOOL)isRefresh
                   completeHandler:(IBLViewModelCompleteHandler)handler{
    [self.fetchOnlineRecords fetchOnlineWithAccount:self.account
                                               date:self.date
                                          isRefresh:isRefresh
                                    completeHandler:^(NSArray<IBLNetworkRecord *> *records, NSError *error) {
                                        NSMutableArray<IBLSectionItem *> *items = [self itemsWithRecords:records];
                                        if (isRefresh)
                                            [self sectionAt:0].items = items;
                                        else
                                            [[self sectionAt:0].items addObjectsFromArray:items];
                                        handler(error);
                                    }];
}

- (NSMutableArray<IBLSectionItem *> *)itemsWithRecords:(NSArray<IBLNetworkRecord *> *)records{
    NSMutableArray<IBLSectionItem *> *items = [NSMutableArray array];
    for (IBLNetworkRecord *networkRecord in records) {
        IBLSectionItem *item = [IBLSectionItem itemWithInfo:networkRecord selected:NO];
        [items addObject:item];
    }
    
    return items;
}

- (IBLNetworkRecord *)networkRecordAtIndexPath:(NSIndexPath *)indexPath{
    IBLSectionItem *sectionItem = [self sectionItemAtIndexPath:indexPath];
    return sectionItem.info;
}

- (NSString *)scriptTypeAtIndexPath:(NSIndexPath *)indexPath {
   IBLNetworkRecord *networkRecord = [self networkRecordAtIndexPath:indexPath];
    return [NSString stringWithFormat:@"[%@]",networkRecord.scriptType];
}

- (NSString *)usernameAtIndexPath:(NSIndexPath *)indexPath {
    IBLNetworkRecord *networkRecord = [self networkRecordAtIndexPath:indexPath];

    return networkRecord.username;
}

- (NSString *)handleResultAtIndexPath:(NSIndexPath *)indexPath {
    IBLNetworkRecord *networkRecord = [self networkRecordAtIndexPath:indexPath];

    return networkRecord.errorMessage;
}

- (UIImage *)handleStatusImageAtIndexPath:(NSIndexPath *)indexPath {
    IBLNetworkRecord *networkRecord = [self networkRecordAtIndexPath:indexPath];
    
    NSString *imageName = @"";
    if([networkRecord.errorCode isEqualToString:@"0"]){
        imageName = @"success";
    }else{
        imageName = @"error";
    }
    
    return [UIImage imageNamed:imageName];
}

- (NSString *)lastModifyDateAtIndexPath:(NSIndexPath *)indexPath {
    IBLNetworkRecord *networkRecord = [self networkRecordAtIndexPath:indexPath];

    return networkRecord.lastModifyDate;
}
@end
