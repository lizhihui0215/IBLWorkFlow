//
//  IBLUtilities.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBLUtilities : NSObject


/**
 身份证号码校验

 @param identityCard 身份证号码

 @return 是否验证通过
 */
+ (BOOL) validateIdentityCard: (NSString *)identityCard;


/**
 电话号码校验

 @param mobile 电话号码

 @return 是否验证通过
 */
+ (BOOL) validateMobile:(NSString *)mobile;


@end
