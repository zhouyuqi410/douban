//
//  Movie.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "Movie.h"
//#import "ImageDownLoader.h"
#import "ImageDownLoader1.h"

@interface Movie ()//<ImageDownLoaderDelegate>

@end

@implementation Movie

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
   
}
//在这个方法中通过图片链接获取图片保存在image属性中
-(void)loadImage {
    
    NSString *imageUrlStr = self.images[@"medium"];
//    [ImageDownLoader imageDownWithURLString:imageUrlStr delegate:self];
    [ImageDownLoader1 imageDownWithURLString:imageUrlStr didFinishedLoading:^(UIImage *image) {
        self.image = image;
    }];
    
}




//#pragma mark -  ImageDownLoaderDelegate 
//-(void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image {
//    self.image = image;
//}



@end
