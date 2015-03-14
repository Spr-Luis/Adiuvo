//
//  iSeeThereViewController.h
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iSeeThereViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *alturaTextField;
@property (strong, nonatomic) IBOutlet UITextField *edadTextField;

- (IBAction)hairColor:(id)sender;
- (IBAction)eyesColor:(id)sender;
- (IBAction)sexType:(id)sender;
@end
