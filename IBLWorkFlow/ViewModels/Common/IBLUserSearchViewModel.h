//
//  IBLUserSearchViewModel.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/25/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLViewModel.h"

#import "IBLRegion.h"

/**
 *  检索用户类型
 */
typedef NS_ENUM(NSInteger,IBLUserSearchType) {
    /**
     *  续费检索用户
     */
    IBLUserSearchTypeRenew,
    /**
     *  更换销售品检索用户
     */
    IBLUserSearchTypeExchangeProduct,
    /**
     *  新增工单检索用户
     */
    IBLUserSearchTypeAddWorkOrder,
};


@interface IBLUserSearchResult : NSObject

@property (nonatomic, assign) IBLUserSearchType searchType;

@property (nonatomic, strong) IBLRegion *region;

@property (nonatomic, copy) NSString *account;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *userIdentifier;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, assign) NSInteger custType;

@property (nonatomic, copy) NSString *comName;

@property (nonatomic, copy) NSString *comContact;

@property(nonatomic, copy) NSString *comContactPhone;

+ (instancetype)resultWithSearchType:(IBLUserSearchType)searchType
                              region:(IBLRegion *)region
                             account:(NSString *)account
                            username:(NSString *)username
                               phone:(NSString *)phone
                      userIdentifier:(NSString *)userIdentifier
                             address:(NSString *)address;

@end

@interface IBLUserSearchViewModel : IBLViewModel

@property (nonatomic, readonly) IBLUserSearchType searchType;

- (instancetype)initWithSearchType:(IBLUserSearchType)searchType;

@end
