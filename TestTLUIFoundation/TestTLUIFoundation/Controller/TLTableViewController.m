//
//  TLTableViewController.m
//  TestTLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLUIFoundation/TLUIFoundation.h"
#import "Masonry/Masonry.h"
#import "TLTableCell.h"

@interface TLTableViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TLTableViewDataSource *dataSource;

@end

@implementation TLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    
    NSArray *dataArray = @[@"思思1",@"思思2",@"思思3",@"思思4",@"思思5",@"思思6",@"思思7",@"思思8",@"思思9",@"思思10",@"思思11"];
    self.dataArray = [dataArray mutableCopy];
}

- (void)createTableView{
    static NSString *identifier = @"tltableViewidentifier";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    // 注册cell
    [_tableView registerClass:[TLTableCell class] forCellReuseIdentifier:identifier];
    
    self.dataSource = [[TLTableViewDataSource alloc] initWithItems:self.dataArray cellIdentifier:identifier configureCellBlock:^(TLTableCell *cell, id item) {
        
        cell.title = item;
        
    } itemHeight:70];
    
    self.tableView.dataSource = self.dataSource;
    self.tableView.delegate = self.dataSource;
    
    __weak typeof(self)weakSelf = self;
    self.dataSource.didSelect = ^ (NSIndexPath *indexPath){
        
        NSString *title = weakSelf.dataArray[indexPath.row];
        NSLog(@"选择的行:indexPath = %@,标题为 : %@",indexPath,title);
        
    };
    self.dataSource.didDeselectRow = ^ (NSIndexPath *indexPath){
        
        NSLog(@"取消选择行: %@",indexPath);
    };
    self.dataSource.didHighlight = ^ (NSIndexPath *indexPath){
        
        NSLog(@"高亮行: %@",indexPath);
    };
}

@end
