//
//  GlobalTableView.m
//  NewAquarium
//
//  Created by WORKSQ on 2018/12/29.
//  Copyright © 2018 TSQ. All rights reserved.
//

#import "GlobalTableView.h"
#import <MJRefresh/MJRefresh.h>

@interface GlobalTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation GlobalTableView

+ (instancetype)loadGroupedTableView{
    GlobalTableView *view = [[self alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    return view;
}

+ (instancetype)loadPlainTableView{
    GlobalTableView *view = [[self alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return self;
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
