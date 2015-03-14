//
//  PanicViewController.h
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface PanicViewController : UIViewController<UIAlertViewDelegate, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong)UIImage*theImage;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *typeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
