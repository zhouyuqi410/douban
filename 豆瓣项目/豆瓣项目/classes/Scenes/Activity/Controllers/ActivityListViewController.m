//
//  ActivityListViewController.m
//  项目2——豆瓣
//
//  Created by lanou3g on 16/6/16.
//  Copyright © 2016年 周玉琦. All rights reserved.
//

#import "ActivityListViewController.h"
#import "Activity.h"
#import "ActivityCell.h"
#import "NetWorkRequestManager.h"
#import "DBUrl.h"

#import "ActivityDetailController.h"


@interface ActivityListViewController ()

//存储对象数组
@property (nonatomic, strong) NSMutableArray *allActivitiesArray;

@end

@implementation ActivityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //请求数据
    [self requestData];
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//懒加载
-(NSMutableArray *)allActivitiesArray {
    if (_allActivitiesArray == nil) {
        _allActivitiesArray = [NSMutableArray array];
    }
    return _allActivitiesArray;
}

-(void)requestData {
    
    __weak typeof(self) activityVC = self;
    [NetWorkRequestManager requestType:GET urlString:DB_ACTIVITY_URL prama:nil success:^(id data) {
        //解析数据
        NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //数据判断安全
        if ([dict[@"count"]intValue] != 0) {
            NSArray *array = dict[@"events"];
            for (NSDictionary *dict in array) {
                Activity *activity = [[Activity alloc]init];
                [activity setValuesForKeysWithDictionary:dict];
                
                [activityVC.allActivitiesArray addObject:activity];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityVC.tableView reloadData];
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
    return self.allActivitiesArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Activity *acticity = self.allActivitiesArray[indexPath.row];
    
    cell.activity = acticity;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 270;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityDetailController *activityDetail = [[ActivityDetailController alloc]init];
    activityDetail.activity = self.allActivitiesArray[indexPath.row];
    [self.navigationController pushViewController:activityDetail animated:YES];

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
