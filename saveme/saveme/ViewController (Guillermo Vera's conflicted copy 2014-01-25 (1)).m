//
//  ViewController.m
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "ViewController.h"
#import "MEMOUtilities.h"
#import "PanicViewController.h"
#import "ReportViewController.h"
#import "SeguirCasoViewController.h"
#import "PulsingHaloLayer.h"


@interface ViewController ()
@property(nonatomic,strong)CLLocationManager* locationManager;
@property(nonatomic,strong) MEMOUtilities* memoPorfa;
@property (strong, nonatomic) IBOutlet UIButton *panicB;
@property (strong, nonatomic) IBOutlet UIButton *moreB;
@property (strong, nonatomic) IBOutlet UIButton *thirdB;
@property (strong, nonatomic) IBOutlet UIButton *trackMEB;
@property (strong, nonatomic) IBOutlet UIButton *findMEB;
@property (strong, nonatomic)  UIImage *takenImage;
@property (strong, nonatomic) MKMapItem *destination;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) NSArray *insecurity;
@property (nonatomic) NSArray *namesInsecurity;




@end

@implementation ViewController
@synthesize map,panicB,moreB,thirdB,trackMEB,findMEB,takenImage;

int memo = 0;

- (void)viewDidLoad
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    double latitude = 19.246470;
    double longitude = -99.101350;
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil] ;
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark] ;
    self.destination= mapItem;
    

    
    _FolioVC = [[NSString alloc] init];
    
    self.map.delegate = self;
    
    self.memoPorfa = [[MEMOUtilities alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self dropPinsFromUserDefaultsWithName:@"peopleNames" lats:@"peopleLats" andLongs:@"peopleLongs" bussines:YES];

    [self setRegion];
    [self addAnimations];
    
    self.insecurity = [[NSArray alloc]initWithObjects:[[CLLocation alloc] initWithLatitude:18.1052 longitude:-95.1842],[[CLLocation alloc] initWithLatitude:19.3511 longitude:-95.1842],[[CLLocation alloc] initWithLatitude:19.27936 longitude:-99.12665],[[CLLocation alloc] initWithLatitude:20.6594 longitude:-100.3222], nil];
    
    self.namesInsecurity = [[NSArray alloc] initWithObjects:@"Tepito", @"Iztapalapa", @"Xochimilco", @"Milpa Alta",nil];
}

-(void)setRegion{
    //set new region to the users location
    MKCoordinateRegion newRwgion;
        newRwgion = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 2500, 2500);
    [map setRegion:newRwgion animated:YES];
}

-(void)addAnimations
{
    MEMOUtilities *memo = [[MEMOUtilities alloc ]init];
    [memo addEntranceAnimationToLayer:self.panicB.layer withDelay:0.5];
    [memo addEntranceAnimationToLayer:self.moreB.layer withDelay:0.6];
    [memo addEntranceAnimationToLayer:self.findMEB.layer withDelay:0.7];
    [memo addEntranceAnimationToLayer:self.thirdB.layer withDelay:0.8];
    [memo addEntranceAnimationToLayer:self.trackMEB.layer withDelay:0.9];



}

-(void)dropPinsFromUserDefaultsWithName :(NSString*) nameOfarray lats: (NSString*) nameOfLats andLongs: (NSString*)nameOfLongis bussines:(BOOL)areBussiness{
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray*    arrayOfNames = [myDefaults objectForKey:nameOfarray];
    NSMutableArray *arrayOfLat = [myDefaults objectForKey:nameOfLats];
    NSMutableArray *arrayOfLong = [myDefaults objectForKey:nameOfLongis];
    
    //Allocate space on memory to my array containing all the walls locations
    CLLocationCoordinate2D *locations = malloc(sizeof(CLLocationCoordinate2D) * [arrayOfNames count]-1);
    //Auxiliar Index
    int count = 0;
    for (int i = 0; i < [arrayOfNames count] ; i++)        {
        //Parse lat and long strings on the other array on a coordinate2d
        double actLat = [[arrayOfLat objectAtIndex:i] doubleValue];
        double actlong = [[arrayOfLong objectAtIndex:i] doubleValue];
        //Creat a pin with the actual locations
        CLLocationCoordinate2D point = CLLocationCoordinate2DMake(actLat, actlong);
        // Fill the array.
        locations[count] = point;
        MKPointAnnotation *points = [[MKPointAnnotation alloc] init];
        // Set annotaion point at your coordinate
        [points setCoordinate:point];
        NSString *number = [NSString stringWithFormat:@""];
        //set title to the pin
        NSString *wallName = [arrayOfNames objectAtIndex:i];
        [points setTitle:[number stringByAppendingString:wallName]];
        //get the wall location
        CLLocation *stationLocation = [[CLLocation alloc]initWithLatitude:locations[count].latitude longitude:locations[count].longitude];
        //get distance between my location and the wall
        
        CLLocationDistance myDistance = [ self.locationManager.location distanceFromLocation:stationLocation];
        //format it on a string
        NSString *mystring =   [NSString stringWithFormat:@"Esta a %4.2f metros de ti",myDistance];
        //and put it on subtitle
        [points setSubtitle:mystring ];
        
        //FInally we drop the pin on map
        [self.map addAnnotation:points];
        
        //Increase my index
        count++;
    }
    //Free loccations array
    free(locations);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)panicButtonPressed:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [imagePicker setDelegate:self];
    [self presentViewController:imagePicker animated:YES completion:nil];

}

