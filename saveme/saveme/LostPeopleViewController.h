//
//  LostPeopleViewController.h
//  SaveME
//
//  Created by Lu1s_Armandho0 on 26/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"


@interface LostPeopleViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
