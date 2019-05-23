//
//  ZPMControlLibViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMControlLibViewController.h"
#import "ZPMIndicatorViewViewController.h"
#import "ZPMToastViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMControlLibViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMControlLibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"ZPM控件库";
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    ZPMIndicatorViewViewController *vc1 = [[ZPMIndicatorViewViewController alloc] init];
    ZPMToastViewController *vc2 = [[ZPMToastViewController alloc] init];
    
    self.listArray = @[@{@"title": @"指示器 ActivityIndicator", @"image": @"icn_icn_loading", @"vc": vc1},
                       @{@"title": @"轻提示 Toast", @"image": @"icn_icn_toast", @"vc": vc2},
                       @{@"title": @"对话框 Dialog", @"image": @"icn_icn_dialog"},
                       @{@"title": @"按钮 Button", @"image": @"icn_icn_button"},
                       @{@"title": @"进度条 Progress", @"image": @"icn_icn_progressview"},
                       @{@"title": @"分段选择 Segment", @"image": @"icn_color_icn_segment"},
                       @{@"title":  @"滑杆 Slider", @"image": @"icn_color_icn_slider"},
                       @{@"title": @"开关 Switch", @"image": @"icn_icn_switch"},
                       @{@"title": @"选择器 Picker", @"image": @"icn_color_icn_picker"},
                       @{@"title": @"搜索框 Seachbar", @"image": @"icn_icn_searchbar"},
                       @{@"title": @"页卡 Tabbar", @"image": @"icn_color_icn_tabbar"},
                       @{@"title": @"导航栏 Navigationbar", @"image": @"icn_color_icn_navigation"}];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:self.listArray[indexPath.row][@"image"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIViewController *vc = self.listArray[indexPath.row][@"vc"];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
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
