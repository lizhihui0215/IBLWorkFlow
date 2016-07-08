//
//  IBLWSDLServices.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/8/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLWSDLServices.h"
#import "DDXMLElement+WSDL.h"

@interface IBLWSDLMessage ()
@property (nonatomic, strong) NSArray<DDXMLElement *> *messages;

@property (nonatomic, strong) DDXMLElement *root;

+ (instancetype)messageWithElement:(DDXMLElement *)element;

- (DDXMLElement *)messageWithName:(NSString *)name;

- (DDXMLElement *)partWithMethodName:(NSString *)methodName;
@end

@interface IBLWSDLServices ()

@property (nonatomic, copy) NSString *fileName;

@property (nonatomic, readonly) DDXMLElement *types;

@property (nonatomic, strong) DDXMLElement *rootElement;

@property (nonatomic, strong) IBLWSDLSchema *schema;

@property (nonatomic, strong) IBLWSDLMessage *message;

@end

@interface IBLWSDLSchema ()

/** definitions->types->schema */
@property (nonatomic, strong) DDXMLElement *schema;

//definitions->types->schema(targetNamespace)
@property (nonatomic, readonly) NSString *targetNamespace;

//definitions->types->schema->element
@property (nonatomic, readonly) NSArray *elements;

@property (nonatomic, readonly) NSArray *complexTypes;

/**
 *  definitions->types->schema->element name="***"
 *
 *  @param attributeName the attribute name of the element
 *
 *  @return the element which's name match attributeName
 */
- (DDXMLElement *)elementWithAttributeName:(NSString *)attributeName;

/**
 *  definitions->types->schema->element->complextype
 *
 *  @param name element attribute name
 *
 *  @return complexty
 */
- (DDXMLElement *)complextypeWithName:(NSString *)name;

/**
 *  definitions->types->schema->element->complextype->sequence
 *
 *  @param name complextype name
 *
 *  @return sequence
 */
- (DDXMLElement *)sequenceWithName:(NSString *)name;

/**
 *  definitions->types->schema->element->complextype->sequence->element
 *
 *  @param name complextype name
 *
 *  @return elements of sequence
 */
- (NSArray *)parameterWithName:(NSString *)name;

/**
 *  definitions->types->schema->element->complextype->sequence->element->name
 *
 *  @param methodName complextype name
 *
 *  @return parameters
 */
- (NSArray *)parametersWithMethodName:(NSString *)methodName;

+ (instancetype)schemaWithElement:(DDXMLElement *)element;

@end

@implementation IBLWSDLMessage

+ (instancetype)messageWithElement:(DDXMLElement *)element{
    return [[[self class] alloc] initWithElement:element];
}

- (instancetype)initWithElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        self.root = element;
        self.messages = [DDXMLElement chindsWithName:@"message" parent:self.root];
    }
    return self;
}

- (DDXMLElement *)messageWithName:(NSString *)name{
    if (!self.messages) return nil;
    
    for (DDXMLElement *message in self.messages) {
        NSString *value = [[message attributeForName:@"name"] stringValue];
        if ([value isEqualToString:name]) {
            return message;
        }
    }
    
    return nil;
}

- (DDXMLElement *)partWithMethodName:(NSString *)methodName{
    DDXMLElement *message = [self messageWithName:methodName];
    
    if (!message) return nil;
    
    return [DDXMLElement childWithName:@"part" parent:message];
}

- (NSString *)parametersWithMethodName:(NSString *)methodName{
    DDXMLElement *part = [self partWithMethodName:methodName];
    
    if (!part) return nil;
    
    NSString *parametersString = [[part attributeForName:@"element"] stringValue];
    
    NSArray *parameters = [parametersString componentsSeparatedByString:@":"];
    
    return [parameters lastObject];
}

@end

@implementation IBLWSDLServices

- (instancetype)initWithFilename:(NSString *)filename
{
    self = [super init];
    if (self) {
        self.fileName = filename;
        
        self.rootElement = [DDXMLElement elementWithFileName:self.fileName];
        
        DDXMLElement *elementOfSchema = [DDXMLElement childWithName:@"schema" parent:self.types];
        
        IBLWSDLSchema *schema = [IBLWSDLSchema schemaWithElement:elementOfSchema];
        
        self.schema = schema;
        
        IBLWSDLMessage *message = [IBLWSDLMessage messageWithElement:self.rootElement];
        
        self.message = message;
    }
    return self;
}

