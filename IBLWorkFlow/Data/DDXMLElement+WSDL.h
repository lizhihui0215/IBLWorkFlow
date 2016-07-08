//
//  DDXMLElement+WSDL.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 7/7/16.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <KissXML/DDXML.h>

@interface DDXMLElement (WSDL)

+ (instancetype)elementWithFileName:(NSString *)fileName;

+ (instancetype)childWithName:(NSString *)name parent:(DDXMLElement *)parent;

+ (NSArray<DDXMLElement *> *)chindsWithName:(NSString *)name parent:(DDXMLElement *)parent;
@end
