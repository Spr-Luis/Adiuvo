//
//  FiscaliaJson.m
//  JsonDatos
//
//  Created by Lu1s_Armandho0 on 24/01/14.
//  Copyright (c) 2014 Luis Chávez. All rights reserved.
//

#import "FiscaliaJson.h"
#define kSITIO_WEB "www.google.com"


@implementation FiscaliaJson

- (NSArray *)cargaFiscalias: (CLLocationManager *)locationManager{
    
    
    NSError *errorJson;
    
    
    if([self estaConectado] != NO){
        
        NSURL *urlJson = [NSURL URLWithString:[NSString stringWithFormat:@"http://datos.labplc.mx/georeferencia.json?&latitud=%f&longitud=%f&radio=5000&categoria=fiscalias",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude]];
        
        NSLog(@"%f-%f",locationManager.location.coordinate.latitude,locationManager.location.coordinate.longitude);
        
        NSData *dat = [NSData dataWithContentsOfURL:urlJson options:NSDataReadingMapped error:&errorJson];
        
        if (dat != nil) {
            NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:&errorJson];
        
         
        if (data != nil && locationManager.location.coordinate.latitude != 0.0) {
            
            NSLog(@"%@", [data allKeys]);
            NSLog(@"%@", [[data objectForKey:@"consulta"] allKeys]);
            
            NSLog(@"%@", [[data objectForKey:@"consulta"] objectForKey:@"ubicaciones"]);
            
            NSArray *fiscalias = [[data objectForKey:@"consulta"] objectForKey:@"ubicaciones"];
            
            NSLog(@"%d", [fiscalias count]);
            
            CLLocationCoordinate2D location;
            NSMutableArray *pinLoad = [[NSMutableArray alloc] init];
            MKPointAnnotation *anotacionPin;
            
            
            for (int i = 0; i < [fiscalias count]; i++) {
                
                location.latitude = [[[fiscalias objectAtIndex:i] objectForKey:@"latitud"] doubleValue];
                location.longitude = [[[fiscalias objectAtIndex:i] objectForKey:@"longitud"] doubleValue];
                
                anotacionPin = [[MKPointAnnotation alloc] init];
                anotacionPin.title = [[fiscalias objectAtIndex:i] objectForKey:@"nombre"];
                anotacionPin.coordinate = location;
                
                anotacionPin.subtitle = [[fiscalias objectAtIndex:i] objectForKey:@"direccion"];
                [pinLoad addObject:anotacionPin];
            }
            
            NSLog(@"MKAnnotation: LOL %@", pinLoad);
            return pinLoad;
            } else{
                NSLog(@"Data Nil");
            }
        } else{
            NSLog(@"Data Nil");
        }
        
    } else{
        NSLog(@"No hay internet o el data es nil");
    }
    
    return nil; }

-(BOOL) estaConectado {
    
    SCNetworkReachabilityRef referencia = SCNetworkReachabilityCreateWithName (kCFAllocatorDefault,kSITIO_WEB);
    
    SCNetworkReachabilityFlags resultado;
    SCNetworkReachabilityGetFlags ( referencia, &resultado );
    
    CFRelease(referencia);
    
    if (resultado & kSCNetworkReachabilityFlagsReachable) {
        
        return YES;
    }
    
    return NO;
}

@end
