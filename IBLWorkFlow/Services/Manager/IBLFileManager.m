//
//  IBLFileManager.m
//  IBLWorkFlow
//
//  Created by 李智慧 on 14/11/2016.
//  Copyright © 2016 IBL. All rights reserved.
//

#import "IBLFileManager.h"



@implementation IBLFileManager

+ (instancetype)sharedManager {
    static IBLFileManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark AccessFile
///----------------------------
/// @name Query File
///----------------------------
+ (BOOL)itemExistsAtPath:(NSString *)aPath {
    return [[NSFileManager defaultManager] fileExistsAtPath:aPath];
}

#pragma mark Create
///----------------------------
/// @name Create File or Dictionary
///----------------------------
/*!
 *  Creates a directory with given attributes at the specified path.
 *
 *  @param aPath  A path string identifying the directory to create.
 *  You may specify a full path or a path that is relative to the current working directory.
 *  This parameter must not be nil.
 *  @param pError On input, a pointer to an error object.
 *  If an error occurs, this pointer is set to an actual error object containing the error information.
 *  You may specify nil for this parameter if you do not want the error information.
 *
 *  @return YES if the directory was created, YES if createIntermediates is set and the directory already exists), or NO if an error occurred.
 */
+ (BOOL)createDictionaryAtPath:(NSString *)aPath error:(NSError **)pError {
    [IBLFileManager assertPath:aPath];
    if ([IBLFileManager itemExistsAtPath:aPath]) return YES;
    return [[NSFileManager defaultManager] createDirectoryAtPath:aPath withIntermediateDirectories:YES attributes:nil error:pError];
}

/*!
 *  Creates a file with the specified content and attributes at the given location.
 *
 *  @param aPath The path for the new file.
 *  @param data  A data object containing the contents of the new file.
 *
 *  @return YES if the operation was successful or if the item already exists, otherwise NO.
 */
+ (BOOL)createFileAtPath:(NSString *)aPath data:(NSData *)data {
    [IBLFileManager assertPath:aPath];
    [IBLFileManager createDictionaryAtPath:[aPath stringByDeletingLastPathComponent] error:nil];
    return [[NSFileManager defaultManager] createFileAtPath:aPath contents:data attributes:nil];
}

#pragma mark Delete
///----------------------------
/// @name Remove File or Dictionary
///----------------------------
/*!
 *  Removes the file or directory at the specified path.
 *
 *  @param aPath A path string indicating the file or directory to remove. If the path specifies a directory, the contents of that directory are recursively removed. You may specify nil for this parameter.
 *  @param error On input, a pointer to an error object. If an error occurs, this pointer is set to an actual error object containing the error information. You may specify nil for this parameter if you do not want the error information.
 *
 *  @return YES if the item was removed successfully or if path was nil. Returns NO if an error occurred. If the delegate aborts the operation for a file, this method returns YES. However, if the delegate aborts the operation for a directory, this method returns NO.
 */
+ (BOOL)removeItemAtPath:(NSString *)aPath error:(NSError **)error {
    [IBLFileManager assertPath:aPath];
    BOOL isSuccess = YES;
    if ([[NSFileManager defaultManager] fileExistsAtPath:aPath]) isSuccess = [[NSFileManager defaultManager] removeItemAtPath:aPath error:error];
    return isSuccess;
}


+ (NSString *)pathForApplicationSupportDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}


+ (NSString *)pathForCachesDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}


+ (NSString *)pathForDocumentsDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}


+ (NSString *)pathForLibraryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    return path;
}

+ (NSString *)pathForMainBundleDirectory {
    return [NSBundle mainBundle].resourcePath;
}


+ (NSString *)pathForTemporaryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        path = NSTemporaryDirectory();
    });
    return path;
}

#pragma mark - Project Dictionary

+ (NSString *)patchForUserCacheFile{
   return [[IBLFileManager pathForDocumentsDirectory] stringByAppendingPathComponent:@"User/CachedUser.plist"];
}

#pragma mark - Asserts

/*!
 *  Assert the specified path not nil or equal to @""
 *
 *  @param aPath the path to Assert
 */
+ (void)assertPath:(NSString *)aPath {
    NSAssert(aPath != nil, @"Invalid path. Path cannot be nil.");
    NSAssert(![aPath isEqualToString:@""], @"Invalid path. Path cannot be empty string.");
}

+ (void)setup {
    NSString *cachedUserPath = [[IBLFileManager pathForDocumentsDirectory] stringByAppendingPathComponent:@"User"];
    
    [IBLFileManager createDictionaryAtPath:cachedUserPath error:nil];
}

@end
