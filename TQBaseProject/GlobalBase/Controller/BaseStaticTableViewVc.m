//
//  BaseStaticTableViewVc.m
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseStaticTableViewVc.h"
#import "TQBaseProject.h"

@interface BaseStaticTableViewVc ()

@end

@implementation BaseStaticTableViewVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    self.manager.style.cellHeight = 60;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView.superview).insets(UIEdgeInsetsZero);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didLoadCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.textLabel.font = UIFontMake(16);
    cell.detailTextLabel.font = UIFontMake(16);
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

@end
