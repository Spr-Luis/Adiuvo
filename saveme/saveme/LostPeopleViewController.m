//
//  LostPeopleViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 26/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "LostPeopleViewController.h"

@interface LostPeopleViewController (){
    NSArray *nombre;
}

@end

@implementation LostPeopleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    nombre = [NSArray arrayWithObjects:@"Luis Armando Chávez Soto",@"José Manuel Pineda", @"Margarito Pérez Mendoza", @"Juan Pablo Cristobal",@"Eduardo Castro Martínez", @"Salvador Aguilar", @"Luis Enrique Pérez", @"Luis Fernando Bustos",nil];
    [_tableView setDelegate:self],
    [_tableView setDataSource:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Número de Celdas
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [nombre count];
}


#pragma mark - Dibujamos las Celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Celda";
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.nombreLabel.text  = [nombre objectAtIndex:indexPath.row];
    cell.descripcionLabel.text = [NSString stringWithFormat:@"Ojos cafes, cabello café, sexo Masculino, %d años, 1.20 metros", rand()%25];
    
    return cell;
}



@end
