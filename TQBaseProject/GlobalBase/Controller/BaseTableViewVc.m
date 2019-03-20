//
//  GloballBaseTableViewVc.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseTableViewVc.h"
#import "TQBaseProject.h"
#import <MJRefresh/MJRefresh.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface BaseTableViewVc ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation BaseTableViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.tableView.superview) {
        [self.view addSubview:self.tableView];
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView.superview).insets(UIEdgeInsetsZero);
    }];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    UIImage *image = [UIImage imageNamed:self.empty_Imageplaceholder];
    return image;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = self.empty_placeholder;
    
    NSDictionary *attributes = @{NSFontAttributeName: UIFontBoldMake(16),
                                 NSForegroundColorAttributeName: RGBA(153, 153, 153, 1)};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes = @{NSFontAttributeName: UIFontMake(16),NSForegroundColorAttributeName:RGBA(153, 153, 153, 1)};
    
    return [[NSAttributedString alloc] initWithString:self.empty_ButtonTitle attributes:attributes];
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    if (self.empty_ButtonTitle) {
        UIImage *image = [UIImage imageNamed:@"button_background_icloud_normal"];
        UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
        UIEdgeInsets rectInsets = UIEdgeInsetsMake(-19.0, -90.0, -19.0, -90.0);
        image = [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
        return image;
    }
    return nil;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    [self didTapEmptyButton];
}

- (void)didTapEmptyButton{
    
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return H6(15);
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}


- (void)setupTableViewHeardRefresh:(SEL)sel{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:sel];
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)self.tableView.mj_header;
    header.lastUpdatedTimeLabel.hidden = YES;
}

- (void)setupTableViewFooterRefresh:(SEL)sel{
    self.tableView.estimatedRowHeight = 0;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:sel];
}

- (void)stopTableViewRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)stopHeaderRefresh{
    [self.tableView.mj_header endRefreshing];
}

- (void)stopFooterRefresh{
    [self.tableView.mj_footer endRefreshing];
}


- (void)startReloadHederView{
    [self.tableView.mj_header beginRefreshing];
}

- (void)resetNoMoreData{
    [self.tableView.mj_footer resetNoMoreData];
}

-(void)endRefreshingWithNoMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
