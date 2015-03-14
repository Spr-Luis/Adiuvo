//
//  MainViewController.m
//  eLBeePushBackController
//

#import "MainViewController.h"
#import "ModalViewController.h"
#import "UIViewController+eLBeePushBackController.h"
#import "MEMOUtilities.h"


@interface MainViewController() <ModalVCDelegate>
@property(strong,nonatomic) NSMutableArray*tableData;

@property(nonatomic) CLLocationCoordinate2D centerCoordinate;
@property(strong,nonatomic) NSString* centerDirections;
@property(strong,nonatomic) NSString* centerName;
@property(nonatomic) BOOL isExclusiveC;

@end

@implementation MainViewController
@synthesize tableView,isExclusiveC,locationManager;

-(void)viewDidLoad{
    MEMOUtilities* memoPls = [[MEMOUtilities alloc]init];
    self.locationManager = [[CLLocationManager alloc]init];
    [locationManager startUpdatingLocation];
    self.tableData = [memoPls dameElNombreDeLaEstacionMasCercanaDesde:locationManager.location];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor ];
    self.isExclusiveC = NO;
    NSLog(@"Mi locacion es %@",locationManager.location);
    NSLog(@"Memo la mas cercana es %@",[memoPls dameElNombreDeLaEstacionMasCercanaDesde:locationManager.location]);
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//Show a new viewcontroller using the modal effect
-(IBAction)presentPushBackViewControllerBtn:(id)sender{
    ModalViewController *controller = (ModalViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewControllerSBID"];
    controller.myDirection = self.centerDirections;
    controller.myName = self.centerName;
    controller.myCoordinate = self.centerCoordinate;
    controller.isExclusiveCenter = self.isExclusiveC;
    controller.delegate = self;  // This is not necessary - is good to just let your main view handle presenting/dismissing
    if (!isExclusiveC) {
        
    }
    [self presentPushBackController:controller];
}

//Dissmiss the modal view when pressing a button
-(void)pushBackVCDelegateShouldDismissController:(ModalViewController *)controller {
    controller.delegate = nil;
    self.isExclusiveC = NO;
    [self dismissPushBackController:controller];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


@end
