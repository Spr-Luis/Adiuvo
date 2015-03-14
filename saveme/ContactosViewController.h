//
//  ContactosViewController.h
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import "DatoCelda.h"


@interface ContactosViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *conTable;
- (IBAction)selContacts:(UIButton *)sender;

@end
