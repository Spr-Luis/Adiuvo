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
@property (nonatomic, strong) IBOutlet UILabel *rangeLabel;

@end

@implementation ReportViewController{
    NSMutableArray *imgCarouselNew;
}
@synthesize mapView;
//View Controller Strings
static NSString * const sampleDesc1 = @"Mantener la calma y verificar que la persona desaparecida no contesta ningún medio de comunicación.";

static NSString * const sampleDesc2 = @"Esclarecer si la desaparición de la persona ha sido voluntario, accidental o forzada.";

static NSString * const sampleDesc3 = @"Entrevista a familiares, amigos y conocidos, para verificar sobre el estado del paradero de la persona desaparecida.";

static NSString * const sampleDesc4 = @"Hacer una inspección de los lugares que frecuenta la persona desaparecida.";

static NSString * const sampleDesc5 = @"En caso de haber realizado estas ultimas acciones y no se tiene una respuesta clara, favor de llenar el siguiente formulario. Debe de tener en cuenta que está aplicación es sólo una ayuda comunitaria, y en ningún momento sustituye la ayuda de las autoridades correspondientes.";


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
    //self.halo.position = self.view.center;
    self.halo.backgroundColor = [UIColor redColor].CGColor;
    //[self.view.layer insertSublayer:self.halo below:self.multisectorControl.layer];
    
    [self.mapView setDelegate:self];
    [_imgCarousel setDelegate:self];
    [_imgCarousel setDataSource:self];
    
    _imgCarousel.type = iCarouselTypeRotary;
    _imgCarousel.decelerationRate = 0.5f;
    _imgCarousel.perspective = - 1 / 300;
    
    imgCarouselNew = [[NSMutableArray alloc] init];
    
    [_scrollView setScrollEnabled:YES];
    [_scrollView setContentSize:CGSizeMake(320, 100)];
    
    [_nombreTextField setDelegate:self];
    [_alturaTextField setDelegate:self];


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
    
    
    self.halo.position = touchPoint;
    [self.mapView.layer addSublayer:self.halo];
    
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
    page1.title = @"Mantener la calma";
    page1.desc = sampleDesc1;
    //And images
    page1.bgImage = [UIImage imageNamed:@"blue.png"];
    page1.titleImage = [UIImage imageNamed:@"SI.png"];
    page1.descPositionY = 215.0f;
    page1.titlePositionY = page1.descPositionY+30;
    
    
    //the same w da other 3 pages
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Investigar";
    page2.desc = sampleDesc2;
    page2.bgImage = [UIImage imageNamed:@"fondo5.png"];
    page2.titleImage = [UIImage imageNamed:@"SI.png"];
    page2.descPositionY = 200.0f;
    page2.titlePositionY = page1.descPositionY+30;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Entrevistar";
    page3.desc = sampleDesc3;
    page3.bgImage = [UIImage imageNamed:@"fondo-verde.png"];
    page3.titleImage = [UIImage imageNamed:@"SI.png"];
    page3.descPositionY = 180.0f;
    page3.titlePositionY = page1.descPositionY+20;
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Inspeccionar";
    page4.desc = sampleDesc4;
    page4.bgImage = [UIImage imageNamed:@"deepblue.png"];
    page4.titleImage = [UIImage imageNamed:@"SI.png"];
    page4.descPositionY = 220.0f;
    //page4.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    page4.pageView.alpha = 0.0;
    page4.titlePositionY = page4.descPositionY+20;
    
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = @"Denunciar";
    page5.desc = sampleDesc5;
    page5.bgImage = [UIImage imageNamed:@"deepblue.png"];
    page5.titleImage = [UIImage imageNamed:@"SI.png"];
    page5.descPositionY = 220.0f;
    //page5.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    page5.pageView.alpha = 0.0;
    page5.titlePositionY = page5.descPositionY+20;
    
    //Set the pages to my intro view
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.frame andPages:@[page1,page2,page3,page4, page5]];
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
    _rangeLabel.text = [NSString stringWithFormat:@"%.2f", [[_multisectorControl.sectors objectAtIndex:0] endValue]];
    _halo.radius = [[_multisectorControl.sectors objectAtIndex:0] endValue];
  }
- (IBAction)makeMapBigger:(id)sender {
    // First create the view if you haven't
    
    CGRect newFrameOfMyView = CGRectMake(0.0f,0.0f ,self.view.frame.size.width,self.view.frame.size.height
                                         );
 
    [[self mapView]bringSubviewToFront:self.mapView];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.mapView.frame = newFrameOfMyView;
                     }
                     completion:^(BOOL finished){ 
                         NSLog( @"woo! Finished animating the frame of myView!" ); 
                     }];
}
- (IBAction)makeMapMoreSmall:(id)sender {
    CGRect newFrameOfMyView = CGRectMake(0.0f,420.0f ,self.view.frame.size.width,self.view.frame.size.height
                                         );
    
    [[self mapView]bringSubviewToFront:self.mapView];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.mapView.frame = newFrameOfMyView;
                     }
                     completion:^(BOOL finished){
                         NSLog( @"woo! Finished animating the frame of myView!" );
                     }];
}

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    if([self.mapView.annotations count] >= 1){
        NSLog(@"Have 1 %i",[self.mapView.annotations count]);
        MKPointAnnotation *annot = [[MKPointAnnotation alloc] init];
        annot = [self.mapView.annotations lastObject];
        CGPoint point = [self.mapView convertCoordinate:annot.coordinate toPointToView:self.mapView];
        NSLog(@"%f y %f",point.x, point.y);
        self.halo.position = point;
        [self.mapView.layer addSublayer:self.halo];
    }
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState{
    
    NSLog(@"Anotation");
}
- (IBAction)arButton:(id)sender {
    
    [self performSegueWithIdentifier:@"memo" sender:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //[self dismissModalViewControllerAnimated:YES];
    
    NZCircularImageView *chosenImage = info[UIImagePickerControllerEditedImage];
    [imgCarouselNew addObject:chosenImage];
    [_imgCarousel reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

// Métodos Carousel
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [imgCarouselNew count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[NZCircularImageView alloc] initWithFrame:CGRectMake(0, 0, 90.0f, 90.0f)];
        
        ((NZCircularImageView *)view).image = [imgCarouselNew objectAtIndex:index];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
        view.layer.shadowOpacity = 0.41f;
        view.layer.shadowRadius = 5.0f;
        
    }
    
    return view;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    
    
}
- (IBAction)addImage:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setDelegate:self];
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:^{
        [_imgCarousel reloadData];
    }];
}

- (IBAction)aniosStepper:(UIStepper *)sender {
    NSInteger valor = sender.value;
    _edadLabel.text = [NSString stringWithFormat:@"%d años", valor];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_alturaTextField resignFirstResponder];
    [_nombreTextField resignFirstResponder];

    return YES;
}
@end
