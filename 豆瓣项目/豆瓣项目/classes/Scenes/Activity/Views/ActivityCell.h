//
//  ActivityCell.h
//  豆瓣项目
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"
@interface ActivityCell : UITableViewCell

@property (nonatomic, strong)Activity *activity;


@property (nonatomic, assign) CGFloat cellHeight;


//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *wisher_countLabel;

@property (weak, nonatomic) IBOutlet UILabel *participant_countLabel;

@property (weak, nonatomic) IBOutlet UIImageView *myImage;


@end
