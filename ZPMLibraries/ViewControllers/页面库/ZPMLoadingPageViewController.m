//
//  ZPMLoadingPageViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/24.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMLoadingPageViewController.h"
#import "ZPMSkeletonViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMLoadingPageViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMLoadingPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"页面转场";
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    self.listArray = @[@[@"普通加载",
                         ],
                       @[@"网页加载",
                         ],
                       @[@"骨架屏加载",
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        ZPMSkeletonViewController *vc = [[ZPMSkeletonViewController alloc] init];
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
