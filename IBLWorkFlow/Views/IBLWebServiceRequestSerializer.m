//
//  IBLWebServiceRequestSerializer.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWebServiceRequestSerializer.h"
#import "IBLWSDLServices.h"

@interface IBLWebServiceRequestSerializer ()

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, strong) IBLWSDLServices *WSDLServices;

@property (nonatomic, strong) NSString *methodName;
@end

@implementation IBLWebServiceRequestSerializer
+ (instancetype)serializerWithFilename:(NSString *)fileName methodName:(NSString *)methodName{
    IBLWebServiceRequestSerializer * webServiceRequestSerializer = [[IBLWebServiceRequestSerializer alloc] initFileName:fileName methodName:methodName];
    
    return webServiceRequestSerializer;
}

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    if (parameters) {
        if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
            [mutableRequest setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        }
        
        NSString *xml = [self.WSDLServices buildSOAPWithMethodName:self.methodName parameters:parameters];
        
        NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
        
        [mutableRequest setHTTPBody:data];
    }
    
    return mutableRequest;
}

- (instancetype)initFileName:(NSString *)fileName
                  methodName:(NSString *)methodName
{
    self = [super init];
    if (self) {
        IBLWSDLServices *services = [[IBLWSDLServices alloc] initWithFilename:fileName];
        
        self.WSDLServices = services;
        
        self.methodName = methodName;
    }
    return self;
}
@end
