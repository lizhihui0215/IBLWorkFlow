//
//  IBLOrderFlow.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 9/4/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLOrderFlow : IBLModel
/// 当前状态
@property (nonatomic, assign) NSInteger state;
/// 处理人姓名
@property (nonatomic, copy) NSString *operatorName;
/// 处理人电话
@property (nonatomic, copy) NSString *operatorPhone;
/// 处理时间(String，格式yyyy-MM-dd HH:mm:ss)
@property (nonatomic, copy) NSString *creatorTime;
/// 完成时间(String，格式yyyy-MM-dd HH:mm:ss)
@property (nonatomic, copy) NSString *finishedTime;
/// 处理建议
@property (nonatomic, copy) NSString *handleSuggest;
/// 处理说明
@property (nonatomic, copy) NSString *handleNote;

@end
