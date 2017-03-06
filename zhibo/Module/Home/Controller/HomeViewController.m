//
//  HomeViewController.m
//  zhibo
//
//  Created by K.Lam on 2017/3/3.
//  Copyright © 2017年 wbiao. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "GBItemModel.h"
#import "MJExtension.h"
#import "GBPlayingViewController.h"
#import "GBItemCell.h"

@interface HomeViewController ()<UITableViewDelegate , UITableViewDataSource>

@property (nonatomic , weak) UITableView *tableView;

@property (nonatomic , strong) NSMutableArray *lives;

@end

@implementation HomeViewController

- (NSMutableArray *)lives {
    if (!_lives) {
        _lives = [NSMutableArray array];
    }
    
    return _lives;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableView];
    
    [self loadData];
    
    
}


- (void)addTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GBWidth, GBHeight)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}


- (void)loadData
{
    // 映客数据url
    NSString *urlStr = @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1";
    
    // 请求数据
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [mgr GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        _lives = [GBItemModel mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error);
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _lives.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GBItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GBItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.model = _lives[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GBPlayingViewController *playVC = [GBPlayingViewController new];
    GBItemModel *model = _lives[indexPath.row];
    playVC.stream_addr = model.stream_addr;
    [self.navigationController presentViewController:playVC animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20 + GBWidth;
}
@end
