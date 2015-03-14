//
//  ContactosViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "ContactosViewController.h"

@interface ContactosViewController (){
    NSMutableArray *contactos;
}

@end

@implementation ContactosViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    contactos = [[NSMutableArray alloc] init];
    [_conTable setDelegate:self];
    [_conTable setDataSource:self];
    
    NSArray *nombre = [[NSArray alloc] initWithObjects:@"Luis Armando",@"José Manuel",@"Octavio Mendoza", nil];
    
    for (int i = 0; i < 3; i++) {
        NSDictionary *datos = [[NSDictionary alloc] initWithObjectsAndKeys: [nombre objectAtIndex:i] ,@"Nombre",
                               [NSString stringWithFormat:@"591571%d", 10+rand()%90], @"Telefono", nil];
        [contactos addObject:datos];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selContacts:(UIButton *)sender {
    ABPeoplePickerNavigationController *picker =
    [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate = self;
    
    [self presentModalViewController:picker animated:YES];
}

- (void)peoplePickerNavigationControllerDidCancel:
(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    NSString* name = (__bridge_transfer NSString*)ABRecordCopyValue(person,
                                                                    kABPersonFirstNameProperty);
    NSString* phone = nil;
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(person,
                                                     kABPersonPhoneProperty);
    if (ABMultiValueGetCount(phoneNumbers) > 0) {
        phone = (__bridge_transfer NSString*)
        ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
    } else {
        phone = @"[None]";
    }
    CFRelease(phoneNumbers);
    
    NSLog(@"Name: %@ - Phone: %@", name,phone);
    
    NSDictionary *datos = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"Nombre",
                           phone, @"Telefono", nil];
    
    [contactos addObject:datos];
    [_conTable reloadData];
    
    [self dismissModalViewControllerAnimated:YES];
    return NO;
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}

#pragma mark - Número de Secciones

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - Número de Celdas
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contactos count];
}


#pragma mark - Dibujamos las Celdas
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Celda";
    
    DatoCelda *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    cell.nombreLab.text  = [[contactos objectAtIndex:indexPath.row] objectForKey:@"Nombre"];
    cell.telLabel.text = [[contactos objectAtIndex:indexPath.row] objectForKey:@"Telefono"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [contactos removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    [tableView endUpdates];
}
@end
