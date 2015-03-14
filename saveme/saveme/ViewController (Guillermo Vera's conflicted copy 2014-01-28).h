//
//  ViewController.h
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
- (IBAction)panicButtonPressed:(id)sender;
- (IBAction)moreButtonPressed:(id)sender;
- (IBAction)trackMEButtonPressed:(id)sender;
- (IBAction)findRoutesButton:(id)sender;
- (IBAction)peopleButtonPressed:(id)sender;

@end
