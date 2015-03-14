//
//  ModalViewController.h
//  eLBeePushBackController
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@class ModalViewController;

@protocol ModalVCDelegate <NSObject>
-(void)pushBackVCDelegateShouldDismissController:(ModalViewController *)controller;
@end

@interface ModalViewController : UIViewController<MKMapViewDelegate>

@property (nonatomic, weak) id <ModalVCDelegate> delegate;


@end
