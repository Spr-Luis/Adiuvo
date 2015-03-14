//
//  ModalViewController.m
//  eLBeePushBackController
//
//  Created by Jonathon Hibbard on 7/9/13.
//  Copyright (c) 2013 Integrated Events. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController()
@property (weak, nonatomic) IBOutlet UIButton *directionsButton;
@property(nonatomic,strong)CLLocationManager* locationManager;

-(IBAction)dismissAction;

@end


@implementation ModalViewController

//this will return to the superview
-(IBAction)dismissAction {
    [self.delegate pushBackVCDelegateShouldDismissController:self];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
}


@end
