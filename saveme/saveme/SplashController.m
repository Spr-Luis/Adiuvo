//
//  SplashController.m
//  SaveME
//
//  Created by Luis Fernando Bustos Ramírez on 26/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "SplashController.h"

@interface SplashController ()

@end

@implementation SplashController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // iniciamos un contador
    mainCount = 0;
    //Iniciamos el reloj que iterara cada 1 segundo y ejecutara la funcion de countup
    clock = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countup) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Metodo que revisa si han pasado dos segundos
-(void) countup{
    mainCount +=1;
    if(mainCount == 2){
        //Al pasar dos segundos nos desplazamos a la segunda vista mediante el sigue
        [self performSegueWithIdentifier:@"inicio" sender:self];
        //Detenemos el conteo del reloj
        [clock invalidate];
    }
}
@end
