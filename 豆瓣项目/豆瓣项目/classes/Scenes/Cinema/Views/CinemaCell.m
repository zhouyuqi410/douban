//
//  CinemaCell.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell


-(void)setCinema:(Cinema *)cinema {
    if (_cinema != cinema) {
        _cinema = nil;
    }
    self.cinemaNameLabel.text = cinema.cinemaName;
    self.addressLabel.text = cinema.address;
    self.telephone.text = cinema.telephone;
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
