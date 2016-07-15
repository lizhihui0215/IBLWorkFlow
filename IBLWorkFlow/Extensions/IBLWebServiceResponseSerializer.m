//
//  IBLWebServiceResponseSerializer.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/11/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWebServiceResponseSerializer.h"
#import "IBLWSDLServices.h"
static NSString * const kCode = @"resultCode";

static NSString * const kMessage = @"respMsg";

static NSError * AFErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}

static BOOL AFErrorOrUnderlyingErrorHasCodeInDomain(NSError *error, NSInteger code, NSString *domain) {
    if ([error.domain isEqualToString:domain] && error.code == code) {
        return YES;
    } else if (error.userInfo[NSUnderlyingErrorKey]) {
        return AFErrorOrUnderlyingErrorHasCodeInDomain(error.userInfo[NSUnderlyingErrorKey], code, domain);
    }
    
    return NO;
}

@interface IBLWebServiceResponseSerializer ()
@property (nonatomic, strong) IBLWSDLServices *WSDLServices;

@property (nonatomic, strong) NSString *methodName;

@end


@implementation IBLWebServiceResponseSerializer


+ (instancetype)serializerWithMethodName:(NSString *)methodName{
    return [[self alloc] initWithMethodName:methodName];
}

- (instancetype)initWithMethodName:(NSString *)methodName
{
    self = [super init];
    if (self) {
                
        self.methodName = methodName;
        
        self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/xml", nil];
        
    }
    return self;
}

#pragma mark - AFURLResponseSerialization

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error || AFErrorOrUnderlyingErrorHasCodeInDomain(*error, NSURLErrorCannotDecodeContentData, AFURLResponseSerializationErrorDomain)) {
            return nil;
        }
    }
    
    id responseObject = nil;
    NSError *serializationError = nil;
    // Workaround for behavior of Rails to return a single space for `head :ok` (a workaround for a bug in Safari), which is not interpreted as valid input by NSJSONSerialization.
    // See https://github.com/rails/rails/issues/1742
    BOOL isSpace = [data isEqualToData:[NSData dataWithBytes:" " length:1]];
    if (data.length > 0 && !isSpace) {
        NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString *resultString = [IBLWSDLServices SOAPResultWithMethodName:self.methodName data:stringData];
        
        if (resultString) {
            NSData *JSONData = [resultString dataUsingEncoding:NSUTF8StringEncoding];
            
            responseObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:&serializationError];
            
            *error = [self handleErrorWithResponseObject:responseObject];
        }else{
           NSString *message = [NSString stringWithFormat:@"Message part %@ was not recognized.  (Does it exist in service WSDL?)",self.methodName];
            *error = [NSError errorWithDomain:@""
                                         code:0
                                     userInfo:@{kExceptionCode : [@(-1) stringValue],
                                                kExceptionMessage: message}];
        }
        
        if (*error) responseObject = nil;
    } else {
        return nil;
    }

    if (error) {
        *error = AFErrorWithUnderlyingError(serializationError, *error);
    }
    
    return responseObject;
}

- (NSError *)handleErrorWithResponseObject:(id)responseObject{
    NSInteger code = [responseObject[kCode] integerValue];
    
    NSError *error = nil;
    
    if (code != 0) {
        NSString *message = responseObject[kMessage] ? : @"";
        
        error = [NSError errorWithDomain:@""
                                    code:0
                                userInfo:@{kExceptionCode : [@(code) stringValue],
                                           kExceptionMessage: message}];
    }
    
    return error;
}
@end
