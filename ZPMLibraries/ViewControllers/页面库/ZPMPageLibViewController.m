//
//  ZPMPageLibViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMPageLibViewController.h"
#import "ZPMTransitionViewController.h"
#import "ZPMFloatBallViewController.h"
#import "JPSuspensionEntrance.h"
#import "ZPMLoadingPageViewController.h"
#import "ZPMEmptyViewController.h"
#import "ZPMBannerViewController.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

static BOOL isHideNavBar_ = NO;
static NSString *const JPSuspensionCacheMsgKey = @"JPSuspensionCacheMsgKey";
static NSString *const JPSuspensionDefaultXKey = @"JPSuspensionDefaultXKey";
static NSString *const JPSuspensionDefaultYKey = @"JPSuspensionDefaultYKey";

@interface ZPMPageLibViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *listArray;

@end

@implementation ZPMPageLibViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    JPSEInstance.navCtr = self.navigationController;
    
//    __weak typeof(self) weakSelf = self;
//    JPSEInstance.willSpreadSuspensionViewControllerBlock = ^(UIViewController<JPSuspensionEntranceProtocol> *targetVC) {
//        [(ViewController *)targetVC setIsHideNavBar:weakSelf.isHideNavBar];
//        [(ViewController *)targetVC setRightBtnTitle:@"取消浮窗"];
//    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
}

- (void)setupJPSEInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 是否可以播放提示音
        JPSEInstance.canPlaySound = YES;
        
        //        // 配置展开时的提示音
        //        JPSEInstance.playSpreadSoundBlock = ^{
        //
        //        };
        //
        //        // 配置闭合时的提示音
        //        JPSEInstance.playShrinkSoundBlock = ^{
        //
        //        };
        
        JPSEInstance.cacheMsgBlock = ^(NSString *cacheMsg) {
            [[NSUserDefaults standardUserDefaults] setObject:cacheMsg forKey:JPSuspensionCacheMsgKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        };
        
        JPSEInstance.cacheSuspensionFrameBlock = ^(CGRect suspensionFrame) {
            [[NSUserDefaults standardUserDefaults] setFloat:suspensionFrame.origin.x forKey:JPSuspensionDefaultXKey];
            [[NSUserDefaults standardUserDefaults] setFloat:suspensionFrame.origin.y forKey:JPSuspensionDefaultYKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        };
        
    });
}

- (void)setupSuspensionView {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *cachaMsg = [[NSUserDefaults standardUserDefaults] stringForKey:JPSuspensionCacheMsgKey];
        if (cachaMsg) {
            ZPMFloatBallViewController *vc = [[ZPMFloatBallViewController alloc] init];
            vc.title = cachaMsg;
//            vc.isHideNavBar = YES;
            
            CGFloat x = [[NSUserDefaults standardUserDefaults] floatForKey:JPSuspensionDefaultXKey];
            CGFloat y = [[NSUserDefaults standardUserDefaults] floatForKey:JPSuspensionDefaultYKey];
            [JPSEInstance setupSuspensionViewWithTargetVC:vc suspensionXY:CGPointMake(x, y)];
        }
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"ZPM页面库";
    
    [self initData];
    
    [self setupTableView];
    
    [self setupJPSEInstance];
    [self setupSuspensionView];
}

- (void)initData
{
//    ZPMTransitionViewController *vc1 = [[ZPMTransitionViewController alloc] init];
//
//    ZPMFloatBallViewController *vc2 = [ZPMFloatBallViewController new];
//    vc2.hk_iconImage = [UIImage imageNamed:@"icn_color_utils"];
//
//    ZPMLoadingPageViewController *vc3 = [[ZPMLoadingPageViewController alloc] init];
//
//    ZPMEmptyViewController *vc4 = [[ZPMEmptyViewController alloc] initWithStyle:UITableViewStylePlain];
//
//    ZPMBannerViewController *vc5 = [[ZPMBannerViewController alloc] init];
    
    self.listArray = @[@[@{@"title": @"空页面 EmptyPage", @"vc": @"ZPMEmptyViewController"},
                         @{@"title": @"加载页面 LoadingPage", @"vc": @"ZPMLoadingPageViewController"},
                         @{@"title": @"引导页 GuidePage"},
                         @{@"title": @"广告页 AdPage"},
                         @{@"title": @"轮播页 Banner", @"vc": @"ZPMBannerViewController"},
                         @{@"title": @"分类页 CategoryPage", @"vc": @"ZPMCategoryViewController"},
                         ],
                       @[@{@"title": @"页面转场 TransitionPage", @"vc": @"ZPMTransitionViewController"}
                         ],
                       @[@{@"title": @"悬浮小窗", @"vc": @"ZPMFloatBallViewController"}]];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
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
        return @"转场动画";
    }
    return @"页面";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.listArray[indexPath.section][indexPath.row][@"title"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    UIViewController *vc = self.listArray[indexPath.section][indexPath.row][@"vc"];
//    [vc setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:vc animated:YES];
//
    NSString *className = self.listArray[indexPath.section][indexPath.row][@"vc"];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = class.new;
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
