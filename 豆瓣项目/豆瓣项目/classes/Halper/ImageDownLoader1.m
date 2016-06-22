//
//  ImageDownLoader1.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "ImageDownLoader1.h"

@implementation ImageDownLoader1

//+(instancetype)imageDownWithURLString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate {
//    return [[[self class] alloc] initWithImageUrlString:urlString delegate:delegate];
//}
//
//-(instancetype)initWithImageUrlString:(NSString *)urlString delegate:(id<ImageDownLoaderDelegate>)delegate {

+(instancetype)imageDownWithURLString:(NSString *)urlString didFinishedLoading:(block)block {
    return [[[self class]alloc]initWithImageUrlString:urlString didFinishedLoading:block];
}

-(instancetype)initWithImageUrlString:(NSString *)urlString didFinishedLoading:(block)block {
    //网络请求
    //返回得到的url
    if (self = [super init]) {
//        __weak typeof(ImageDownLoader1) *downloader = self;
        
        
        //先去判断是不是在disk caches memory
        //如果都没有才会根据地址请求数据
        NSURLSession *session = [NSURLSession sharedSession];
        //准备url
        NSURL *url = [NSURL URLWithString:urlString];
        
        //创建request
        NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url];
        
        //创建链接对象，发送请求
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return ;
            }
            
            //将图片传值
            UIImage *image = [UIImage imageWithData:data];
            //执行协议方法
            dispatch_async(dispatch_get_main_queue(), ^{
//                [delegate imageDownLoader:downloader didFinishedLoading:image];
                block(image);
                
            });
            
        }];
        [task resume];
    }
    return self;
}

@end
