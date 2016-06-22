//
//  MovieDetailViewController.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/17.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "NetWorkRequestManager.h"
#import "DBUrl.h"
#import "ImageDownLoader.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>


@interface MovieDetailViewController ()<ImageDownLoaderDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (weak, nonatomic) IBOutlet UILabel *pubdateLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *movieCountryLabel;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeight;



@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //请求数据
    [self requestData];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    button.layer.cornerRadius = 10;
    button.layer.masksToBounds = YES;
    [button setBackgroundImage:[UIImage imageNamed:@"share111"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    

   
}


-(void)shareAction {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"豆瓣.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传image参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        //拼接网址
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@",DB_MOVIE_BASE_URL,_movie.ID,DB_MOVIE_DETAIL_URL];
        
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"网页链接网址 %@",urlString]
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.baidu.com"]
                                          title:@"分享标题😄😄😄"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    

    
}


-(void)requestData {
    __weak MovieDetailViewController * movieDetail = self;
    //拼接网址
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@",DB_MOVIE_BASE_URL,_movie.ID,DB_MOVIE_DETAIL_URL];
    
    [NetWorkRequestManager requestType:GET urlString:urlString prama:nil success:^(id data) {
        //解析数据
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
        
        //转成模型对象
        Movie *movie_d = [[Movie alloc]init];
       [movie_d setValuesForKeysWithDictionary:dic];
        //进行展示
        dispatch_async(dispatch_get_main_queue(), ^{
           //
            [movieDetail showUIWithMovieInfo:movie_d];

        });
        
    } fail:^(NSError *error) {
        NSLog(@"请求数据失败");
    }];
    
}


-(void)showUIWithMovieInfo:(Movie *)movie {
    //请求图片
    [ImageDownLoader imageDownWithURLString:movie.images[@"large"] delegate:self];
    
    _gradeLabel.text = [NSString stringWithFormat:@"评分：%@ (%@评论)",self.movie.rating,movie.comments_count];
    _pubdateLabel.text = movie.pubdate;
    _movieTimeLabel.text = [self stringByArray:movie.durations];
    _movieTypeLabel.text = [self stringByArray:movie.genres];
    _movieCountryLabel.text = [self stringByArray:movie.countries];
    //详情
    _summaryLabel.text = movie.summary;
    //计算详情高度
    CGRect frame = _summaryLabel.frame;
    frame.size.height = [self calculateTextHeightWithMovie:movie];
    

    //给约束赋值
    CGSize size = CGSizeMake(_scrollView.frame.size.width, frame.size.height + 266);
    self.contentViewHeight.constant = size.height;
}

#pragma mark -- 计算文本高度
- (CGFloat)calculateTextHeightWithMovie:(Movie *)movie
{
    CGSize size = CGSizeMake(_summaryLabel.frame.size.width, 1000000);
    NSDictionary * dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
    
    CGRect frame = [movie.summary boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return  frame.size.height;
    
}

-(NSString *)stringByArray:(NSArray *)array {
    NSMutableString *string = [NSMutableString string];
    for (NSString *str in array) {
        [string appendFormat:@"%@ ",str];
    }
    return string;
}


-(void)imageDownLoader:(ImageDownLoader *)downLoader didFinishedLoading:(UIImage *)image {
    _movieImageView.image = image;
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
