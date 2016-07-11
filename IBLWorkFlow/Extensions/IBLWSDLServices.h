//
//  IBLWSDLServices.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBLWSDLSchema : NSObject

@end

@interface IBLWSDLMessage : NSObject

@end

@interface IBLWSDLServices : NSObject

- (instancetype)initWithFilename:(NSString *)filename;

- (NSString *)buildSOAPWithMethodName:(NSString *)methodName
                           parameters:(NSDictionary *)aParameters;

+ (NSString *)SOAPResultWithMethodName:(NSString *)methodName data:(NSString *)data;
@end
