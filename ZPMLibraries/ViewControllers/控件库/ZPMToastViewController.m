//
//  ZPMToastViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMToastViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMToastViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation ZPMToastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    NSArray *titleArray = @[@"展示纯文本，在window上默认2s",
                         @"展示纯文本，在指定view上。指定3s",
                         @"展示有图片的成功消息，默认在window上，默认2s",
                         @"展示有图片的失败消息，在指定view上，指定3s",
                         @"测试纯文本文字较多的情况",
                         @"测试含有图片的文本文字较多的情况",
                         @"测试顶部出现",
                         @"测试底部出现",
                         @"测试底部出现，文字较多",
                         @"测试底部出现，键盘弹出，文字自动上移",
                         @"测试展示在指定的view上",
                         @"测试更换成功图片",
                         @"修改toast的属性",
                         @"重置toast的属性",
                         @"测试禁止多任务顺序执行，连续点击，只toast一次"
                          ];
    self.titleArray = titleArray;
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
