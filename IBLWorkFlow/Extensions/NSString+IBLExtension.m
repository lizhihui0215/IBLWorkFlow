//
//  NSString+IBLExtension.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "NSString+IBLExtension.h"

@implementation NSString (IBLExtension)
+ (BOOL)isNull:(NSString *)string{
    if(!string) return YES;
    
    if([string isKindOfClass:[NSString class]]){
        if ([string isEqualToString:@""]) return YES;
    }
    
    return NO;
}
@end
