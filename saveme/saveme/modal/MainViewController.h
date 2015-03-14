//
//  MainViewController.h
//  eLBeePushBackController


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) IBOutlet UITableView* tableView;
@property(nonatomic,strong)CLLocationManager *locationManager;

@end
