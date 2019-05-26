//
//  ZPMSuspensionViewController.m
//  ZPMLibraries
//
//  Created by 刘钊 on 2019/5/26.
//  Copyright © 2019年 Liu Zhao. All rights reserved.
//

#import "ZPMSuspensionViewController.h"
#import "YBPopupMenu.h"

#define TITLES @[@"修改", @"删除", @"扫一扫",@"付款"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]

@interface ZPMSuspensionViewController () <YBPopupMenuDelegate,UITextFieldDelegate>

@property (weak, nonatomic) UITextField *textField;
@property (weak, nonatomic) UILabel *customCellView;

@property (nonatomic, strong) YBPopupMenu *popupMenu;

@end

@implementation ZPMSuspensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn setFrame:CGRectMake(0, 0, 40, 40)];
    [btn addTarget:self action:@selector(onPopupClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [btn2 setFrame:CGRectMake(0, 0, 40, 40)];
    btn2.center = self.view.center;
    [btn2 addTarget:self action:@selector(onTestClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 170, (self.view.frame.size.width - 100), 40)];
    textField.delegate = self;
    textField.placeholder = @"请输入文字";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    self.textField = textField;
}

- (void)onPopupClick:(id)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:120 delegate:self];
}

- (void)onTestClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:@[@"111",@"222",@"333",@"444",@"555",@"666",@"777",@"888"] icons:nil menuWidth:100 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionLeft;
        popupMenu.borderWidth = 1;
        popupMenu.borderColor = [UIColor redColor];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView: self.view];
    
    if (CGRectContainsPoint(self.customCellView.frame, p)) {
        [self showCustomPopupMenuWithPoint:p];
    }else {
        [self showDarkPopupMenuWithPoint:p];
    }
}

- (void)showDarkPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = NO;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.offset = 10;
        popupMenu.type = YBPopupMenuTypeDark;
        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    }];
}

- (void)showCustomPopupMenuWithPoint:(CGPoint)point
{
    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.dismissOnSelected = YES;
        popupMenu.isShowShadow = YES;
        popupMenu.delegate = self;
        popupMenu.type = YBPopupMenuTypeDefault;
        popupMenu.cornerRadius = 8;
        popupMenu.rectCorner = UIRectCornerTopLeft| UIRectCornerTopRight;
        popupMenu.tag = 100;
        //如果不加这句默认是 UITableViewCellSeparatorStyleNone 的
        popupMenu.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    //推荐回调
    NSLog(@"点击了 %@ 选项",ybPopupMenu.titles[index]);
}

- (void)ybPopupMenuBeganDismiss
{
    if (self.textField.isFirstResponder) {
        [self.textField resignFirstResponder];
    }
}

//- (UITableViewCell *)ybPopupMenu:(YBPopupMenu *)ybPopupMenu cellForRowAtIndex:(NSInteger)index
//{
//    if (ybPopupMenu.tag != 100) {
//        return nil;
//    }
//    static NSString * identifier = @"customCell";
//    CustomTestCell * cell = [ybPopupMenu.tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTestCell" owner:self options:nil] firstObject];
//    }
//
//    cell.titleLabel.text = TITLES[index];
//    cell.iconImageView.image = [UIImage imageNamed:ICONS[index]];
//
//    switch (index) {
//        case 0:
//            cell.statusLabel.hidden = NO;
//            cell.badge.hidden = YES;
//            break;
//        case 2:
//            cell.statusLabel.hidden = YES;
//            cell.badge.hidden = NO;
//            break;
//        default:
//            cell.statusLabel.hidden = YES;
//            cell.badge.hidden = YES;
//            break;
//    }
//
//    return cell;
//}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _popupMenu = [YBPopupMenu showRelyOnView:textField titles:@[@"密码必须为数字、大写字母、小写字母和特殊字符中至少三种的组合，长度不少于8且不大于20"] icons:nil menuWidth:textField.bounds.size.width otherSettings:^(YBPopupMenu *popupMenu) {
        popupMenu.delegate = self;
        popupMenu.showMaskView = NO;
        popupMenu.priorityDirection = YBPopupMenuPriorityDirectionBottom;
        popupMenu.maxVisibleCount = 1;
        popupMenu.itemHeight = 60;
        popupMenu.borderWidth = 1;
        popupMenu.fontSize = 12;
        popupMenu.dismissOnTouchOutside = YES;
        popupMenu.dismissOnSelected = NO;
        popupMenu.borderColor = [UIColor brownColor];
        popupMenu.textColor = [UIColor brownColor];
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_popupMenu dismiss];
    return YES;
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
