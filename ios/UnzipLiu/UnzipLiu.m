//
//  UnzipLiu.m
//  UnzipLiu
//
//  Created by XiaoMeng on 2018/3/18.
//  Copyright © 2018年 XiaoMeng. All rights reserved.
//

#import "UnzipLiu.h"
#import "ZipArchive.h"
#import "SSZipArchive+ZipFolders.h"
#import "EMASIDataDecompressor.h"

#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#endif

#import "EMKeyboard.h"

@implementation UnzipLiu

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(unGzip:(NSString *)zipFilePath
                  destinationFilePath:(NSString *)destinationFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    NSError *error = nil;
    BOOL success = [EMASIDataDecompressor uncompressDataFromFile:zipFilePath toFile:destinationFilePath error:&error];
    
    if (success) {
        resolve(destinationFilePath);
    } else {
        reject(@"-1", @"unable to unzip", error);
    }
}

RCT_EXPORT_METHOD(unZipFile:(NSString *)zipFilePath
                  destinationFilePath:(NSString *)destinationFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    BOOL success = [SSZipArchive unzipFileAtPath:zipFilePath toDestination:destinationFilePath];
    
    if (success) {
        resolve(destinationFilePath);
    } else {
        reject(@"-2", @"Unable zip file", nil);
    }
}

RCT_EXPORT_METHOD(zipFiles:(NSArray<NSString *> *)srcFilePaths
                  destFilePath:(NSString *)destFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    BOOL success = [SSZipArchive createZipFileAtPath:destFilePath withFoldersAtPaths:srcFilePaths];
    
    if (success) {
        resolve(@"1");
    }
    else {
        reject(@"-3", @"unable to compress", nil);
    }
}

RCT_EXPORT_METHOD(dismissKeyboardWithResolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    [EMKeyboard dismissKeyboard];
    
    resolve(@"1");
}



@end
