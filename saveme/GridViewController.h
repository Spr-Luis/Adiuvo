//
//  GridViewController.h
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "trackMEViewController.h"

@interface GridViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *grid;

@property NSMutableArray *array;

@end
