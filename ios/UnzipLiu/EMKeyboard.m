//
//  EMKeyboard.m
//  UnzipLiu
//
//  Created by XiaoMeng on 2018/5/15.
//  Copyright © 2018年 XiaoMeng. All rights reserved.
//

#import "EMKeyboard.h"

@implementation EMKeyboard

+ (void)dismissKeyboard {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication.sharedApplication.keyWindow endEditing:YES];
    });
    
}

@end
