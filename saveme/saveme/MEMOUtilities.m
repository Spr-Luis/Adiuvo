//
//  MEMOUtilities.m
//  MEMOUtilities
//
//  Created by Guillermo Vera on 11/28/13.
//  Copyright (c) 2013 Memo. All rights reserved.
//

#import "MEMOUtilities.h"

@implementation MEMOUtilities
 
//this search a station on array using linear search
-(int)buscaLaCadenaConElNombre:(NSString*)nombreDeLaEstacion enElArreglo:(NSMutableArray*) nombreDelArreglo{
    nombreDeLaEstacion = [nombreDeLaEstacion stringByReplacingOccurrencesOfString:@" " withString:@""];
    nombreDeLaEstacion = [nombreDeLaEstacion lowercaseString];
    for (int memo = 0; memo < [nombreDelArreglo count]; memo++) {
        NSString *estacionActual = nombreDelArreglo[memo];
        estacionActual = [estacionActual stringByReplacingOccurrencesOfString:@" " withString:@""];
        estacionActual = [estacionActual lowercaseString];
        if ([estacionActual isEqualToString:nombreDeLaEstacion]){
            return memo;
        }
    }
    return -1;
}


- (void) addEntranceAnimationToLayer:(CALayer *)aLayer withDelay:(CGFloat)aDelay {
    CAKeyframeAnimation *trans = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    
    NSArray *values = @[@(-300),@(30),@(0)];
    trans.values = values;
    
    NSArray *times = @[@(0.0),@(0.85),@(1)];
    trans.keyTimes = times;
    trans.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    trans.duration = 0.8;
    trans.removedOnCompletion = NO;
    trans.fillMode = kCAFillModeBackwards;
    trans.beginTime = CACurrentMediaTime()+aDelay;
    [aLayer addAnimation:trans forKey:@"entrance"];
    
}



-(NSMutableArray*)dameElNombreDeLaEstacionMasCercanaDesde:(CLLocation*)estaUbicacion{
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* arregloContodosLosNombres = [myDefaults objectForKey:@"nombresCentros"];
    NSMutableArray* arregloContodasLasLatis = [myDefaults objectForKey:@"latsCentros"];
    NSMutableArray* arregloContodasLasLongis = [myDefaults objectForKey:@"longsCentros"];
    NSMutableArray* arregloContodasLasDirections = [myDefaults objectForKey:@"directionsCentros"];
    
    NSMutableArray* arregloConTodoCentro = [[NSMutableArray alloc]init];

    //los guardo en estaciones de bus y estas las meto en un arreglo de estaciones de bus
    for (int i = 0; i < [arregloContodosLosNombres count]; i++) {
                  //creo una bus line con esa info
        NSString *nombre = arregloContodosLosNombres[i];
        double latt =  [arregloContodasLasLatis[i] doubleValue];
        double longg = [arregloContodasLasLongis[i] doubleValue];
            CLLocation *busLocation = [[CLLocation alloc]initWithLatitude:latt longitude:longg];
            ExchangeCenter*actual =[[ExchangeCenter alloc]initWitValues:busLocation name:nombre andDirection:arregloContodasLasDirections[i]];
            //la almaceno en el arreglo global
        arregloConTodoCentro[i] = actual;
        
    }//y simplmente lo ordeno
    NSMutableArray *arregloOrdenado = [self quickSortObjectArray:arregloConTodoCentro yLaUbicacion:estaUbicacion];
    
    
    NSString* elNombre = [[arregloOrdenado firstObject] name];
    double latt = [[arregloOrdenado firstObject] ubicationCoordinates].coordinate.latitude;
    double longg = [[arregloOrdenado firstObject] ubicationCoordinates].coordinate.longitude;
    NSLog(@"La estacion ordenada se llama %@ con lat %f y long %f",elNombre,latt,longg);
    
    return arregloOrdenado;
}

-(NSMutableArray*)quickSortObjectArray:(NSMutableArray*)unsortedArray yLaUbicacion:(CLLocation*) myLocation
{
    NSInteger numberOfElements = [unsortedArray count];
    if(numberOfElements <= 1)
    {
        NSLog(@"soty de uno");
        return unsortedArray;
    }
    NSLog(@"no de uno");
    
    ExchangeCenter* pivotObject = [unsortedArray objectAtIndex:numberOfElements / 2];
    NSLog(@"Arreglo ordenado es name  %@, es %@ direjkction es %@",[pivotObject name],[pivotObject direction],[pivotObject ubicationCoordinates ]);

    
    NSMutableArray* lessArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    NSMutableArray* moreArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    
    
    for (ExchangeCenter* obj in unsortedArray)
    {
        CLLocation *locacionDelMuro = pivotObject.ubicationCoordinates;
        CLLocation *myLocacion = myLocation;
        //REPRESENTS [PIVOT OBJECT
        CLLocationDistance myDistanceToTheWall = [myLocacion distanceFromLocation:locacionDelMuro];
        //REPRESENT OBJ
        CLLocation *locacionDelMuroMasUno = obj.ubicationCoordinates;
        CLLocationDistance myDistanceToTheWallMasUno = [myLocacion distanceFromLocation:locacionDelMuroMasUno];
        
        if(myDistanceToTheWallMasUno < myDistanceToTheWall)
        {
            [lessArray addObject:obj];
        }
        else if(myDistanceToTheWallMasUno > myDistanceToTheWall)
        {
            [moreArray addObject:obj];
        }
    }
    
    NSMutableArray* sortedArray = [[NSMutableArray alloc] initWithCapacity:numberOfElements];
    [sortedArray addObjectsFromArray:[self quickSortObjectArray:lessArray yLaUbicacion:myLocation]];
    [sortedArray addObject:pivotObject];
    [sortedArray addObjectsFromArray:[self quickSortObjectArray:moreArray yLaUbicacion:myLocation]];
    
    return sortedArray;
}


-(void)guardaElObjecto:(NSObject*)objeto enLosDefaultsConElNombre:(NSString*)nombre{
    NSUserDefaults* myDefaults = [NSUserDefaults standardUserDefaults];
    [myDefaults setObject:objeto forKey:nombre];
    [myDefaults synchronize];
}

-(NSObject*)dameElobJetoDeLosDefaultsLlamado:(NSString* )elNombre
{
    return [[NSUserDefaults standardUserDefaults ]objectForKey:elNombre];
}


@end
