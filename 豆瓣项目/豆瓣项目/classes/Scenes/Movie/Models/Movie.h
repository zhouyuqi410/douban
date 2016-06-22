//
//  Movie.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Movie : NSObject


@property (nonatomic, strong) NSString *rating;


@property (nonatomic, strong) NSString *pubdate;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger wish;

@property (nonatomic, strong) NSString *original_title;
@property (nonatomic, strong) NSString *orignal_title;

@property (nonatomic, strong) NSNumber *collection;

@property (nonatomic, strong) NSString *stars;

@property (nonatomic, strong) NSDictionary *images;

@property (nonatomic, strong) NSString *large;

@property (nonatomic, strong) NSString *small;

@property (nonatomic, strong) NSString *medium;

@property (nonatomic, strong) NSString *ID;
//通过连接拿到image
@property (nonatomic, strong) UIImage *image;

//
-(void)loadImage;


// 电影简介
@property (nonatomic, copy) NSString *summary;
// 分类
@property (nonatomic, strong) NSArray *genres;
// 国家
@property (nonatomic, strong) NSArray *countries;
// 时长
@property (nonatomic, strong) NSArray *durations;
//评论人数
@property (nonatomic, strong) NSString *comments_count;




@end
