//
//  MEMOUtilities.h
//  MEMOUtilities
//
//  Created by Guillermo Vera on 11/28/13.
//  Copyright (c) 2013 Memo. All rights reserved.
//Misc utilities used within the app

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "ExchangeCenter.h"
#import <QuartzCore/QuartzCore.h>

@interface MEMOUtilities : NSObject
//It just search for a string on a given array
-(int)buscaLaCadenaConElNombre:(NSString*)nombreDeLaEstacion enElArreglo:(NSMutableArray*) nombreDelArreglo;
//as tis name says add an transition effect to the layer
-(NSMutableArray*)dameElNombreDeLaEstacionMasCercanaDesde:(CLLocation*)estaUbicacion;
-(void)guardaElObjecto:(NSObject*)objeto enLosDefaultsConElNombre:(NSString*)nombre;
-(NSObject*)dameElobJetoDeLosDefaultsLlamado:(NSString* )elNombre;
- (void) addEntranceAnimationToLayer:(CALayer *)aLayer withDelay:(CGFloat)aDelay;

@end
