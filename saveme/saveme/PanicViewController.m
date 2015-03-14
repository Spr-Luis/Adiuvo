//
//  PanicViewController.m
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "PanicViewController.h"

@interface PanicViewController ()
@end

@implementation PanicViewController
@synthesize theImage,imageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_mapView setDelegate:self];
    [self.imageView setImage:theImage];
    _mapView.showsUserLocation = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    MKMapCamera *camera = [MKMapCamera camera];
    camera.centerCoordinate = _mapView.userLocation.coordinate;
    camera.altitude = 1000;
    camera.pitch = 45;
    
    [_mapView setCamera:camera animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    [[self navigationController]popToRootViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    //[aTextField resignFirstResponder];
    [_descriptionTextView resignFirstResponder];
    [_typeLabel resignFirstResponder];
    
}
- (IBAction)sendReport:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Mandar Reporte" message:@"Se ha llenado tu registro de manera correcta !" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Enviar", nil];
    [alert show];
    
    PFObject *Reporte = [PFObject objectWithClassName:@"Reportes"];
    Reporte[@"Tipo"] = _typeLabel.text;
    Reporte[@"Descripcion"] = _descriptionTextView.text;
    Reporte[@"Latitud"] = [NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.latitude];
    Reporte[@"Longitud"] = [NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude];
    
    NSData *dataImg = UIImageJPEGRepresentation(theImage, 0.8);
    PFFile *fileImg = [PFFile fileWithName:@"img.png" data:dataImg];
    [Reporte setObject:fileImg forKey:@"Image"];

    [Reporte saveInBackground];
    
}

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString* titles = [alertView buttonTitleAtIndex:buttonIndex];
    if ([titles isEqualToString:@"Enviar"]) {
        UIAlertView* alerts = [[UIAlertView alloc]initWithTitle:@"Exito !" message:@"Tu reporte se ha enviado satisfactoriamente" delegate:self cancelButtonTitle:nil
                                              otherButtonTitles:@"Continuar", nil];
        [alerts show];
    }
    else if ([titles isEqualToString:@"Continuar"]){
        [self performSegueWithIdentifier:@"mapView" sender:nil];
    }
    }

@end
