//
//  ExchangeCenter.h
//  SpotApp
//
//  Created by Memo on 30/12/13.
//  Copyright (c) 2013 Spot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ExchangeCenter : NSObject

//Here the same
@property(nonatomic,strong) CLLocation *ubicationCoordinates;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *direction;

//Custom object constructor
-(id) initWitValues:(CLLocation*)coordinate name:(NSString*)statioName andDirection:(NSString*) centerName;

@end
