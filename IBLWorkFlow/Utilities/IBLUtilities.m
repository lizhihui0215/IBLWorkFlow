//
//  IBLUtilities.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 10/10/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLUtilities.h"

@implementation IBLUtilities

+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    if (identityCard.length <= 0) return NO;
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^(((0\\d{2,3}-)?\\d{7,8})|(1[123456789]\\d{9}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}
@end
