//
//  ZPMFloatBallViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/23.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMFloatBallViewController.h"

@interface ZPMFloatBallViewController ()

@end

@implementation ZPMFloatBallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - JPSuspensionEntranceProtocol

- (BOOL)jp_isHideNavigationBar {
    return NO;
}

- (NSString *)jp_suspensionCacheMsg {
    return self.title;
}

//- (UIImage *)jp_suspensionLogoImage {
//    return self.logoImage;
//}
//
//- (void)jp_requestSuspensionLogoImageWithLogoView:(UIImageView *)logoView {
//    __weak typeof(self) weakSelf = self;
//    [logoView sd_setImageWithURL:[NSURL URLWithString:JPTestImageURLStr] placeholderImage:nil options:SDWebImageTransformAnimatedImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (weakSelf) weakSelf.logoImage = image;
//    }];
//}

@end
