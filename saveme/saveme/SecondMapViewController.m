//
//  SecondMapViewController.m
//  SaveME
//
//  Created by Guillermo Vera on 1/24/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "SecondMapViewController.h"

@interface SecondMapViewController (){
    NSArray *pines;
}

@end

@implementation SecondMapViewController
@synthesize map,coordinate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.map setDelegate:self];
    self.map.showsUserLocation = YES;
    
    
    [self Gas];
    [self setRegion];
}



#pragma mark - Colocar Pines
-(void) Gas{
    FiscaliaJson *datos = [[FiscaliaJson alloc] init];
    
    CLLocationManager *locationManager;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    [locationManager startUpdatingLocation];
    
    NSArray *pinLoad = [datos cargaFiscalias:locationManager];
    
    [self performSelectorOnMainThread:@selector(addPins:) withObject:pinLoad waitUntilDone:YES];
    
    
}

-(void)addPins:(NSArray *)arrayPins{
    if(arrayPins != nil){
        [self.map addAnnotations:arrayPins];
    }else{
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"¡Error!" message:@"Ha ocurrido un error con la API del GDF, por favor intente más tarde." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alerta show];
    }
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
    
    if (pines != nil) {
        [self.map addAnnotations:pines];
    } else{
        NSLog(@"No hay pines");
    }

}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation{
    
    MKPinAnnotationView *pinView = nil;
    if(annotation != self.map.userLocation)
    {
    
        static NSString *defaultPinID = @"Pin";
        pinView = (MKPinAnnotationView *)[self.map dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
                                         initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"edificio.png"];
        
    
        
    }
    return pinView;

}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Cancelar");
    }else{
        NSLog(@"Folio");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:5336-4591"]];
    }

}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"accessory button tapped for annotation %@", view.annotation);
//    [self performSegueWithIdentifier:@"moreInfo" sender:nil];
    UIAlertView* al = [[UIAlertView alloc]initWithTitle:@"Llamar a la Fiscalía" message:@"Deseas marcar al Numero de la fiscalia ?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Llamar", nil];
    [al show];
}

-(void)setRegion{
    //set new region to the usero location
    MKCoordinateRegion newRwgion = MKCoordinateRegionMakeWithDistance(map.userLocation.coordinate, 4000, 4000);
    [map setRegion:newRwgion animated:YES];
    //get my actual location
    double lat = self.map.userLocation.coordinate.latitude;
    double longg = self.map.userLocation.coordinate.longitude;
    //get some delta value (this will be the camera looking at our location)
    double lat2 = lat-0.03;
    double longg2 = longg-0.03;
    //create a coordinate
    CLLocationCoordinate2D los = CLLocationCoordinate2DMake(lat2, longg2);
    //set the camera
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:self.map.userLocation.coordinate fromEyeCoordinate:los eyeAltitude:500];
    [self.map setCamera:camera];
    [UIView animateWithDuration:1.5
                          delay:.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{[self.map setCamera:camera];}
                     completion:NULL];
    

}



@end
