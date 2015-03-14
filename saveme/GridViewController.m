//
//  GridViewController.m
//  SaveME
//
//  Created by Lu1s_Armandho0 on 25/01/14.
//  Copyright (c) 2014 Memo Inc. All rights reserved.
//

#import "GridViewController.h"

@interface GridViewController ()

@end

@implementation GridViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_grid setDelegate:self];
    [_grid setDataSource:self];
    /*
    PFQuery *query = [PFQuery queryWithClassName:@"Track"];
    [query get]
   /* [query get
     
     getObjectInBackgroundWithId:@"" block:^(PFObject *user, NSError *error) {
        _nombreLabel.text = [user objectForKey:@"Nombre"];
        _edadLabel.text = [NSString stringWithFormat:@"%@ Años", [user objectForKey:@"Edad"]];
        PFFile *img = [user objectForKey:@"Image"];
        NSData *dataImg = [img getData];
        _image.image = [UIImage imageWithData:dataImg];
    }];*/
    
    _array = [[NSMutableArray alloc] initWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"6.jpg",@"7.jpg",@"8.jpg",@"9.jpg",@"10.jpg",@"11.jpg",@"12.jpg",@"13.jpg",@"14.jpg",@"15.jpg",@"16.jpg",@"17.jpg",@"18.jpg",@"19.jpg",@"20.jpg", nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_array count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[_array objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath){
        NSLog(@"Pantalla");
        trackMEViewController*vr = [[trackMEViewController alloc]init];
        [self.navigationController pushViewController:vr animated:YES];
    }
}



@end
