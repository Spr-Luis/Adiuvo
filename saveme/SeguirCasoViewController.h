//
//  SeguirCasoViewController.h
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "NZCircularImageView.h"


@interface SeguirCasoViewController : UIViewController<MKMapViewDelegate>

@property NSString* Folio;
@property (strong, nonatomic) IBOutlet UILabel *folioLabel;
@property (strong, nonatomic) IBOutlet UILabel *nombreLabel;
@property (strong, nonatomic) IBOutlet UILabel *edadLabel;
@property (strong, nonatomic) IBOutlet NZCircularImageView *image;
@property (strong, nonatomic) IBOutlet MKMapView *map;

@end
