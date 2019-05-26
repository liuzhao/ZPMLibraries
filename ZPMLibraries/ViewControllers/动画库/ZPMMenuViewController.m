//
//  ZPMMenuViewController.m
//  ZPMLibraries
//
//  Created by 刘钊 on 2019/5/26.
//  Copyright © 2019年 Liu Zhao. All rights reserved.
//

#import "ZPMMenuViewController.h"
#import "ZPMSuspensionViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMMenuViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"菜单Menu";
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    self.listArray = @[@[@"浮窗",
                         ]];
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
    ZPMSuspensionViewController *vc = ZPMSuspensionViewController.new;
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
