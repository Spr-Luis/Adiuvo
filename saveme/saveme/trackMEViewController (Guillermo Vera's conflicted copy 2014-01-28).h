//
//  trackMEViewController.h
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TGFoursquareLocationDetail.h"
#import "DetailLocationCell.h"
#import "AddressLocationCell.h"
#import "UserCell.h"
#import "TipCell.h"
#import "TGAnnotation.h"

@interface trackMEViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,TGFoursquareLocationDetailDelegate, KIImagePagerDelegate, KIImagePagerDataSource>

@property (nonatomic, strong) TGFoursquareLocationDetail *locationDetail;
@property (nonatomic, strong) MKMapView *map;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@end
