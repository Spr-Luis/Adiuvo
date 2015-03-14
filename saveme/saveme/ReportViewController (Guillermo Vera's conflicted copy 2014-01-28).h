//
//  ReportViewController.h
//  SaveME
//
//  Crea/Users/GuillermoVera/Dropbox/Hack DF/SaveME/SaveME/GUI/SI@2x.pngted by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SAMultisectorControl.h"
#import <CoreLocation/CoreLocation.h>
#import "EAIntroPage.h"
#import "EAIntroView.h"
@interface ReportViewController : UIViewController<EAIntroDelegate>


@property (weak, nonatomic) IBOutlet SAMultisectorControl *multisectorControl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
