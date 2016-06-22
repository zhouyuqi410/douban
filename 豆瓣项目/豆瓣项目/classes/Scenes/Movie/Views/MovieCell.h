//
//  MovieCell.h
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@interface MovieCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *bkgView;


//电影封面图片
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
//电影名
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;

//星级
@property (weak, nonatomic) IBOutlet UILabel *movieStarLabel;

//上映时间
@property (weak, nonatomic) IBOutlet UILabel *pubDateLabel;



@property (nonatomic, strong) Movie *movie;

@end
