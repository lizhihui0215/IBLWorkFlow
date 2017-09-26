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
    NSString *regex2 = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
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

+ (BOOL)validateDomain:(NSString *)domain{
//    NSString *domainRegex = @"^[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\\.?(:\\d{0,5})?$";
    
//    NSString *domainRegex = @"^(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]):\\d{0,5}$|^(http(s)?:\\/\\/)?([A-Za-z0-9]+\\.)?[\\w-]+\\.\\w{2,4}(\\/)?$";
    
    NSString *domainRegex = @"(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9]):\\d{0,5}$|^(http(s)?:\\/\\/)?([A-Za-z0-9]+\\.)?[\\w-]+\\.\\w{2,4}(\\/)?:\\d{0,5}";
    
    NSPredicate *domainTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",domainRegex];

    return [domainTest evaluateWithObject:domain];
}
@end
