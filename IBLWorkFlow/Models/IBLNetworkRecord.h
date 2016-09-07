//
//  IBLNetworkRecord.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 07/09/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLModel.h"

@interface IBLNetworkRecord : IBLModel
/// 账号
@property (nonatomic, copy) NSString *username;
/// 用户
@property (nonatomic, copy) NSString *userIP;
/// mac地址
@property (nonatomic, copy) NSString *MACAddress;
/// nas ip
@property (nonatomic, copy) NSString *NASIP;
/// 会话状态
@property (nonatomic, copy) NSString *scriptType;
/// 处理结果
@property (nonatomic, copy) NSString *errorCode;
/// 描述信息
@property (nonatomic, copy) NSString *errorMessage;
/// 处理时间
@property (nonatomic, copy) NSString *lastModifyDate;
@end
