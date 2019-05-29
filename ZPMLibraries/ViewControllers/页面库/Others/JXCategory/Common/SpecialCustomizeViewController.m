//
//  SpecialCustomizeViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/20.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "SpecialCustomizeViewController.h"
#import "SegmentedControlViewController.h"
#import "NaviSegmentedControlViewController.h"
#import "NestViewController.h"
#import "VerticalListViewController.h"
#import "PagingViewController.h"
#import "LoadDataListCustomViewController.h"
#import "LoadDataListContainerViewController.h"
#import "LoadDataListCollectionViewController.h"
#import "ScrollZoomViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface SpecialCustomizeViewController ()

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation SpecialCustomizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 44;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
    
    [self initData];
}

- (void)initData
{
    self.listArray = @[@"个人主页",
                       @"SegmentedControl效果",
                       @"导航栏使用",
                       @"嵌套使用",
                       @"垂直列表滚动",
                       @"刷新数据+UIScrollView封装列表",
                       @"刷新数据+UICollectionView封装列表",
                       @"刷新数据+列表自定义",
                       @"垂直滚动缩放",
                       ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = @"";
    for (UIView *subview in cell.contentView.subviews) {
        if ([subview isKindOfClass:[UILabel class]]) {
            title = [(UILabel *)subview text];
        }
    }

    if ([title isEqualToString:@"个人主页"]) {
        PagingViewController *pagingVC = [[PagingViewController alloc] init];
        pagingVC.title = title;
        [self.navigationController pushViewController:pagingVC animated:YES];
    }else if ([title isEqualToString:@"SegmentedControl效果"]) {
        SegmentedControlViewController *segmentedVC = [[SegmentedControlViewController alloc] init];
        segmentedVC.title = title;
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }else if ([title isEqualToString:@"导航栏使用"]) {
        NaviSegmentedControlViewController *segmentedVC = [[NaviSegmentedControlViewController alloc] init];
        segmentedVC.title = title;
        [self.navigationController pushViewController:segmentedVC animated:YES];
    }else if ([title isEqualToString:@"嵌套使用"]) {
        NestViewController *vc = [[NestViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直列表滚动"]) {
        VerticalListViewController *vc = [[VerticalListViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+UIScrollView封装列表"]) {
        LoadDataListContainerViewController *vc = [[LoadDataListContainerViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+UICollectionView封装列表"]) {
        LoadDataListCollectionViewController *vc = [[LoadDataListCollectionViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"刷新数据+列表自定义"]) {
        LoadDataListCustomViewController *vc = [[LoadDataListCustomViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"垂直滚动缩放"]) {
        ScrollZoomViewController *vc = [[ScrollZoomViewController alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
