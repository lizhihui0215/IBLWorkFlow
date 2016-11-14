//
//  IBLFileManager.h
//  IBLWorkFlow
//
//  Created by 李智慧 on 14/11/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IBLFileManager : NSObject

+ (instancetype)sharedManager;

+ (BOOL)itemExistsAtPath:(NSString *)aPath;

+ (BOOL)createDictionaryAtPath:(NSString *)aPath error:(NSError **)pError;

+ (BOOL)removeItemAtPath:(NSString *)aPath error:(NSError **)error;

+ (NSString *)pathForApplicationSupportDirectory;

+ (NSString *)pathForCachesDirectory;

+ (NSString *)pathForDocumentsDirectory;

+ (NSString *)pathForLibraryDirectory;

+ (NSString *)pathForTemporaryDirectory;

+ (NSString *)patchForUserCacheFile;

+ (void)setup;
@end

NS_ASSUME_NONNULL_END
