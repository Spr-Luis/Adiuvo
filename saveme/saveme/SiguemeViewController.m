//
//  SiguemeViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "SiguemeViewController.h"

@interface SiguemeViewController ()

@end

@implementation SiguemeViewController{
    NSArray *tiempo;
    NSArray *minutos;
    int rowSelected;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_picker setDataSource:self];
    [_picker setDelegate:self];
 
    tiempo = [[NSArray alloc] initWithObjects:@"1 min", @"5 min", @"10 min",@"15 min", @"30 min",@"1 hora",@"3 horas",@"5 horas", nil];
    
    minutos = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:5], [NSNumber numberWithInt:10], [NSNumber numberWithInt:15], [NSNumber numberWithInt:30], [NSNumber numberWithInt:60], [NSNumber numberWithInt:180], [NSNumber numberWithInt:300], nil];
    
    UIAlertView* alert =  [[UIAlertView alloc]initWithTitle:@"¡Con Adiuvo vas seguro!" message:@"Aqui puedes decirle al telefono que te pregunte tu estado acual cada periodo de tiempo, basta con golpear dos veces tu telefono para saber que todo va bien, de lo contrario podemos avisara tus contactos por SMS o Redes Sociales" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"De acuerdo", nil];

    [alert show];
    
    [_segmentAlarm addTarget:self action:@selector(onOff:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    rowSelected = row;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    return [tiempo objectAtIndex:row];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [tiempo count];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (void)onOff:(id)sender{
    if (_segmentAlarm.selectedSegmentIndex==1){
        int intervalo = [[minutos objectAtIndex:rowSelected] integerValue];
        for(int i =1; i < 4; i++){
            NSDate *alerta = [[NSDate alloc] init];
            alerta = [alerta dateByAddingTimeInterval:60*intervalo*i];
            UILocalNotification *notificacion = [[UILocalNotification alloc] init];
            notificacion.fireDate = alerta;
            notificacion.alertBody = [NSString stringWithFormat:@"¿Todo se encuentra bien?, da dos golpes para verificar"];
            notificacion.soundName = UILocalNotificationDefaultSoundName;
            //notificacion.alertAction = @"Adiuvo";
            notificacion.hasAction = YES;
            [[UIApplication sharedApplication] scheduleLocalNotification:notificacion];
            NSLog(@"%@",alerta);
        }
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Adiuvo" message:@"Que tengas un bonito recorrido" delegate:Nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alerta show];
    }
    else{
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Adiuvo" message:@"Esperamos hallas llegado bien" delegate:Nil cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
        [alerta show];
        
    }
    
}


@end
