//
//  MovieCell.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell


-(void)setMovie:(Movie *)movie {
    if (_movie != movie) {
        _movie = nil;
        
        self.movieNameLabel.text = movie.title;
        self.movieStarLabel.text = movie.stars;
        self.pubDateLabel.text = movie.pubdate;
     //image还没有赋值
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
