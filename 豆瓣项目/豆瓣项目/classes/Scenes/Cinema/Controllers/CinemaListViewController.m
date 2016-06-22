//
//  CinemaListViewController.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "CinemaListViewController.h"
#import "NetWorkRequestManager.h"
#import "Cinema.h"
#import "CinemaCell.h"
#import "DBUrl.h"

#import "CimemaMapViewController.h"
@interface CinemaListViewController ()

//储存cinema对象的数组
@property (nonatomic, strong) NSMutableArray *allCinemasArray;

@end

@implementation CinemaListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //网络请求数据
    [self requestData];
    
    //注册cell
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CinemaCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSMutableArray *)allCinemasArray {
    if (_allCinemasArray == nil) {
        _allCinemasArray = [NSMutableArray array];
    }
    return _allCinemasArray;
}

-(void)requestData {
    
    __weak typeof(self) cinemaVC = self;
    [NetWorkRequestManager requestType:GET urlString:DB_CINEMA_LIST_URL prama:nil success:^(id data) {
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([dic[@"reason"] isEqualToString:@"success"]) {
            NSDictionary *dict = dic[@"result"];
            
            NSArray *array = dict[@"data"];
            
            for (NSDictionary *dataDict in array) {
                Cinema *cinema = [[Cinema alloc]init];
                [cinema setValuesForKeysWithDictionary:dataDict];
                
                [cinemaVC.allCinemasArray addObject:cinema];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        
            //刷新页面
            [cinemaVC.tableView reloadData];
        });
        
    } fail:^(NSError *error) {
        
        NSLog(@"请求数据失败");
    }];
    
    
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
    return self.allCinemasArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Cinema *cinema = self.allCinemasArray[indexPath.row];
    
    cell.cinema = cinema;
    
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CimemaMapViewController *cinemaMapVC = [[CimemaMapViewController alloc]init];
    [self.navigationController pushViewController:cinemaMapVC animated:YES];
    Cinema *cinema = self.allCinemasArray[indexPath.row];
    cinemaMapVC.address = cinema.address;
    
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
