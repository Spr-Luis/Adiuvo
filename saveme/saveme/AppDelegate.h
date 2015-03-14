//
//  AppDelegate.h
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "MEMOUtilities.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FiscaliaJson.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *names;
@property (strong, nonatomic) NSMutableArray *direcciones;
@property (strong, nonatomic) NSMutableArray *latitudes;
@property (strong, nonatomic) NSMutableArray *longitudes;
@property (strong, nonatomic) MEMOUtilities *memoPorfa;

@end
