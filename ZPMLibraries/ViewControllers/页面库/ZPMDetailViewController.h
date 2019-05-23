//
//  ZPMDetailViewController.h
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/23.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZPMDetailViewController : UIViewController

/**
 是否显示提示
 */
@property (nonatomic, assign) BOOL isShowTip;

@property (nonatomic, assign) BOOL isShowTap;

@property (nonatomic, strong) UIImage *hk_iconImage;

@end

NS_ASSUME_NONNULL_END
