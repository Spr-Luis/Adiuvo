//
//  FiscaliaJson.h
//  JsonDatos
//
//  Created by Lu1s_Armandho0 on 24/01/14.
//  Copyright (c) 2014 Luis Chávez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/SystemConfiguration.h>


@interface FiscaliaJson : NSObject

- (NSArray *)cargaFiscalias: (CLLocationManager *)locationManager;

@end
