//
//  Activity.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Activity : NSObject
//标题
@property (nonatomic, strong)NSString *title;

//感兴趣
@property (nonatomic, strong)NSString *wisher_count;

//参加
@property (nonatomic, strong)NSString *participant_count;

//分类名
@property (nonatomic, strong)NSString *category_name;

//地址
@property (nonatomic, strong)NSString *address;

//结束时间
@property (nonatomic, strong)NSString *end_time;

//开始时间
@property (nonatomic, strong)NSString *begin_time;

//图片
@property (nonatomic, strong) NSString  *adapt_url;

@property (nonatomic, strong) NSDictionary *owner;
@property (nonatomic, strong) NSString *myImage;
@property (nonatomic, strong) NSString *ID;

//********************

@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSDictionary *author;










@end
