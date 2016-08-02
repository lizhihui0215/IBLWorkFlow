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



@end

@implementation IBLCreateAccountHiddenFields

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createAccountHiddenFieldsDictionary = [self makeCreateAccountHiddenFieldsDictionary];
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


- (NSDictionary <NSIndexPath *, NSString *> *)createNotNullFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *notNullFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.notNullFields.createAccountFields) {
        NSIndexPath *hiddenIndexPath = self.createAccountAllFields[field];
        if (hiddenIndexPath) {
            notNullFields[field] = hiddenIndexPath;
        }
    }
    
    return notNullFields;
}

- (NSDictionary <NSIndexPath *, NSString *> *)makeCreateAccountHiddenFieldsDictionary{
    IBLAppConfiguration *app = [IBLAppRepository appConfiguration];
    
    NSMutableDictionary *hiddenFields = [NSMutableDictionary dictionary];
    
    for (NSString *field in app.hiddenFields.createAccountFields) {
        NSIndexPath *hiddenIndexPath = self.createAccountAllFields[field];
        if (hiddenIndexPath) {
            hiddenFields[hiddenIndexPath] = field;
        }
    }
    
    return hiddenFields;
}
@end
