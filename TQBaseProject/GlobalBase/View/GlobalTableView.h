//
//  GlobalTableView.h
//  NewAquarium
//
//  Created by WORKSQ on 2018/12/29.
//  Copyright © 2018 TSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GlobalTableView : UITableView
+ (instancetype)loadPlainTableView;
+ (instancetype)loadGroupedTableView;
@property (nonatomic,strong) NSMutableArray *dataList;
@end

NS_ASSUME_NONNULL_END
