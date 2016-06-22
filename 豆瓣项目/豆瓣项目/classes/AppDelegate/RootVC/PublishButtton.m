//
//  PublishButtton.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "PublishButtton.h"

@implementation PublishButtton

//初始化方法
-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

+(instancetype) createPublishButton{
    PublishButtton *button = [[PublishButtton alloc]init];
    [button setImage:[UIImage imageNamed:@"111"] forState:(UIControlStateNormal)];
    //设置按钮文字
    [button setTitle:@"主页" forState:(UIControlStateNormal)];
    //设置文字颜色
    [button setTitleColor:[UIColor purpleColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit];
    //添加事件
    [button addTarget:button action:@selector(clickPublishButton) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


-(void)clickPublishButton {
    NSLog(@"点击了中间的按钮");
}

//将button上的image 和titleLabel 进行上下结构
-(void)layoutSubviews {
    [super layoutSubviews];
    //设置空间大小，间距
    CGFloat imageViewSize = self.bounds.size.width*0.6;
    CGFloat center = self.bounds.size.width*0.5;
       //设置imageView和label的间距
    //获取label的高度
    CGFloat labelHeight = self.titleLabel.font.lineHeight;
    CGFloat verticalMargin = (self.bounds.size.height - labelHeight - imageViewSize)/2.0;
    //imageView 和 titleLabel 中心的Y值
    CGFloat centerYOfImageView = verticalMargin + imageViewSize*0.5;
    CGFloat centerYOfTitleLaber = verticalMargin + imageViewSize + labelHeight*0.5;
    //确定最终位置
    self.imageView.bounds = CGRectMake(0, 0, imageViewSize, imageViewSize);
    self.imageView.center = CGPointMake(center, centerYOfImageView + 5);
    
    self.titleLabel.center = CGPointMake(center, centerYOfTitleLaber + 7);
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