- (IBAction)moreButtonPressed:(id)sender {
    UIView* blackView  = [[UIView alloc]initWithFrame:self.view.bounds];
    blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//    self.menuView.hidden = NO;
    [[self view]addSubview:blackView];
    
    UIImageView* imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Adiuvo-36.png"]];
    imgView.frame = blackView.frame;
    [blackView addSubview:imgView];
    [blackView sendSubviewToBack:imgView];
    
    UIButton* registerButton = [[UIButton alloc ]initWithFrame:CGRectMake(50, 120, 80, 80)];
    [registerButton setImage:[UIImage imageNamed:@"Adiuvo-16.png"] forState:UIControlStateNormal];
    [registerButton addTarget:nil action:@selector(registerEvent) forControlEvents:UIControlEventTouchDown];
    [blackView addSubview:registerButton];
    UILabel *registerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 190, 80, 80)];
    [registerLabel setTextColor:[UIColor whiteColor]];
    [registerLabel setText:@"Registro"];
    [blackView addSubview:registerLabel];
    
    UIButton* seeButton = [[UIButton alloc ]initWithFrame:CGRectMake(blackView.frame.size.width -130, 120, 80, 80)];
    [seeButton setImage:[UIImage imageNamed:@"Adiuvo-18.png"] forState:UIControlStateNormal];
    [seeButton addTarget:nil action:@selector(seeEvent) forControlEvents:UIControlEventTouchDown];
    [blackView addSubview:seeButton];
    UILabel *seeLabel = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.size.width -120, 190, 80, 80)];
    [seeLabel setTextColor:[UIColor whiteColor]];
    [seeLabel setText:@"Yo lo vi"];
    [blackView addSubview:seeLabel];
    
    UIButton* followButton = [[UIButton alloc ]initWithFrame:CGRectMake(50, (blackView.frame.size.height -50)/2+80, 80, 80)];
    [followButton setImage:[UIImage imageNamed:@"Adiuvo-17.png"] forState:UIControlStateNormal];
    [followButton addTarget:nil action:@selector(seguirCaso) forControlEvents:UIControlEventTouchDown];
    [blackView addSubview:followButton];
    UILabel *followLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, (blackView.frame.size.height -50)/2+150, 80, 80)];
    [followLabel setTextColor:[UIColor whiteColor]];
    [followLabel setText:@"Seguir \n un caso"];
    [blackView addSubview:followLabel];
    
    UIButton* showButton = [[UIButton alloc ]initWithFrame:CGRectMake(blackView.frame.size.width -130, (blackView.frame.size.height-50)/2+80, 80, 80)];
    [showButton setImage:[UIImage imageNamed:@"Adiuvo-19.png"] forState:UIControlStateNormal];
    [showButton addTarget:nil action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [blackView addSubview:showButton];
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(blackView.frame.size.width -125, (blackView.frame.size.height-50)/2+150, 80, 80)];
    [showLabel setTextColor:[UIColor whiteColor]];
    [showLabel setText:@"Busqueda"];
    [blackView addSubview:showLabel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [blackView addGestureRecognizer:tap];
}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
 
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKAnnotationView *aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@""];
    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    aView.canShowCallout = YES;
    aView.annotation = annotation;
    return aView;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"panic"]) {
        PanicViewController* panic = [segue destinationViewController];
        panic.theImage = self.takenImage;
    }
    
    if ([[segue identifier] isEqualToString:@"register"]){
        ReportViewController *report = [segue destinationViewController];
    }
    
    if ([[segue identifier] isEqualToString:@"trackRep"]) {
        SeguirCasoViewController *serCaso = [segue destinationViewController];
        serCaso.Folio = _FolioVC;
    }
    
    if ([[segue identifier] isEqualToString:@"trackRep"]) {
        SeguirCasoViewController *serCaso = [segue destinationViewController];
        serCaso.Folio = _FolioVC;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.takenImage = image;
    [self dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"panic" sender:nil];
}



