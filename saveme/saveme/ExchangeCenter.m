//
//  ExchangeCenter.m
//  SpotApp
//
//  Created by Memo on 30/12/13.
//  Copyright (c) 2013 Spot. All rights reserved.
//

#import "ExchangeCenter.h"

@implementation ExchangeCenter
@synthesize name,direction,ubicationCoordinates;

-(id) initWitValues:(CLLocation*)coordinate name:(NSString*)statioName andDirection:(NSString*) centerDir{
    self = [super init];
    if(self){
        self.ubicationCoordinates = coordinate;
        self.name = statioName;
        self.direction = centerDir;
        return self;
    } else {
        return nil;
    }
    return nil;

}


@end
