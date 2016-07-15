//
//  IBLPickerView.h
//  IBLPickerView
//
//  Created by Madjid Mahdjoubi on 6/5/13.
//  Copyright (c) 2013 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CMCCbackgroundColor;
extern NSString * const CMCCtextColor;
extern NSString * const CMCCtoolbarColor;
extern NSString * const CMCCbuttonColor;
extern NSString * const CMCCfont;
extern NSString * const CMCCvalueY;
extern NSString * const CMCCselectedObject;
extern NSString * const CMCCtoolbarBackgroundImage;

@interface IBLPickerView : UIView

+(void)showPickerViewInView: (UIView *)view
                withStrings: (NSArray *)strings
                withOptions: (NSDictionary *)options
                 completion: (void(^)(NSString *selectedString))completion;

+(void)showPickerViewInView: (UIView *)view
                withObjects: (NSArray *)objects
                withOptions: (NSDictionary *)options
    objectToStringConverter: (NSString *(^)(id object))converter
       completion: (void(^)(id selectedObject))completion;

+(void)dismissWithCompletion: (void(^)(NSString *))completion;

@end