-(void)back{
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        
        if ([v isKindOfClass:[MKMapView class]]) {
            
        }
        else if([v isKindOfClass:[UIButton class]])
        {
            
        }
        
        else{
        [v removeFromSuperview];
        }
    }
}

-(void)tapGesture{
    NSArray *viewsToRemove = [self.view subviews];
    for (UIView *v in viewsToRemove) {
        
        if ([v isKindOfClass:[MKMapView class]]) {
            
        }
        else if([v isKindOfClass:[UIButton class]])
        {
            
        }else if ([v tag]==2)
        {
            
        }
        
        else{
            [v removeFromSuperview];
        }
    }
}

-(void)registerEvent{
    [self performSegueWithIdentifier:@"register" sender:nil];
    
}

-(void)seeEvent{
    
    [self performSegueWithIdentifier:@"yolo" sender:nil];
}

-(void)seguirCaso{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Folio del caso" message:@"" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Siguiente", nil] ;
    alertView.tag = 2;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UITextField * alertTextField = [alertView textFieldAtIndex:0];
    NSLog(@"Folio - %@", alertTextField.text);
    _FolioVC = alertTextField.text;
    if (buttonIndex == 0) {
        NSLog(@"Cancelar");
    }else{
        NSLog(@"Folio");
        [self performSegueWithIdentifier:@"trackRep" sender:nil];
    }
    
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"accessory button tapped for annotation %@", view.annotation);
    [self performSegueWithIdentifier:@"moreInfo" sender:nil];
}

- (IBAction)trackMEButtonPressed:(id)sender {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Localizame" message:@"Cada cuanto deseas que se actualize tu ubicación ?\nNo de folio es #55743287" delegate:nil cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK :)", nil];

    UIPickerView* mmo = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    mmo.delegate = self;
    mmo.dataSource = self;
    [av setValue:mmo forKey:@"accessoryView"];
    [av show];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [NSString stringWithFormat:@"%d",row*10];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 5;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (IBAction)findRoutesButton:(id)sender {
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
             NSLog(@"%@",error);
         } else {
             NSLog(@"entreo ok");
             [self showRoute:response];
         }
     }];
}
-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [[self map]
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}


- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (IBAction)peopleButtonPressed:(id)sender {
    NSLog(@"%i",[[self.map.layer sublayers] count]);
    
    if([[self.map.layer sublayers] count] > 2){
        for(int i = 2; i<[[self.map.layer sublayers] count];i++){
            CALayer *layer = [[self.map.layer sublayers] lastObject];
            [layer removeFromSuperlayer];
        }
    }
    
    for(int i = 0; i<[self.insecurity count];i++){
        PulsingHaloLayer *halo = [PulsingHaloLayer layer];
        halo.backgroundColor = [UIColor redColor].CGColor;
        NSLog(@"Saludos");
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D point = [[self.insecurity objectAtIndex:i] coordinate];
        [annotation setCoordinate:point];
        [annotation setTitle:[self.namesInsecurity objectAtIndex:i]];
        [self.map addAnnotation:annotation];
        
        halo.position = [self.map convertCoordinate:point toPointToView:self.map];
        [self.map.layer addSublayer:halo];
    }
    NSLog(@"finish");
}

- (IBAction)siguemeButton:(UIButton *)sender {
}

- (MKOverlayView *)mapView:(MKMapView *)map viewForOverlay:(id <MKOverlay>)overlay
{
    MKCircleView *circleView = [[MKCircleView alloc] initWithOverlay:overlay];
   // circleView.strokeColor = [UIColor redColor];
    //circleView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.4];
    return circleView;
    
}

/*-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
     MKPinAnnotationView *pinView = nil;
    
    
}*/
- (IBAction)showMenu:(id)sender{
    memo++;
    if (memo%2 != 0) {
        self.menuView.hidden = NO;
        CGRect newFrameOfMyView = CGRectMake(0.0f,355.0f ,self.view.frame.size.width,self.view.frame.size.height
                                             );
        
        [[self view]bringSubviewToFront:self.menuView];
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.menuView.frame = newFrameOfMyView;
                         }
                         completion:^(BOOL finished){
                             NSLog( @"woo! Finished animating the frame of myView!" );
                         }];

    }else{
        self.menuView.hidden = YES;
    }
    
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
}
@end
