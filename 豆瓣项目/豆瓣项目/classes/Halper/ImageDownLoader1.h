//
//  ImageDownLoader1.h
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^block)(UIImage *);

@interface ImageDownLoader1 : NSObject


//@property (nonatomic,weak)void(^block)(UIImage *image);
//@class ImageDownLoader;
//@protocol ImageDownLoaderDelegate <NSObject>
//
////当获取到image的时候，代理对象执行方法
//-(void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image;
//
//@end
//@interface ImageDownLoader : NSObject
////@property (nonatomic,weak) id <ImageDownLoaderDelegate>delegate;
//
//
////可以将delegate直接作为参数设置，避免可能出现的忘记设置代理问题
//-(instancetype)initWithImageUrlString:(NSString *) urlString delegate:(id<ImageDownLoaderDelegate>)delegare;
//
//
//+ (instancetype)imageDownWithURLString:(NSString *)urlString delegate:(id <ImageDownLoaderDelegate>)delegate;
//
//





-(instancetype)initWithImageUrlString:(NSString *)urlString didFinishedLoading:(block)block;

+ (instancetype)imageDownWithURLString:(NSString *)urlString didFinishedLoading:(block)block;

@end
