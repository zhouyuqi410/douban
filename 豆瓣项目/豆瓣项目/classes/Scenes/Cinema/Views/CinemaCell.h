//
//  CinemaCell.h
//  豆瓣项目
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"
@interface CinemaCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property (weak, nonatomic) IBOutlet UILabel *cinemaNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *telephone;

@property (nonatomic, strong)Cinema *cinema;

@end
