//
//  OverlayView.h
//  CameraOverlay
//
//  Created by Andreas Katzian on 12.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface OverlayView : UIView <UIAccelerometerDelegate>{
    CMMotionManager *motionManager;
	NSTimer *timer;
	float rotation;
}
@property (nonatomic, retain) UIImageView *imageView;


@end
