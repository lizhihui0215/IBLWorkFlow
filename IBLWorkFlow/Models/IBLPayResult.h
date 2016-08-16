//
//  IBLPayResult.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 8/16/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLPayResult : IBLModel

@property (nonatomic, copy) NSString *codeUrl;

@property (nonatomic, assign) NSInteger orderNo;
@end
