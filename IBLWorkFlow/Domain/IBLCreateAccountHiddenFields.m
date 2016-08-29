//
//  IBLCreateAccountHiddenFields.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/21/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLCreateAccountHiddenFields.h"
#import "IBLAppRepository.h"

@interface IBLCreateAccountHiddenFields ()

@property (nonatomic, readonly) NSDictionary *createAccountAllFields;

@property (nonatomic, readonly) NSDictionary *exchangeProductAllFields;

@property (nonatomic, readonly) NSDictionary *renewAllFields;

@end

@implementation IBLCreateAccountHiddenFields

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createAccountHiddenFieldsDictionary = [self makeCreateAccountHiddenFieldsDictionary];
        
        self.exchangeProductHiddenFieldsDictionary = [self makeExchangeProductHiddenFieldsDictionary];
        
        self.renewHiddenFieldsDictionary = [self makeRenewHiddenFieldsDictionary];
    }
    return self;
}

- (NSDictionary *)createAccountAllFields{
    
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:1 inSection:1];
    NSIndexPath *custIdCard = [NSIndexPath indexPathForRow:3 inSection:1];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:4 inSection:1];
    NSIndexPath *custAddress = [NSIndexPath indexPathForRow:2 inSection:1];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:2 inSection:2];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:3 inSection:2];
    return  @{@"custName" : custNameIndexPath,
              @"custPhone" : custPhone  ,
              @"custIdCard" : custIdCard,
              @"custReserve" : custReserve,
              @"custAddress": custAddress,
              @"contractCode": contractCode,
              @"voiceCode" : voiceCode,
              @"contractCode_cfield" : contractCode,
              @"voiceCode_cfield": voiceCode,};
}

- (NSDictionary *)exchangeProductAllFields{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:0 inSection:19];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:0 inSection:13];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:0 inSection:14];
    return  @{@"custName" : custNameIndexPath,
              @"custPhone" : custPhone  ,
              @"custReserve" : custReserve,
              @"contractCode": contractCode,
              @"voiceCode" : voiceCode,
              @"contractCode_cfield" : contractCode,
              @"voiceCode_cfield": voiceCode,};
}


- (NSDictionary *)renewAllFields{
    NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    NSIndexPath *custPhone = [NSIndexPath indexPathForRow:0 inSection:3];
    NSIndexPath *custReserve = [NSIndexPath indexPathForRow:0 inSection:16];
    NSIndexPath *contractCode = [NSIndexPath indexPathForRow:0 inSection:12];
    NSIndexPath *voiceCode = [NSIndexPath indexPathForRow:0 inSection:11];
    return  @{@"custName" : custNameIndexPath,
              @"custPhone" : custPhone  ,
              @"custReserve" : custReserve,
              @"contractCode": contractCode,
              @"voiceCode" : voiceCode,
              @"contractCode_cfield" : contractCode,
              @"voiceCode_cfield": voiceCode,};
}



- (NSDictionary <NSIndexPath *, NSNumber *> *)createAccountNotNullFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *notNullFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.notNullFields.createAccountFields) {
        NSIndexPath *notNullIndexPath = self.createAccountAllFields[field];
        
        NSNumber *isNull = notNullIndexPath == nil ? @(NO) : @(YES);
        
        notNullFields[field] = isNull;
    }
    
    return notNullFields;
}

- (NSDictionary <NSIndexPath *, NSNumber *> *)makeExchangeProductHiddenFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *hiddenFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.hiddenFields.changeProductFields) {
        NSIndexPath *hiddenIndexPath = self.exchangeProductAllFields[field];
        
        NSNumber *isHidden = hiddenIndexPath == nil ? @(NO) : @(YES);
        
        hiddenFields[hiddenIndexPath] = isHidden;
    }
    
    return hiddenFields;
}

- (NSDictionary <NSIndexPath *, NSNumber *> *)exchangeProductNotNullFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *notNullFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.notNullFields.createAccountFields) {
        NSIndexPath *notNullIndexPath = self.exchangeProductAllFields[field];
        
        NSNumber *isNull = notNullIndexPath == nil ? @(NO) : @(YES);
        
        notNullFields[field] = isNull;
    }
    
    return notNullFields;
}

- (NSDictionary <NSIndexPath *, NSNumber *> *)makeCreateAccountHiddenFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *hiddenFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.hiddenFields.changeProductFields) {
        NSIndexPath *hiddenIndexPath = self.createAccountAllFields[field];
        
        NSNumber *isHidden = hiddenIndexPath == nil ? @(NO) : @(YES);
        
        hiddenFields[hiddenIndexPath] = isHidden;
    }
    
    if (app.genarate.type || [app.genarate.type integerValue] != 5) {
        NSIndexPath *custNameIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        NSIndexPath *password = [NSIndexPath indexPathForRow:1 inSection:0];
        hiddenFields[custNameIndexPath] = @(YES);
        hiddenFields[password] = @(YES);
    }
    
    return hiddenFields;
}

- (NSDictionary <NSIndexPath *, NSNumber *> *)makeRenewHiddenFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *hiddenFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.hiddenFields.renewFields) {
        NSIndexPath *hiddenIndexPath = self.renewAllFields[field];
        NSNumber *isHidden = hiddenIndexPath == nil ? @(NO) : @(YES);
        
        hiddenFields[hiddenIndexPath] = isHidden;
    }
    
    return hiddenFields;
}


- (NSDictionary<NSIndexPath *, NSNumber *> *)renewNotNullFieldsDictionary {
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *notNullFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.notNullFields.renewFields) {
        NSIndexPath *notNullIndexPath = self.renewAllFields[field];
        
        NSNumber *isNull = notNullIndexPath == nil ? @(NO) : @(YES);
        
        notNullFields[field] = isNull;
    }
    
    return notNullFields;
}
@end
