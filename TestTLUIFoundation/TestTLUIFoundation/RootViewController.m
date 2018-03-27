//
//  ViewController.m
//  TestTLUIFoundation
//
//  Created by lichuanjun on 2018/3/27.
//  Copyright © 2018年 lichuanjun. All rights reserved.
//

#import "RootViewController.h"

@interface TLSectionView : NSObject

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation TLSectionView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.titles = @[].mutableCopy;
        self.classNames = @[].mutableCopy;
    }
    
    return self;
}
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}
@end



@interface RootViewController ()

@property (nonatomic, strong) NSMutableArray<TLSectionView *> *sections;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.sections = @[].mutableCopy;
    
    TLSectionView *sectionView1 = [[TLSectionView alloc] init];
    [sectionView1 addCell:@"UIButton" class:@"TLButtonViewController"];
    [sectionView1 addCell:@"UITableView" class:@"TLTableViewController"];
    [sectionView1 addCell:@"UICollectionView" class:@"TLCollectionViewController"];
    [self.sections addObject:sectionView1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"控件测试";
    self.navigationController.navigationBarHidden = NO;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.sections[section].titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"buriedPointIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    TLSectionView *sectionView = self.sections[indexPath.section];
    cell.textLabel.text = sectionView.titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TLSectionView *sectionView = self.sections[indexPath.section];
    NSString *className = sectionView.classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = sectionView.titles[indexPath.row];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *lblTitle = [[UILabel alloc] init];
    lblTitle.backgroundColor = [UIColor grayColor];
    lblTitle.textColor = [UIColor whiteColor];
    
    switch (section) {
        case 0:
        {
            lblTitle.text = @"控件列表";
            return lblTitle;
        }
            break;
        default:
            break;
    }
    
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

@end
