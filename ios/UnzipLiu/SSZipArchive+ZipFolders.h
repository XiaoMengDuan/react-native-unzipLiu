//
//  SSZipArchive+ZipFolders.h
//  UnzipLiu
//
//  Created by XiaoMeng on 2018/4/18.
//  Copyright © 2018年 XiaoMeng. All rights reserved.
//

#import "SSZipArchive.h"

@interface SSZipArchive (ZipFolders)

+ (BOOL)createZipFileAtPath:(NSString *)path withFoldersAtPaths:(NSArray<NSString *> *)paths;

@end
