//
//  SplashController.h
//  SaveME
//
//  Created by Luis Fernando Bustos Ramírez on 26/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashController : UIViewController{
    //Creamos un reloj y un contador para mostrar la vista
    NSTimer *clock;
    int mainCount;
}

//Metodo que revisara si debemos de cambiar ed vista
-(void) countup;

@end
