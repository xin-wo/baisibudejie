//
//  BDJDownloader.h
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SUCCESSBLOCK)(NSData *data);
typedef void(^FAILBLOCK)(NSError *error);

@interface BDJDownloader : NSObject
//参数名可以省略
//+ (void)downloadWithURLString:(NSString *)urlString success:(SUCCESSBLOCK)finishBlock fail:(FAILBLOCK)failBlock;


+ (void)downloadWithURLString:(NSString *)urlString success:(SUCCESSBLOCK)finishBlock fail:(FAILBLOCK)failBlock;


@end
