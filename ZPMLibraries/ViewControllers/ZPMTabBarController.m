//
//  ZPMTabBarController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMTabBarController.h"
#import "ZPMControlLibViewController.h"
#import "ZPMPageLibViewController.h"
#import "ZPMAnimationLibViewController.h"
#import "ZPMUnitLibViewController.h"
#import "ZPMDebugViewController.h"
#import "HKFloatManager.h"

@interface ZPMTabBarController ()

@end

@implementation ZPMTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupMainViewControllers];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupMainViewControllers
{
    ZPMControlLibViewController *vc1 = [[ZPMControlLibViewController alloc] init];
    ZPMPageLibViewController *vc2 = [[ZPMPageLibViewController alloc] init];
    ZPMAnimationLibViewController *vc3 = [[ZPMAnimationLibViewController alloc] init];
    ZPMUnitLibViewController *vc4 = [[ZPMUnitLibViewController alloc] init];
    ZPMDebugViewController *vc5 = [[ZPMDebugViewController alloc] init];
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"控件库"
                                                    image:[UIImage imageNamed:@"icn_color_icn_components"]
                                                      tag:0];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nav2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"页面库"
                                                    image:[UIImage imageNamed:@"icn_color_icn_uikit"]
                                                      tag:1];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nav3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"动画库"
                                                    image:[UIImage imageNamed:@"icn_color_animation"]
                                                      tag:2];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    nav4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"工具库"
                                                    image:[UIImage imageNamed:@"icn_color_utils"]
                                                      tag:3];
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    nav5.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"调试库"
                                                    image:[UIImage imageNamed:@"icn_color_icn_utils"]
                                                      tag:4];
    
    NSArray *items = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    [self setViewControllers:items];
    
    [HKFloatManager addFloatVcs:@[@"ZPMDetailViewController"]];
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
