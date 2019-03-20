//
//  BaseStaticTableViewVc.h
//  NewAquarium
//
//  Created by apple on 2018/10/7.
//  Copyright © 2018年 TSQ. All rights reserved.
//

#import "BaseController.h"
#import <RETableViewManager/RETableViewManager.h>

@interface BaseStaticTableViewVc : BaseController<RETableViewManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@end
