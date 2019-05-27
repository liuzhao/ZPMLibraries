//
//  ZPMDebugViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMDebugViewController.h"
#import "XYDebugViewManager.h"
#import "ZPMLog.h"
#import "ZPMLLDebugViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMDebugViewController () <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) UISwitch *debugCustom2D;
//@property (strong, nonatomic) UISwitch *debugCustom3D;
@property (strong, nonatomic) UISwitch *debugWindow2D;
@property (strong, nonatomic) UISwitch *debugWindow3D;

@property (strong, nonatomic) UISwitch *consoleLogSwitch;

@property (strong, nonatomic) NSArray<UISwitch *> *allSwitch;

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMDebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"ZPM调试库";
    
    [self initData];
    
    [self setupUI];
    
    [self setupTableView];
}

- (void)initData
{
    self.listArray = @[@[@"DebugWindow_2D",
                         @"DebugWindow_3D",
                         ],
                       @[@"控制台日志"],
                       @[@"LLDebug"]];
}

- (void)setupUI
{
    self.debugWindow2D = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 7, 70, 29)];
    [self.debugWindow2D addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.debugWindow3D = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 7, 70, 29)];
    [self.debugWindow3D addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.allSwitch = [[NSArray alloc] initWithObjects:self.debugWindow2D, self.debugWindow3D, nil];
    
    self.consoleLogSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 7, 70, 29)];
    [self.consoleLogSwitch addTarget:self action:@selector(switchConsoleLog:) forControlEvents:UIControlEventValueChanged];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Console";
    }
    return @"Debug";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [cell.contentView addSubview:self.debugWindow2D];
        }
        else if (indexPath.row == 1) {
            [cell.contentView addSubview:self.debugWindow3D];
        }
    }
    else if (indexPath.section == 1) {
        [cell.contentView addSubview:self.consoleLogSwitch];
    }
    else if (indexPath.section == 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ZPMLLDebugViewController *vc = ZPMLLDebugViewController.new;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)switchChanged:(UISwitch *)sender {
    
    [XYDebugViewManager dismissDebugView];
    
    [_allSwitch enumerateObjectsUsingBlock:^(UISwitch * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != sender && obj.isOn) {
            obj.on = NO;
        }
    }];
    
    if (sender.on) {
        if (sender == _debugWindow2D) {
            [XYDebugViewManager showDebugWithStyle:XYDebugStyle2D];
        } else if (sender == _debugWindow3D) {
            [XYDebugViewManager showDebugWithStyle:XYDebugStyle3D];
        }
    }
}

- (void)switchConsoleLog:(UISwitch *)sender
{
    if (sender.on) {
        [[ZPMLog shareInstance] showConsoleWindow];
        // 打开记录到日志文件，打开后，xcode控制台将不会显示出信息
        [[ZPMLog shareInstance] openNSLogToDocumentFolder];
        NSLog(@"ConsoleWindowOpen");
    }
    else {
        [[ZPMLog shareInstance] didmissConsoleWindow];
        // 关闭记录到日志文件，关闭后，xcode控制台将会显示出信息
        [[ZPMLog shareInstance] closeNSLogToDocumentFolder];
        NSLog(@"ConsoleWindowClose");
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
