//
//  NSDate+IBLExtension.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/15/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "NSDate+IBLExtension.h"

@implementation NSDate (IBLExtension)

- (NSString *)stringFromFormatter:(NSString *)fomatter{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fomatter];
    return [formatter stringFromDate:self];
}

@end
