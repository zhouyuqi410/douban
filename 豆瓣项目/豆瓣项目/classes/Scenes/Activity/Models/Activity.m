//
//  Activity.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "Activity.h"
#import "ImageDownLoader.h"




@implementation Activity
-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
   
    if ([key isEqualToString:@"image"]) {
        self.myImage = value;
    }
    
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
    
}



@end
