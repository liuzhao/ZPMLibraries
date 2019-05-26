//
//  ZPMEmptyViewController.m
//  ZPMLibraries
//
//  Created by Liu Zhao on 2019/5/24.
//  Copyright © 2019 Liu Zhao. All rights reserved.
//

#import "ZPMEmptyViewController.h"
#import "UIColor+Hexadecimal.h"
#import "UIScrollView+EmptyDataSet.h"
#import "DetailViewController.h"
#import "Application.h"

static NSString *kReuseIdentifier = @"ZPMCellIdentifier";

@interface ZPMEmptyViewController () <UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSArray *applications;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation ZPMEmptyViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Resets styling
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHex:@"f8f8f8"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"applications" ofType:@"json"];
    self.applications = [Application applicationsFromJSONAtPath:path];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.searchDisplayController.searchResultsTableView.emptyDataSetSource = self;
    self.searchDisplayController.searchResultsTableView.emptyDataSetDelegate = self;
    self.searchDisplayController.searchResultsTableView.tableFooterView = [UIView new];
    [self.searchDisplayController setValue:@"" forKey:@"noResultsMessage"];
    
//    [self setupTableView];
}

- (void)setupTableView
{
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kReuseIdentifier];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    tableView.dataSource = self;
//    tableView.delegate = self;
//    [self.view addSubview:tableView];
//
//    tableView.tableFooterView = [UIView new];
//
//    self.searchDisplayController.searchResultsTableView.emptyDataSetSource = self;
//    self.searchDisplayController.searchResultsTableView.emptyDataSetDelegate = self;
//    self.searchDisplayController.searchResultsTableView.tableFooterView = [UIView new];
//    [self.searchDisplayController setValue:@"" forKey:@"noResultsMessage"];
}

#pragma mark - Getters

- (NSArray *)filteredApps
{
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    if ([searchBar isFirstResponder] && searchBar.text.length > 0)
    {
        NSPredicate *precidate = [NSPredicate predicateWithFormat:@"displayName CONTAINS[cd] %@", searchBar.text];
        return [self.applications filteredArrayUsingPredicate:precidate];
    }
    return self.applications;
}


#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Application Found";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    NSString *text = [NSString stringWithFormat:@"There are no empty dataset examples for \"%@\".", searchBar.text];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[attributedString.string rangeOfString:searchBar.text]];
    
    return attributedString;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = @"Search on the App Store";
    UIFont *font = [UIFont systemFontOfSize:16.0];
    UIColor *textColor = [UIColor colorWithHex:(state == UIControlStateNormal) ? @"007aff" : @"c6def9"];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -64.0;
}

#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
    UISearchBar *searchBar = self.searchDisplayController.searchBar;
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/apps/%@", searchBar.text]];
    
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        [[UIApplication sharedApplication] openURL:URL];
    }
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowCount = [self filteredApps].count;
    
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kReuseIdentifier];
    }
    
    Application *app = [[self filteredApps] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = app.displayName;
    cell.detailTextLabel.text = app.developerName;
    
    UIImage *image = [UIImage imageNamed:app.iconName];
    cell.imageView.image = image;
    
    cell.imageView.layer.cornerRadius = image.size.width*0.2;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.borderColor = [UIColor colorWithWhite:0.0 alpha:0.2].CGColor;
    cell.imageView.layer.borderWidth = 0.5;
    
    cell.imageView.layer.shouldRasterize = YES;
    cell.imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Application *app = [[self filteredApps] objectAtIndex:indexPath.row];
    DetailViewController *controller = [[DetailViewController alloc] initWithApplication:app];
    controller.applications = self.applications;
    controller.allowShuffling = YES;
    
    if ([controller preferredStatusBarStyle] == UIStatusBarStyleLightContent) {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - UISearchBarDelegate Methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // Do something
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // Do something
}


#pragma mark - UISearchDisplayDelegate Methods

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
    // Do something
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    // Do something
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    // Do something
}


#pragma mark - View Auto-Rotation

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
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
