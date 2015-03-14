//
//  OverlayView.m
//  CameraOverlay
//
//  Created by Andreas Katzian on 12.05.10.
//  Copyright 2010 Blackwhale GmbH. All rights reserved.
//

#import "OverlayView.h"


@implementation OverlayView{
    CGPoint delta;
    CGPoint translation;
    float ballRadius;
    
}
@synthesize imageView;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //clear the background color of the overlay
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
		
        //load an image to show in the overlay
        UIImage *crosshair = [UIImage imageNamed:@"crosshair.jpg"];
        self.imageView = [[UIImageView alloc]
									 initWithImage:crosshair];
        self.imageView.frame = CGRectMake(0, 40, 100, 100
                                          );
		self.imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:self.imageView];

		
        //add a simple button to the overview
        //with no functionality at the moment
        UIButton *button = [UIButton 
                            buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"Catch now" forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 430, 320, 40);
        [self addSubview:button];
        
        motionManager = [[CMMotionManager alloc] init];

        [motionManager startGyroUpdates];
		timer = [NSTimer scheduledTimerWithTimeInterval:1/30.0
												 target:self
											   selector:@selector(doGyroUpdate)
											   userInfo:nil
												repeats:YES];

        
    }
    return self;
}


-(void)doGyroUpdate {
	float rate = motionManager.gyroData.rotationRate.z;
	if (fabs(rate) > .2) {
		float direction = rate > 0 ? 1 : -1;
		rotation += direction * M_PI/90.0;
		self.imageView.transform = CGAffineTransformMakeRotation(rotation);
	}
}



-(void)back
{

}



@end
