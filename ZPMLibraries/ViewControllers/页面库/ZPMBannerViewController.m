//
//  ZPMBannerViewController.m
//  ZPMLibraries
//
//  Created by 刘钊 on 2019/5/25.
//  Copyright © 2019年 Liu Zhao. All rights reserved.
//

#import "ZPMBannerViewController.h"
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "ZPMBannerCollectionViewCell.h"

@interface ZPMBannerViewController () <TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@property (weak, nonatomic) IBOutlet UISwitch *horCenterSwitch;

@end

@implementation ZPMBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
    
    [self setupMainUI];
}

- (void)setupMainUI
{
    UILabel *layoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, kScreenWidth - 20, 25)];
    layoutLabel.text = @"样式";
    [self.view addSubview:layoutLabel];
    
    UILabel *itemSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, kScreenWidth - 20, 25)];
    itemSizeLabel.text = @"itemSize";
    [self.view addSubview:itemSizeLabel];
    
    UILabel *itemSpaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 420, kScreenWidth - 20, 25)];
    itemSpaceLabel.text = @"itemSpace";
    [self.view addSubview:itemSpaceLabel];
    
    NSArray *items = @[@"Normal", @"Linear", @"Coverflow"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:items];
    [seg setFrame:CGRectMake(90, 300, 240, 30)];
    [seg addTarget:self action:@selector(segChange:) forControlEvents:UIControlEventValueChanged];
    seg.selectedSegmentIndex = 0;
    [self.view addSubview:seg];
    
    UISlider *slider1 = [[UISlider alloc] initWithFrame:CGRectMake(100, 360, kScreenWidth - 120, 25)];
    [slider1 addTarget:self action:@selector(sliderValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    slider1.value = 0.8;
    slider1.tag = 0;
    [self.view addSubview:slider1];
    
    UISlider *slider2 = [[UISlider alloc] initWithFrame:CGRectMake(100, 420, kScreenWidth - 120, 25)];
    [slider2 addTarget:self action:@selector(sliderValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    slider2.value = 0.2;
    slider2.tag = 1;
    [self.view addSubview:slider2];
    
    NSArray *array = @[@"是否循环", @"是否自动"];
    for (int i = 0; i < 2; i++) {
        UILabel *layoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + kScreenWidth/2 * i, 480, 100, 25)];
        layoutLabel.text = array[i];
        [self.view addSubview:layoutLabel];
        
        UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110 + kScreenWidth/2 * i, 480, 100, 25)];
        aSwitch.on = YES;
        aSwitch.tag = i;
        [aSwitch addTarget:self action:@selector(switchValueChangeAction:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:aSwitch];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_pagerView.layout.itemSize = CGSizeMake(CGRectGetWidth(self->_pagerView.frame)*slider1.value, CGRectGetHeight(self->_pagerView.frame)*slider1.value);
        [self->_pagerView setNeedUpdateLayout];
    });
}

- (void)addPagerView {
    TYCyclePagerView *pagerView = [[TYCyclePagerView alloc]initWithFrame:self.view.frame];
    pagerView.layer.borderWidth = 0.5;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    // registerClass or registerNib
    [pagerView registerClass:[ZPMBannerCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"timg01.jpeg"], [UIImage imageNamed:@"timg02.jpeg"], [UIImage imageNamed:@"temp03.jpg"], [UIImage imageNamed:@"temp04.jpg"],nil];
    //    for (int i = 0; i < 7; ++i) {
    ////        if (i == 0) {
    ////            [datas addObject:[UIColor redColor]];
    ////            continue;
    ////        }
    ////        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    ////        [datas addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"timg01.jpeg"]]];
    //    }
    
    
    
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
    //[_pagerView scrollToItemAtIndex:3 animate:YES];
}

//- (void)loadData {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSMutableArray *datas = [NSMutableArray array];
//        for (int i = 0; i < 5; ++i) {
//            if (i == 0) {
//                [datas addObject:[UIColor redColor]];
//                continue;
//            }
//            [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
//        }
//        _datas = [datas copy];
//        _pageControl.numberOfPages = _datas.count;
//        [_pagerView reloadData];
//    });
//}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    ZPMBannerCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    //    cell.backgroundColor = _datas[index];
    cell.imageView.image = _datas[index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(CGRectGetWidth(pageView.frame), CGRectGetHeight(pageView.frame));
    layout.itemSpacing = 15;
    //layout.minimumAlpha = 0.3;
    layout.itemHorizontalCenter = _horCenterSwitch.isOn;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index
{
    NSLog(@"%zd",index);
}

#pragma mark - action

- (IBAction)switchValueChangeAction:(UISwitch *)sender {
    if (sender.tag == 0) {
        _pagerView.isInfiniteLoop = sender.isOn;
        [_pagerView updateData];
    }else if (sender.tag == 1) {
        _pagerView.autoScrollInterval = sender.isOn ? 3.0:0;
    }else if (sender.tag == 2) {
        _pagerView.layout.itemHorizontalCenter = sender.isOn;
        [UIView animateWithDuration:0.3 animations:^{
            [self->_pagerView setNeedUpdateLayout];
        }];
    }
}

- (IBAction)sliderValueChangeAction:(UISlider *)sender {
    if (sender.tag == 0) {
        _pagerView.layout.itemSize = CGSizeMake(CGRectGetWidth(_pagerView.frame)*sender.value, CGRectGetHeight(_pagerView.frame)*sender.value);
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 1) {
        _pagerView.layout.itemSpacing = 30*sender.value;
        [_pagerView setNeedUpdateLayout];
    }else if (sender.tag == 2) {
        _pageControl.pageIndicatorSize = CGSizeMake(6*(1+sender.value), 6*(1+sender.value));
        _pageControl.currentPageIndicatorSize = CGSizeMake(8*(1+sender.value), 8*(1+sender.value));
        _pageControl.pageIndicatorSpaing = (1+sender.value)*10;
    }
}

- (void)segChange:(UISegmentedControl *)sender
{
    _pagerView.layout.layoutType = sender.selectedSegmentIndex;
    [_pagerView setNeedUpdateLayout];
}

- (IBAction)buttonAction:(UIButton *)sender {
    _pagerView.layout.layoutType = sender.tag;
    [_pagerView setNeedUpdateLayout];
}

- (void)pageControlValueChangeAction:(TYPageControl *)sender {
    NSLog(@"pageControlValueChangeAction: %ld",sender.currentPage);
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
