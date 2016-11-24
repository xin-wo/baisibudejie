//
//  BDJDownloader.m
//  Baisibudejie
//
//  Created by qianfeng on 16/11/22.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "BDJDownloader.h"
#import <AFNetworking/AFNetworking.h>

@implementation BDJDownloader

+ (void)downloadWithURLString:(NSString *)urlString success:(SUCCESSBLOCK)finishBlock fail:(FAILBLOCK)failBlock{
    
    //创建NSURL
    NSURL *url = [NSURL URLWithString:urlString];
    
    //创建request
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //下载对象
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            //请求失败
            failBlock(error);
        } else {
            //请求成功
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
            if (r.statusCode == 200) {
                //返回正确数据
                finishBlock(responseObject);
            } else {
                //请求数据失败
                NSError *e = [NSError errorWithDomain:urlString code:r.statusCode userInfo:@{@"msg":@"下载失败"}];
                failBlock(e);
            }
            
            
        }
        
        
    }];
    
    //开始下载
    [task resume];
    
    
}




@end
