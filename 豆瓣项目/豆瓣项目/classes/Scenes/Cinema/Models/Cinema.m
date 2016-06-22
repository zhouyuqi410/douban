//
//  Cinema.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    key = [key isEqualToString:@"id"] ? @"ID" :key;
    [super setValue:value forKey:key];
}



@end
