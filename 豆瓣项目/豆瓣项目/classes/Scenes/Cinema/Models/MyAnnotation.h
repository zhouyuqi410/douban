//
//  MyAnnotation.h
//  UISenior20_Map_大头针
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject<MKAnnotation>
//重写协议中的三个属性：coordinate（标记位置）、title（标题）、subtitle（子标题）

///坐标
@property (nonatomic)CLLocationCoordinate2D coordinate;

///标题
@property (nonatomic,copy)NSString *title;

///子标题
@property (nonatomic,copy)NSString *subtitle;

//自定义大头针


//自定义大头针显示图片
@property (nonatomic, strong) UIImage *image;



@end