/**
 *  definitions->types
 *
 *  @return
 */
- (DDXMLElement *)types{
    return [DDXMLElement childWithName:@"types" parent:self.rootElement];
}

+ (instancetype)servicesWithFilename:(NSString *)filename{
    return [[[self class] alloc] initWithFilename:filename];
}

- (NSString *)buildSOAPWithMethodName:(NSString *)methodName
                           parameters:(NSDictionary *)aParameters{
//    <?xml version="1.0" encoding="utf-8"?>
//    
//    <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
//    <soap:Header/>
//    <soap:Body>
//    <ns1:openAccount xmlns:ns1="http://webserver.module.miniboss.com/">
//    <arg0>{ "sessionId": "1467966308", "mCode": "123123231", "phoneModel": "18710427975", "osVersion": "1.0", "authId": "asdj", "loginName": "sysadmin", "password": "12345678", "sign": "xxxxxxx" }</arg0>
//    </ns1:openAccount>
//    </soap:Body>
//    </soap:Envelope>

    
    DDXMLElement *root = [DDXMLElement elementWithName:@"soap:Envelope"];
    
    [root addNamespace:[DDXMLNode namespaceWithName:@"soap" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"]];
    
    DDXMLElement *header = [DDXMLElement elementWithName:@"soap:Header"];
    
    DDXMLElement *body = [DDXMLElement elementWithName:@"soap:Body"];
    
    // namespace
    DDXMLNode *namespace = [DDXMLNode namespaceWithName:@"ns1" stringValue:self.schema.targetNamespace];
    
    // message
    DDXMLElement *message = [DDXMLElement elementWithName:[self.message parametersWithMethodName:methodName]];
    
    [message addNamespace:namespace];
    
    // parameters
    NSArray *parameters = [self.schema parametersWithMethodName:methodName];
    
    for (NSString *parameter in parameters) {
        NSString *value = aParameters[parameter];
        DDXMLElement *paranode = [DDXMLElement elementWithName:parameter stringValue:value];
        [message addChild:paranode];
    }
    
    [body addChild:message];
    [root addChild:header];
    [root addChild:body];
    return [root XMLString];
}

@end

@implementation IBLWSDLSchema

+ (instancetype)schemaWithElement:(DDXMLElement *)element{
    return [[[self class] alloc] initWithElement:element];
}

- (instancetype)initWithElement:(DDXMLElement *)element
{
    self = [super init];
    if (self) {
        self.schema = element;
    }
    return self;
}

- (NSString *)targetNamespace{
    return [[self.schema attributeForName:@"targetNamespace"] stringValue];
}

- (NSArray *)elements{
    return [DDXMLElement chindsWithName:@"element" parent:self.schema];
}

- (NSArray *)complexTypes{
    return [DDXMLElement chindsWithName:@"complexType" parent:self.schema];
}

- (DDXMLElement *)elementWithAttributeName:(NSString *)attributeName{
    for (DDXMLElement *element in self.elements) {
        NSString *methodName = [[element attributeForName:@"name"] stringValue];
        if ([methodName isEqualToString:attributeName]) {
            return element;
        }
    }
    
    return nil;
}

- (DDXMLElement *)complextypeWithName:(NSString *)name{
    //!!!: 服务器不符合标准的SOAP
//    DDXMLElement *element = [self elementWithAttributeName:name];
//    return [DDXMLElement childWithName:@"complexType" parent:element];

    for (DDXMLElement *complexType in self.complexTypes) {
        NSString *complexTypeName = [[complexType attributeForName:@"name"] stringValue];
        if ([complexTypeName isEqualToString:name]) {
            return complexType;
        }
    }
    
    return nil;
}

- (DDXMLElement *)sequenceWithName:(NSString *)name{
    DDXMLElement *complextype = [self complextypeWithName:name];
    return [DDXMLElement childWithName:@"sequence" parent:complextype];
}

- (NSArray *)parameterWithName:(NSString *)name{
    DDXMLElement *sequence = [self sequenceWithName:name];
    return [sequence children];
}

- (NSArray *)parametersWithMethodName:(NSString *)methodName{
    NSMutableArray *parameters = [NSMutableArray array];
    for (DDXMLElement *element in [self parameterWithName:methodName]) {
        NSString *parameter = [[element attributeForName:@"name"] stringValue];
        [parameters addObject:parameter];
    }
    
    return parameters;
}

@end
