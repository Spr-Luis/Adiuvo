//
//  SeguirCasoViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "SeguirCasoViewController.h"

@interface SeguirCasoViewController ()
@property (strong, nonatomic) MKMapItem *destination;
@end

@implementation SeguirCasoViewController
@synthesize map;


- (void)viewDidLoad
{
    [super viewDidLoad];

    
    double latitude = 19.246470;
    double longitude = -99.101350;
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(latitude, longitude) addressDictionary:nil] ;
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark] ;
    self.destination= mapItem;
    
    _folioLabel.text = @"btdvmmYvFN";
    
    PFQuery *query = [PFQuery queryWithClassName:@"Track"];
    [query getObjectInBackgroundWithId:@"btdvmmYvFN" block:^(PFObject *user, NSError *error) {
        _nombreLabel.text = [user objectForKey:@"Nombre"];
        _edadLabel.text = [NSString stringWithFormat:@"%@ Años", [user objectForKey:@"Edad"]];
        PFFile *img = [user objectForKey:@"Image"];
        NSData *dataImg = [img getData];
        _image.image = [UIImage imageWithData:dataImg];
    }];
    [self setRegion];
    [self findRoutesButton:nil];
}

- (IBAction)findRoutesButton:(id)sender {
    
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Ruta de Seguimiento" message:@"Aqui puedes ver la ruta de seguimiento de tu contacto :)" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
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

-(void)setRegion{
    //set new region to the users location
    MKCoordinateRegion newRwgion;
    newRwgion = MKCoordinateRegionMakeWithDistance(self.map.userLocation.coordinate, 2500, 2500);
    [map setRegion:newRwgion animated:YES];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

@end
