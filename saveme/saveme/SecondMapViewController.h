//
//  SecondMapViewController.h
//  SaveME
//
//  Created by Guillermo Vera on 1/24/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FiscaliaJson.h"


@interface SecondMapViewController : UIViewController <MKMapViewDelegate,UIAlertViewDelegate, MKAnnotation>
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end
