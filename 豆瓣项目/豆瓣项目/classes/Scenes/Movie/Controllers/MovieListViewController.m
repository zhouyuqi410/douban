//
//  MovieListViewController.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "MovieListViewController.h"
#import "NetWorkRequestManager.h"
#import "Movie.h"
#import "MovieCell.h"
#import "DBUrl.h"

#import "MovieDetailViewController.h"
@interface MovieListViewController ()

//存储movie 对象的数组
@property (nonatomic,strong)NSMutableArray *allMoviesArray;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网络请求数据
    [self requestData];
    
    
    //注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)requestData {
    __weak typeof(self) movieVC = self;
    [NetWorkRequestManager requestType:GET urlString:DB_MOVIE_LIST_URL prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //数据安全判断（判断正在上映的电影不等于0）
        if ([dic[@"total"]intValue] != 0) {
            NSArray *array = dic[@"entries"];
           
            for (NSDictionary * dict in array) {
                Movie *movie = [[Movie alloc]init];
                
                [movie setValuesForKeysWithDictionary:dict];
                
                [movieVC.allMoviesArray addObject:movie];
            }
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [movieVC.tableView reloadData];
        });
        
        
    } fail:^(NSError *error) {
        NSLog(@"数据请求失败%@",error);
    }];
    
}


-(NSMutableArray *)allMoviesArray {
    if (!_allMoviesArray) {
        _allMoviesArray = [NSMutableArray array];
    }
    return _allMoviesArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allMoviesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //设置cell
    Movie *movie = self.allMoviesArray[indexPath.row];
    
    cell.movie = movie;
    if (movie.image != nil) {
        cell.movieImageView.image = movie.image;
    }else {
        [movie loadImage];
        
        //使用KVO 监听image的变化
        [movie addObserver:self forKeyPath:@"image" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:(void *)CFBridgingRetain(indexPath)];
    }
    
    return cell;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    //获取图片
    UIImage *image = change[NSKeyValueChangeNewKey];
    //获取cell的位置
    NSIndexPath *indexPath = (__bridge NSIndexPath *)context;
    
    MovieCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.movieImageView.image = image;
    
    
    //释放掉indexPath的权限
    CFBridgingRelease(CFBridgingRetain(indexPath));
    
    //移除观察者
    [object removeObserver:self forKeyPath:@"image" context:context];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailViewController *movieDetailVC = [[MovieDetailViewController alloc]init];
    Movie *movie = [self.allMoviesArray objectAtIndex:indexPath.row];
    movieDetailVC.movie = movie;
    
    
    [self.navigationController pushViewController:movieDetailVC animated:YES];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
