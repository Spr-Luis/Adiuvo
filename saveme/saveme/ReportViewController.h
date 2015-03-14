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
#import "iCarousel.h"
#import "NZCircularImageView.h"
#import <Social/Social.h>
#import <Parse/Parse.h>
#import "SecondMapViewController.h"
#import "DatoCelda.h"
#import <QuartzCore/QuartzCore.h>
#import "SecondMapViewController.h"


@interface ReportViewController : UIViewController<EAIntroDelegate, MKMapViewDelegate,UIImagePickerControllerDelegate, iCarouselDataSource, iCarouselDelegate
,UITextFieldDelegate>

@property NSString* Folio;

@property (strong, nonatomic) IBOutlet iCarousel *imgCarousel;

@property (weak, nonatomic) IBOutlet SAMultisectorControl *multisectorControl;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)addImage:(UIButton *)sender;
- (IBAction)aniosStepper:(UIStepper *)sender;
@property (strong, nonatomic) IBOutlet UILabel *edadLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UILabel *labelAyuda;

// IBOulet TextFields
@property (strong, nonatomic) IBOutlet UITextField *nombreTextField;
@property (strong, nonatomic) IBOutlet UITextField *alturaTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneContact;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UITextField *edadTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;

- (IBAction)hairColor:(id)sender;
- (IBAction)saveButton:(id)sender;
- (IBAction)eyesColor:(id)sender;
- (IBAction)sexType:(id)sender;




@end
