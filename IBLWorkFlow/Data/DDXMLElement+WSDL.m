//
//  DDXMLElement+WSDL.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "DDXMLElement+WSDL.h"

@interface Schema : NSObject

@property (nonatomic, strong) DDXMLElement *schema;

@property (nonatomic, readonly) NSString *targetNamespace;

@property (nonatomic, readonly) NSArray *elements;

@end

@implementation Schema



@end

@implementation DDXMLElement (WSDL)

+ (instancetype)elementWithFileName:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    DDXMLDocument *document = [[DDXMLDocument alloc] initWithData:data options:0 error:nil];
    return document.rootElement;
}

- (instancetype)childWithName:(NSString *)name parent:(DDXMLElement *)parent{
    return [parent elementsForName:name].firstObject;
}

- (NSArray<DDXMLElement *> *)chindsWithName:(NSString *)name parent:(DDXMLElement *)parent{
    
    NSArray *elements = [parent elementsForName:name];
    
    if (elements.firstObject) return elements;
    
    return nil;
}

- (instancetype)type{
    return [self childWithName:@"types" parent:self];
}

- (instancetype)schema{
    return [self childWithName:@"schema" parent:self];
}

- (NSString *)schemaTargetNamespace{
    DDXMLElement *schema = [self schema];
    
    if (!schema) return nil;
    
    return [[schema attributeForName:@"targetNamespace"] stringValue];
}


- (instancetype)schemaElements{
    return [self childWithName:@"element" parent:self];
}

@end



