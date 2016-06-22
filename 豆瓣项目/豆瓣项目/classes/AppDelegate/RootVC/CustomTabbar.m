//
//  CustomTabbar.m
//  豆瓣项目
//
//  Created by lanou3g on 16/6/18.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "CustomTabbar.h"

#import "PublishButtton.h"

@interface CustomTabbar ()

@property (nonatomic, strong) PublishButtton *button;
@end


@implementation CustomTabbar


-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.button = [PublishButtton createPublishButton];
        [self addSubview:_button];
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat barWidth = self.frame.size.width;
    CGFloat barHeight = self.frame.size.height;
    CGFloat buttonW = barWidth/5;
    CGFloat buttonH = barHeight - 2;
    CGFloat buttonY = 1;
    
    self.button.center = CGPointMake(barWidth*0.5, barHeight*0.3);
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        NSString *viewClass = NSStringFromClass([view class]);
        if ([viewClass isEqualToString:@"UITabBarButton"]) {
            CGFloat buttonX = index *buttonW;
            if (index >= 2) {
                buttonX += buttonW;
            }
            view.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            index++;
        }
    }
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
