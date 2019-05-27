//
//  AppDelegate.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/22.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "AppDelegate.h"
#import "ZPMTabBarController.h"
#import "TABAnimated.h"
#import "LLDebug.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initTABAnimated];
    
    [self initLLDebug];
    
    [self setupMainView];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupMainView
{
    ZPMTabBarController *tabbar = [[ZPMTabBarController alloc] init];
    [tabbar setSelectedIndex:1];
    self.window.rootViewController = tabbar;
}

- (void)initTABAnimated
{
    // Init `TABAnimated`, and set the properties you need.
    // 初始化TABAnimated，并设置TABAnimated相关属性
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    // open log
    // 开启日志
    [TABAnimated sharedAnimated].openLog = YES;
    // set gobal cornerRadius
    [TABAnimated sharedAnimated].useGlobalCornerRadius = YES;
}

- (void)initLLDebug
{
    //####################### Color Style #######################//
    // Uncomment one of the following lines to change the color configuration.
    // [LLConfig sharedConfig].colorStyle = LLConfigColorStyleSystem;
    // [[LLConfig sharedConfig] configBackgroundColor:[UIColor orangeColor] textColor:[UIColor whiteColor] statusBarStyle:UIStatusBarStyleDefault];
    
    //####################### User Identity #######################//
    // Use this line to tag user. More config please see "LLConfig.h".
    [LLConfig sharedConfig].userIdentity = @"Miss L";
    
    //####################### Window Style #######################//
    // Uncomment one of the following lines to change the window style.
    // [LLConfig sharedConfig].windowStyle = LLConfigWindowNetBar;
    
    //####################### Features #######################//
    // Uncomment this line to change the available features.
    // [LLConfig sharedConfig].availables = LLConfigAvailableNoneAppInfo;
    
    // ####################### Start LLDebugTool #######################//
    // Use this line to start working.
    [[LLDebugTool sharedTool] startWorking];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
