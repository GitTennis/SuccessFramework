//
//  MenuViewController.h
//  _BusinessApp_
//
//  Created by Gytenis Mikulėnas on 5/16/14.
//  Copyright (c) 2014 Gytenis Mikulėnas. All rights reserved.
//

#import "BaseViewController.h"

@class MenuModel;

@interface MenuViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) MenuModel *model;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
