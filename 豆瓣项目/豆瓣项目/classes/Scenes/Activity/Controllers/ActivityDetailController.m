//
//  ActivityDetailController.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "ActivityDetailController.h"

#import "NetWorkRequestManager.h"
#import "DBUrl.h"
#import "ImageDownLoader1.h"


#import "UMSocial.h"


@interface ActivityDetailController ()<UMSocialDataDelegate,UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *ActivityNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation ActivityDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    
    [self requestData];
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setBackgroundImage:[UIImage imageNamed:@"share111"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    
    

    
}




-(void)shareAction {

    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5765478d67e58e3bb80025ae"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone]
                                       delegate:self];
}







-(void)requestData {
    __weak ActivityDetailController *activityDetail = self;
    //拼接网址
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",DB_ACTIVITY_BASE_URL,self.activity.ID,DB_ACTIVITY_DETAIL_URL];
    
    [NetWorkRequestManager requestType:GET urlString:urlString prama:nil success:^(id data) {
        
        //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *dict = dic[@"album"];
        Activity *activity = [[Activity alloc]init];
        [activity setValuesForKeysWithDictionary:dict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityDetail showUIWithActivityInfo:activity];
        });
        
        
        
    } fail:^(NSError *error) {
        NSLog(@"数据请求失败");
    }];
    
    
}

-(void)showUIWithActivityInfo:(Activity *)activity {
    
    //请求图片
    [ImageDownLoader1 imageDownWithURLString:activity.myImage didFinishedLoading:^(UIImage *image) {
        self.imageView.image = image;
    }];
    self.titleLabel.text = self.activity.title;
    self.timeLabel.text = [NSString stringWithFormat:@"%@  %@", self.activity.begin_time,self.activity.end_time];
    self.ActivityNameLabel.text = activity.author[@"name"];
    
    self.addressLabel.text = self.activity.address;
    self.categoryLabel.text = self.activity.category_name;
    self.descLabel.text = activity.desc;
    
    
    
}


-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response {
    NSLog(@"dddd");
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
