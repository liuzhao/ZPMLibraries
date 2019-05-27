//
//  ZPMBannerCollectionViewCell.m
//  ZPMLibraries
//
//  Created by 刘钊 on 2019/5/25.
//  Copyright © 2019年 Liu Zhao. All rights reserved.
//

#import "ZPMBannerCollectionViewCell.h"

@implementation ZPMBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addImageView];
    }
    return self;
}

- (void)addImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    _imageView = imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = self.bounds;
}

@end
