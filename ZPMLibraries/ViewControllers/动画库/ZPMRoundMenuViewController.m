//
//  ZPMRoundMenuViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/28.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMRoundMenuViewController.h"
#import "XXXRoundMenuButton.h"

@interface ZPMRoundMenuViewController ()

@property (strong, nonatomic) XXXRoundMenuButton *roundMenu;
@property (strong, nonatomic) XXXRoundMenuButton *roundMenu2;

@end

@implementation ZPMRoundMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.roundMenu = [[XXXRoundMenuButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.roundMenu.center = self.view.center;
    self.roundMenu.centerButtonSize = CGSizeMake(44, 44);
    self.roundMenu.centerIconType = XXXIconTypeUserDraw;
    self.roundMenu.tintColor = [UIColor whiteColor];
    self.roundMenu.jumpOutButtonOnebyOne = YES;
    [self.view addSubview:self.roundMenu];
    
    [self.roundMenu setDrawCenterButtonIconBlock:^(CGRect rect, UIControlState state) {
        
        if (state == UIControlStateNormal)
        {
            UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 - 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectanglePath fill];
            
            
            UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle2Path fill];
            
            UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRect: CGRectMake((rect.size.width - 15)/2, rect.size.height/2 + 5, 15, 1)];
            [UIColor.whiteColor setFill];
            [rectangle3Path fill];
        }
    }];
    
    [self.roundMenu loadButtonWithIcons:@[
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"],
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"],
                                          [UIImage imageNamed:@"icon_can"],
                                          [UIImage imageNamed:@"icon_pos"],
                                          [UIImage imageNamed:@"icon_img"]
                                          
                                          ] startDegree:0 layoutDegree:M_PI*2*7/8];
    
    [self.roundMenu setButtonClickBlock:^(NSInteger idx) {
        
        NSLog(@"button %@ clicked !",@(idx));
    }];
    
    
    
    
    
    /**
     *  RoundMenu2 config
     */
    self.roundMenu2 = [[XXXRoundMenuButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100 - 30, kScreenHeight - 100 - 30, 200, 200)];
    [self.view addSubview:self.roundMenu2];
    [self.roundMenu2 loadButtonWithIcons:@[
                                           [UIImage imageNamed:@"icon_can"],
                                           [UIImage imageNamed:@"icon_pos"],
                                           [UIImage imageNamed:@"icon_img"]
                                           
                                           ] startDegree:-M_PI layoutDegree:M_PI/2];
    [self.roundMenu2 setButtonClickBlock:^(NSInteger idx) {
        
        NSLog(@"button %@ clicked !",@(idx));
    }];
    
    self.roundMenu2.tintColor = [UIColor whiteColor];
    
    self.roundMenu2.mainColor = [UIColor colorWithRed:0.13 green:0.58 blue:0.95 alpha:1];
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
