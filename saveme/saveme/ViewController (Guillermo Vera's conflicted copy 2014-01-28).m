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
@interface ViewController ()
@property(nonatomic,strong)CLLocationManager* locationManager;
@property(nonatomic,strong) MEMOUtilities* memoPorfa;
@property (strong, nonatomic) IBOutlet UIButton *panicB;
@property (strong, nonatomic) IBOutlet UIButton *moreB;
@property (strong, nonatomic) IBOutlet UIButton *thirdB;
@property (strong, nonatomic) IBOutlet UIButton *trackMEB;
@property (strong, nonatomic) IBOutlet UIButton *findMEB;
@property (strong, nonatomic)  UIImage *takenImage;


@end

@implementation ViewController
@synthesize map,panicB,moreB,thirdB,trackMEB,findMEB,takenImage;

- (void)viewDidLoad
{
    self.memoPorfa = [[MEMOUtilities alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    [self.locationManager startUpdatingLocation];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self dropPinsFromUserDefaultsWithName:@"peopleNames" lats:@"peopleLats" andLongs:@"peopleLongs" bussines:YES];

    [self setRegion];
    [self addAnimations];
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
    [[self view]addSubview:blackView];
    
    UIButton* backButton = [[UIButton alloc ]initWithFrame:CGRectMake(50, 80, 80, 80)];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setBackgroundColor:[UIColor redColor]];
    [backButton addTarget:nil action:@selector(back) forControlEvents:UIControlEventTouchDown];
    [blackView addSubview:backButton];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"panic"]) {
        PanicViewController* panic = [segue destinationViewController];
        panic.theImage = self.takenImage;
    }
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.takenImage = image;
    [self dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"panic" sender:nil];
}



-(void)back
{
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
    }}

- (IBAction)trackMEButtonPressed:(id)sender {
}

- (IBAction)findRoutesButton:(id)sender {
}

- (IBAction)peopleButtonPressed:(id)sender {
}
@end
