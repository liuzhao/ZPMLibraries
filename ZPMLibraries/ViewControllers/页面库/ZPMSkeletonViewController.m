//
//  ZPMSkeletonViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/24.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMSkeletonViewController.h"
#define kText(x) (NSLocalizedString(x, nil))

@interface ZPMSkeletonViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray <NSString *> *titleArray;
@property (nonatomic,strong) NSArray <NSString *> *controllerClassArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZPMSkeletonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.title = @"骨架屏列表";
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *str = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.controllerClassArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
        vc.title = self.titleArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - Initize Methods

/**
 initialize view
 初始化视图
 */
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - Lazy Methods

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (NSArray *)titleArray {
    return @[kText(@"UITableView 示例"),
             kText(@"多行文本 示例"),
             kText(@"UICollectionView 示例"),
             kText(@"UIView 示例"),
             kText(@"卡片投影视图 示例"),
             kText(@"分段视图 示例"),
             kText(@"cell中使用多级view 示例"),
             kText(@"UITableView xib 示例"),
             kText(@"嵌套表格 示例"),
             kText(@"UICollectionView 指定sectionk结束动画"),
             kText(@"UITableView 指定section开启动画"),
             ];
}

- (NSArray *)controllerClassArray {
    return @[@"TestTableViewController",
             @"LabWithLinesViewController",
             @"TestCollectionViewController",
             @"ViewExampleViewController",
             @"CardViewController",
             @"SegmentCollectionViewController",
             @"ExampleOfPackageViewController",
             @"XibTestViewController",
             @"NestCollectionViewController",
             @"SectionsCollectionViewController",
             @"SectionsTableViewController",
             ];
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
