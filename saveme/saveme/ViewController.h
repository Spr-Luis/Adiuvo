//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,MKMapViewDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property NSString* FolioVC;

@property (weak, nonatomic) IBOutlet UIView *menuView;
- (IBAction)panicButtonPressed:(id)sender;
- (IBAction)moreButtonPressed:(id)sender;
- (IBAction)trackMEButtonPressed:(id)sender;
- (IBAction)findRoutesButton:(id)sender;
- (IBAction)siguemeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *SeRCH;
@property (strong, nonatomic) IBOutlet UIButton *botonMenu;
- (IBAction)seePeople:(id)sender;

@end
