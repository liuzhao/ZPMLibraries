//
//  ZPMDebugViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMDebugViewController.h"
#import "XYDebugViewManager.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMDebugViewController () <UITableViewDelegate, UITableViewDataSource>

//@property (strong, nonatomic) UISwitch *debugCustom2D;
//@property (strong, nonatomic) UISwitch *debugCustom3D;
@property (strong, nonatomic) UISwitch *debugWindow2D;
@property (strong, nonatomic) UISwitch *debugWindow3D;

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
                         ]];
}

- (void)setupUI
{
    self.debugWindow2D = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 7, 70, 29)];
    [self.debugWindow2D addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.debugWindow3D = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 7, 70, 29)];
    [self.debugWindow3D addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    self.allSwitch = [[NSArray alloc] initWithObjects:self.debugWindow2D, self.debugWindow3D, nil];
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
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
