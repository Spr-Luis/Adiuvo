//
//  MainViewController.m
//  CameraOverlay
//
//  Created by Andreas Katzian on 12.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "MainViewController.h"
#import "OverlayView.h"
#import <Social/Social.h>

//transform values for full screen support
#define CAMERA_TRANSFORM_X 1
#define CAMERA_TRANSFORM_Y 1.12412

//iphone screen dimensions
#define SCREEN_WIDTH  320
#define SCREEN_HEIGTH 480


@implementation MainViewController

- (IBAction) showCameraOverlay:(id)sender {
	
	//create an overlay view instance
	OverlayView *overlay = [[OverlayView alloc]
							initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGTH)];
	
	//create a new image picker instance
	UIImagePickerController *picker = 
	[[UIImagePickerController alloc] init];
	//set source to video!
	picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	//hide all controls
	picker.showsCameraControls = NO;
	picker.navigationBarHidden = YES;
	picker.toolbarHidden = YES;
	//make the video preview full size
	picker.wantsFullScreenLayout = YES;
	picker.cameraViewTransform =
	CGAffineTransformScale(picker.cameraViewTransform,
						   CAMERA_TRANSFORM_X,
						   CAMERA_TRANSFORM_Y);
	//set our custom overlay view
	picker.cameraOverlayView = overlay;
	
	//show picker
	[self presentModalViewController:picker animated:YES];	
	
}



- (IBAction)tweetButton:(id)sender
{
    //Create a share vc
    SLComposeViewController* fbController =[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter ];
    //dont use thios shot on simulator
    //    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    //  {
    //And play w it
    SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
        
        [fbController dismissViewControllerAnimated:YES completion:nil];
        
        switch(result){
            case SLComposeViewControllerResultCancelled:
            default:
            {
                NSLog(@"Cancelled.....");
                
            }
                break;
            case SLComposeViewControllerResultDone:
            {
                NSLog(@"Posted....");
            }
                break;
        }};
    //Trivial
    [fbController setInitialText:@"#Adiuvo Ayuda para localizar a la siguiente persona : Guillermo"];
   
    [fbController setCompletionHandler:completionHandler];
    //Present the new share vc
    [self presentViewController:fbController animated:YES completion:nil];

}


@end
