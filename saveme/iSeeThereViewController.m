//
//  iSeeThereViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "iSeeThereViewController.h"

@interface iSeeThereViewController ()

@end

@implementation iSeeThereViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_alturaTextField setDelegate:self];
    [_edadTextField setDelegate:self];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_alturaTextField resignFirstResponder];
    [_edadTextField resignFirstResponder];
    return YES;
}


- (IBAction)hairColor:(id)sender {
    UIButton *button = (UIButton*)sender;
    CGRect f = button.frame;
    if(f.size.height < 40){
        f.size.height +=10;
        f.size.width += 10;
        f.origin.x -= 5;
        f.origin.y -= 5;
        button.frame = f;
    }
}

- (IBAction)eyesColor:(id)sender {
    UIButton *button = (UIButton*)sender;
    CGRect f = button.frame;
    if(f.size.height < 40){
        f.size.height +=10;
        f.size.width += 10;
        f.origin.x -= 5;
        f.origin.y -= 5;
        button.frame = f;
    }
}

- (IBAction)sexType:(id)sender {
    UIButton *button = (UIButton*)sender;
    CGRect f = button.frame;
    if(f.size.height < 40){
        f.size.height +=10;
        f.size.width += 10;
        f.origin.x -= 5;
        f.origin.y -= 5;
        button.frame = f;
    }
}

@end
