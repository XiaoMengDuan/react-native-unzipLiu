//
//  SSZipArchive+ZipFolders.m
//  UnzipLiu
//
//  Created by XiaoMeng on 2018/4/18.
//  Copyright © 2018年 XiaoMeng. All rights reserved.
//

#import "SSZipArchive+ZipFolders.h"

@implementation SSZipArchive (ZipFolders)

+ (BOOL)zip:(SSZipArchive *)zipArchive folder:(NSString *)directoryPath parentPath:(NSString *)parentPath keepParent:(BOOL)keepParentDirectory
{
    BOOL success = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnumerator = [fileManager enumeratorAtPath:directoryPath];
    NSArray<NSString *> *allObjects = dirEnumerator.allObjects;
    NSString *fileName;
    for (fileName in allObjects) {
        BOOL isDir;
        NSString *fullFilePath = [directoryPath stringByAppendingPathComponent:fileName];
        [fileManager fileExistsAtPath:fullFilePath isDirectory:&isDir];
        
        if (keepParentDirectory && parentPath.length)
        {
            fileName = [parentPath stringByAppendingPathComponent:fileName];
        }
        
        if (!isDir) {
            success &= [zipArchive writeFileAtPath:fullFilePath withFileName:fileName withPassword:nil];
        }
        else
        {
            if ([[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fullFilePath error:nil].count == 0)
            {
                success &= [zipArchive writeFolderAtPath:fullFilePath withFolderName:fileName withPassword:nil];
            }
            else
            {
                NSString *subParentPath = parentPath;
                if (!subParentPath.length) {
                    subParentPath = fileName;
                }
                else
                {
                    subParentPath = [subParentPath stringByAppendingPathComponent:fileName];
                }
                success &=[self zip:zipArchive folder:fullFilePath parentPath:subParentPath keepParent:keepParentDirectory];
            }
        }
    }
    return success;
}

+ (BOOL)createZipFileAtPath:(NSString *)path withFoldersAtPaths:(NSArray<NSString *> *)paths
{
    BOOL keepParentDirectory = YES;
    SSZipArchive *zipArchive = [[SSZipArchive alloc] initWithPath:path];
    BOOL success = [zipArchive open];
    if (success) {
        // use a local fileManager (queue/thread compatibility)
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *fileName = nil;
        for (NSString *srcPath in paths) {
            BOOL isDir;
            if ([fileManager fileExistsAtPath:srcPath isDirectory:&isDir]) {
                
                if (keepParentDirectory)
                {
                    fileName = [srcPath.lastPathComponent stringByAppendingPathComponent:fileName];
                }
                
                if (!isDir) {
                    success &= [zipArchive writeFileAtPath:srcPath withFileName:srcPath.lastPathComponent withPassword:nil];
                }
                else
                {
                    if ([[NSFileManager defaultManager] subpathsOfDirectoryAtPath:srcPath error:nil].count == 0)
                    {
                        success &= [zipArchive writeFolderAtPath:srcPath withFolderName:srcPath.lastPathComponent withPassword:nil];
                    }
                    else
                    {
                        success &= [self zip:zipArchive folder:srcPath parentPath:nil keepParent:keepParentDirectory];
                    }
                }
            }
        }
        success &= [zipArchive close];
    }
    return success;
}

@end
