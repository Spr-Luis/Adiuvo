//
//  AppDelegate.m
//  SaveME
//
//  Created by Memo on 22/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize names,latitudes,longitudes,direcciones;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.names = [[NSMutableArray alloc]init];
    self.latitudes = [[NSMutableArray alloc]init];
    self.longitudes = [[NSMutableArray alloc]init];
    self.direcciones = [[NSMutableArray alloc]init];
    
    //Just da same
    [self getDatafromCSVwithName:@"people"];
    [self storedInDefaultsWithName:@"peopleNames" lats:@"peopleLats" andLongs:@"peopleLongs" andDirections:@"peopleDirections"];
    
    NSMutableArray* namess = [[NSUserDefaults standardUserDefaults]objectForKey:@"peopleNames"];
    NSLog(@"El arr es %@",namess);
    return YES;
}

//Another blacky box
-(void) getDatafromCSVwithName:(NSString*) nameOfCSV {
    
    [latitudes removeAllObjects];
    [longitudes removeAllObjects];
    [names removeAllObjects];
    [direcciones removeAllObjects];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:nameOfCSV ofType:@"csv"];
    NSError *error;
    NSString *allLines;
    allLines = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSString *one = [allLines stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString *two = [one stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    NSArray *rows = [two componentsSeparatedByString:@"\n"];
    
    NSMutableArray *justNames = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [rows count]; i++) {
        if (i==0 || [[rows objectAtIndex:i]isEqualToString:@""] ) {
            continue;
        }
        justNames = (NSMutableArray*)[[rows objectAtIndex:i]componentsSeparatedByString:@","];
        names[i-1] = justNames[0];
        latitudes[i-1] = justNames[2];
        longitudes[i-1] = justNames[3];
        direcciones[i-1] = justNames[1];
    }
}

//This shit store the data extracted from the csv file on NSUSERDEFAULTS
-(void)storedInDefaultsWithName :(NSString*) nameOfarray lats: (NSString*) nameOfLats andLongs: (NSString*)nameOfLongis andDirections:(NSString*)nameOfDirections{
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray* arreglodeLat = [[NSMutableArray alloc]init];
    NSMutableArray* arreglodeLong   = [[NSMutableArray alloc]init];
    NSMutableArray* arreglodeNombres     = [[NSMutableArray alloc]init];
    NSMutableArray* arregloDeDirections    = [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < [names count]; i++) {
        //create values
        double actLat = [[latitudes objectAtIndex:i] doubleValue];
        double actlong = [[longitudes objectAtIndex:i] doubleValue];
        NSString *direc = [direcciones objectAtIndex:i];
        //store them
        NSNumber *latt = [NSNumber numberWithDouble:actLat];
        NSNumber  *longs = [NSNumber numberWithDouble:actlong];
        //get it
        NSString *actName = [names objectAtIndex:i];
        //Get it
        [arregloDeDirections addObject:direc];
        [arreglodeNombres addObject:actName];
        [arreglodeLat addObject:latt];
        [arreglodeLong addObject:longs];
        
    }
    //synchronize
    [myDefaults setObject:arregloDeDirections forKey:nameOfDirections];
    [myDefaults setObject:arreglodeNombres forKey:nameOfarray];
    [myDefaults setObject:arreglodeLat forKey:nameOfLats];
    [myDefaults setObject:arreglodeLong forKey:nameOfLongis];
    
    [myDefaults synchronize];
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
