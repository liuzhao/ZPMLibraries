//
//  ZPMTransitionViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/23.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMTransitionViewController.h"
#import "ZPMDetailViewController.h"
#import "UIViewController+HHTransition.h"
#import "XYDebugViewManager.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMTransitionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;
@property (nonatomic, assign) CGPoint touchPoint;

@end

@implementation ZPMTransitionViewController

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.title = @"页面转场";
    
    [self initData];
    
    [self setupTableView];
}

- (void)initData
{
    self.listArray = @[@[@"AnimationStyleNormal",
                         @"AnimationStyleCircle",
                         @"AnimationStyleBackScale",
                         ],
                       @[@"AnimationStyleNormal",
                         @"AnimationStyleErect",
                         @"AnimationStyleTilted",
                         @"AnimationStyleBack",
                         @"AnimationStyleCube",
                         @"AnimationStyleSuckEffect",
                         @"AnimationStyleOglFlip",
                         @"AnimationStyleRippleEffect",
                         @"AnimationStylePageCurl",
                         @"AnimationStyleCameralIrisHollowOpen",
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Push";
    }
    return @"Present";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row];
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
    
    ZPMDetailViewController *vc = [ZPMDetailViewController new];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self presentViewController:vc animated:YES completion:nil];
                break;
            case 1:
                vc.isShowTap = YES;
                [self hh_presentCircleVC:vc point:_touchPoint completion:nil];
                break;
            case 2:
                vc.isShowTip = YES;
                [self.navigationController hh_pushTiltViewController:vc];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                vc.isShowTip = YES;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            case 1:
                vc.isShowTip = YES;
                [self.navigationController hh_pushErectViewController:vc];
                break;
            case 2:
                vc.isShowTip = YES;
                [self.navigationController hh_pushTiltViewController:vc];
                break;
            case 3:
                vc.isShowTip = YES;
                [self.navigationController hh_pushBackViewController:vc];
                break;
            case 4:
                [self.navigationController hh_pushViewController:vc style:AnimationStyleCube];
                break;
            case 5:
                [self.navigationController hh_pushViewController:vc style:AnimationStyleSuckEffect];
                break;
            case 6:
                [self.navigationController hh_pushViewController:vc style:AnimationStyleOglFlip];
                break;
            case 7:
                [self.navigationController hh_pushViewController:vc style:AnimationStyleRippleEffect];
                break;
            case 8:
                [self.navigationController hh_pushViewController:vc style:AnimationStylePageCurl];
                break;
            case 9:
                [self.navigationController hh_pushViewController:vc style:AnimationStyleCameralIrisHollowOpen];
                break;
            default:
                break;
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
