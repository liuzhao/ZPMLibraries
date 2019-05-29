//
//  DZNDetailViewController.h
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/29.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Application.h"

NS_ASSUME_NONNULL_BEGIN

@interface DZNDetailViewController : UITableViewController

@property (nonatomic, weak) NSArray *applications;
@property (nonatomic) BOOL allowShuffling;

- (instancetype)initWithApplication:(Application *)app;

@end

NS_ASSUME_NONNULL_END
