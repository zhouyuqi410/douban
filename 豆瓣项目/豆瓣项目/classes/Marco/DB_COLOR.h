//
//  DB_COLOR.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#ifndef DB_COLOR_h
#define DB_COLOR_h

#define DB_COLOR(r,g,b,a)[UIColor colorWithRed:(r) /255.0 green:(g)/255.0 blue:(b)/255 alpha:a]


//随机色
#define DB_RANDOM_COLOR DB_COLOR(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), 1)

//主题色
#define DB_MAIN_COLOR DB_COLOR(40,230,100,1.0)


#endif /* DB_COLOR_h */
