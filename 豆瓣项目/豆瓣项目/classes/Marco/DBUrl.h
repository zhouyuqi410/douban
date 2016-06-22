//
//  DBUrl.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#ifndef DBUrl_h
#define DBUrl_h

#define DB_LIST_URL @"http://api.douban.com/v2/event/list?type=all&district=all&loc=108288&photo_cate=image&photo_count=5&start=0&day_type=future&apikey=062bcf31694a52d212836d943bdef876"


#define DB_MOVIE_LIST_URL @"http://api.douban.com/v2/movie/nowplaying?app_name=doubanmovie&client=e:iPhone4,1%7Cy:iPhoneOS_6.1%7Cs:mobile%7Cf:doubanmovie_2%7Cv:3.3.1%7Cm:PP_market%7Cudid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&city=%E5%8C%97%E4%BA%ACversion=2&start=0&apikey=0df993c66c0c636e29ecbb5344252a4a"


#define DB_MOVIE_BASE_URL @"http://api.douban.com/v2/movie/subject/"

#define DB_MOVIE_DETAIL_URL @"?apikey=0df993c66c0c636e29ecbb5344252a4a&client=e:iPhone4,1%7Cy:iPhoneOS_6.1%7Cs:mobile%7Cf:doubanmovie_2%7Cv:3.3.1%7Cm:PP_market%7Cudid:aa1b815b8a4d1e961347304e74b9f9593d95e1c5&alt=json&city=%E5%8C%97%E4%BA%AC&version=2&app_name=doubanmovie"









#define DB_ACTIVITY_URL @"http://api.douban.com/v2/event/list?type=all&district=all&loc=108288&photo_cate=image&photo_count=5&start=0&day_type=future&apikey=062bcf31694a52d212836d943bdef876"

#define DB_ACTIVITY_BASE_URL @"http://api.douban.com/v2/event/"

#define DB_ACTIVITY_DETAIL_URL @"/photos?count=5&apikey=062bcf31694a52d212836d943bdef876"



#define DB_CINEMA_LIST_URL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php"










#endif /* DBUrl_h */
