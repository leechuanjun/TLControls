//
//  TLCollectionViewController.m
//  TestTLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "TLCollectionViewController.h"
#import "TLUIFoundation/TLUIFoundation.h"
#import "Masonry/Masonry.h"
#import "TLCollectionCell.h"

@interface TLCollectionViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TLCollectionViewDataSource *dataSource;

@end

@implementation TLCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadData];
    [self createCollectionView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - createCollectionView

- (void)createCollectionView{
    
    static NSString *identifier = @"tlcollectionViewidentifier";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(70, 70);
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    // 注册cell
    [self.collectionView registerClass:[TLCollectionCell class] forCellWithReuseIdentifier:identifier];
    
    // 设置数据源,代理
    self.dataSource = [[TLCollectionViewDataSource alloc]initWithItems:self.dataArray cellIdentifier:identifier configureCellBlock:^(TLCollectionCell *cell, id item) {
        [cell initView];
        cell.title = item;
    } itemSize:CGSizeMake(70, 70)];
    
    self.collectionView.dataSource = self.dataSource;
    self.collectionView.delegate = self.dataSource;
    [self.view addSubview:self.collectionView];
    
    __weak typeof(self) weakSelf = self;
    
    self.dataSource.didSelect = ^ (NSIndexPath *indexPath){
        
        NSString *title = weakSelf.dataArray[indexPath.row];
        NSLog(@"选择的item:indexPath = %@,标题为 : %@",indexPath,title);
        
    };
    self.dataSource.didDeselectRow = ^ (NSIndexPath *indexPath){
        
        NSLog(@"取消选择item: %@",indexPath);
    };
    self.dataSource.didHighlight = ^ (NSIndexPath *indexPath){
        
        NSLog(@"高亮item: %@",indexPath);
    };
    
}

- (void)loadData{
    
    NSArray *dataArray = @[@"思思1",@"思思2",@"思思3",@"思思4",@"思思5",@"思思6",@"思思7",@"思思8",@"思思9",@"思思10",@"思思11"];
    self.dataArray = [dataArray copy];
}

@end
