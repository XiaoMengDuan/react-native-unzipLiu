//
//  UnzipLiu.m
//  UnzipLiu
//
//  Created by XiaoMeng on 2018/3/18.
//  Copyright © 2018年 XiaoMeng. All rights reserved.
//

#import "UnzipLiu.h"
#import "EMASIDataDecompressor.h"

#if __has_include(<React/RCTEventDispatcher.h>)
#import <React/RCTEventDispatcher.h>
#else
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"
#endif

@implementation UnzipLiu

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(unzip:(NSString *)zipFilePath
                  destinationFilePath:(NSString *)destinationFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject) {
    
    NSError *error = nil;
    BOOL success = [EMASIDataDecompressor uncompressDataFromFile:zipFilePath toFile:destinationFilePath error:&error];
    
    if (success) {
        resolve(destinationFilePath);
    } else {
        reject(@"unzip_error", @"unable to unzip", error);
    }
}

@end
