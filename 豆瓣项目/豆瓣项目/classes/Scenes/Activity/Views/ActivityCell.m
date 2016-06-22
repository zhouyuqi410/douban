//
//  ActivityCell.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "ActivityCell.h"
#import "ImageDownLoader1.h"
@interface ActivityCell ()

@end


@implementation ActivityCell

-(void)setActivity:(Activity *)activity {
    if (_activity != activity) {
        _activity = nil;
    }
    
    self.cellHeight = self.titleLabel.frame.size.height + self.imageView.frame.size.height + 50;
    
    
    self.addressLabel.text = activity.address;
    
    self.titleLabel.text = activity.title;
    self.categoryLabel.text = [NSString stringWithFormat:@" 类型：%@", activity.category_name];
    self.wisher_countLabel.text = [NSString stringWithFormat:@"感兴趣:%@", activity.wisher_count ];
    self.participant_countLabel.text = [NSString stringWithFormat:@"参加:%@",activity.participant_count];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@ -- %@", activity.begin_time,activity.end_time];
    
    [ImageDownLoader1 imageDownWithURLString:activity.myImage didFinishedLoading:^(UIImage *image) {
        self.myImage.image = image;
    }];
}




- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
