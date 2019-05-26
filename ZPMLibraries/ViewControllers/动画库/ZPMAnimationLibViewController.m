//
//  ZPMAnimationLibViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMAnimationLibViewController.h"
#import "ZPMMenuViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMAnimationLibViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMAnimationLibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"ZPM动画库";
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    self.listArray = @[@[@"菜单 Menu",
                         ],
                       @[@"下拉刷新"]];
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
    return [self.listArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section == 1) {
//        return @"Console";
//    }
//    return @"Debug";
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ZPMMenuViewController *vc = ZPMMenuViewController.new;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
