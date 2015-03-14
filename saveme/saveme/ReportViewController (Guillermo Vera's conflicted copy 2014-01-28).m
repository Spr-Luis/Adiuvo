//
//  ReportViewController.m
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "ReportViewController.h"
#import "PulsingHaloLayer.h"
@interface ReportViewController ()
@property (nonatomic, strong) PulsingHaloLayer *halo;
@end

@implementation ReportViewController
@synthesize mapView;
//View Controller Strings
static NSString * const sampleDesc1 = @"Manten la calma mi chavo";
static NSString * const sampleDesc2 = @"Llama afamiliares wey";

static NSString * const sampleDesc3 = @"Revisa fechas y horarios";

static NSString * const sampleDesc4 = @"Asegura el pedo";




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 0.5; //user needs to press for 2 seconds
    [self.mapView addGestureRecognizer:lpgr];
    [self showIntro];
    [self setupMultisectorControl];
    [self setupDesign];

    self.halo = [PulsingHaloLayer layer];
    self.halo.position = self.view.center;
    [self.view.layer insertSublayer:self.halo below:self.multisectorControl.layer];

}

// =============================================================================



- (void)setupDesign{
    self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    [[self mapView]removeAnnotations:mapView.annotations];
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate =
    [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
    annot.coordinate = touchMapCoordinate;
    [self.mapView addAnnotation:annot];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showIntro{
    //self.navigationController.navigationBar.hidden = NO;
       //Create page
    EAIntroPage *page1 = [EAIntroPage page];
    //set title
    page1.title = @"Uno";
    page1.desc = sampleDesc1;
    //And images
    page1.bgImage = [UIImage imageNamed:@"blue.png"];
    page1.titleImage = [UIImage imageNamed:@"SI.png"];
    page1.descPositionY = 215.0f;
    page1.titlePositionY = page1.descPositionY+30;
    
    
    //the same w da other 3 pages
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Dos";
    page2.desc = sampleDesc2;
    page2.bgImage = [UIImage imageNamed:@"fondo5.png"];
    page2.titleImage = [UIImage imageNamed:@"SI.png"];
    page2.descPositionY = 200.0f;
    page2.titlePositionY = page1.descPositionY+30;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Tres";
    page3.desc = sampleDesc3;
    page3.bgImage = [UIImage imageNamed:@"fondo-verde.png"];
    page3.titleImage = [UIImage imageNamed:@"SI.png"];
    page3.descPositionY = 180.0f;
    page3.titlePositionY = page1.descPositionY+20;
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Cuatro";
    page4.desc = sampleDesc4;
    page4.bgImage = [UIImage imageNamed:@"deepblue.png"];
    page4.titleImage = [UIImage imageNamed:@"SI.png"];
    page4.descPositionY = 220.0f;
    page4.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    page4.pageView.alpha = 0.0;
    
    
    page4.titlePositionY = page4.descPositionY+20;
    
    //Set the pages to my intro view
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.frame andPages:@[page1,page2,page3,page4]];
    //set delegate to self class
    [intro setDelegate:self];
    //Amd show the intro view
    [intro showInView:self.view animateDuration:0.3];
    [[intro pageControl] setTransform:CGAffineTransformFromString(@"memo")];
    intro.skipButton.hidden = NO;
    
  //  self.navigationController.navigationBar.hidden = YES;
}


- (void)setupMultisectorControl{
    [self.multisectorControl addTarget:self action:@selector(multisectorValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIColor *greenColor = [UIColor colorWithRed:29.0/255.0 green:207.0/255.0 blue:0.0 alpha:1.0];
    SAMultisectorSector *sector1 = [SAMultisectorSector sectorWithColor:greenColor maxValue:16.0];
    sector1.tag = 0;
    sector1.endValue = 13.0;
    [self.multisectorControl addSector:sector1];
    [self updateDataView];
}

- (void)multisectorValueChanged:(id)sender{
    [self updateDataView];
}

- (void)updateDataView{
  }


@end
