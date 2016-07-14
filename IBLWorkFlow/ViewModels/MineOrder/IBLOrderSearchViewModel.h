//
//  IBLOrderSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/14/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLListViewModel.h"
#import "IBLOrder.h"

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

@interface IBLOrderSearchViewModel : IBLListViewModel

@property(nonatomic, strong, readonly) IBLOrderSearchResult *searchResult;

- (instancetype)initWithSearchResult:(IBLOrderSearchResult *)searchResult;

+ (instancetype)modelWithSearchResult:(IBLOrderSearchResult *)searchResult;


@end
