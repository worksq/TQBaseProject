//
//  GloballBaseTableViewVc.h
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseController.h"

@interface BaseTableViewVc : BaseController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic,copy) NSString *empty_Imageplaceholder;
@property (nonatomic,copy) NSString *empty_placeholder;
@property (nonatomic,copy) NSString *empty_ButtonTitle;
- (void)didTapEmptyButton;

- (void)setupTableViewHeardRefresh:(SEL)sel;
- (void)setupTableViewFooterRefresh:(SEL)sel;

- (void)endRefreshingWithNoMoreData;
- (void)resetNoMoreData;

- (void)stopTableViewRefresh;
- (void)startReloadHederView;

- (void)stopFooterRefresh;
- (void)stopHeaderRefresh;

@end
