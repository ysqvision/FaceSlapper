//
//  ViewController.m
//  FaceSlapper
//
//  Created by Shaoqing Yang on 7/12/14.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *faceSlapPath = [[NSBundle mainBundle] pathForResource:@"face_slap_sound_effect" ofType:@"wav"];
	NSURL *faceSlapURL = [NSURL fileURLWithPath:faceSlapPath];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)faceSlapURL, &_faceSlapSound);
    
	__block BOOL readyToSlap = true;
    
    
    __block BOOL previousDirection = true;
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 double zAcce = accelerometerData.acceleration.z;
                                                 NSLog(@"%f", zAcce);
                                                 if (!readyToSlap) {
                                                     BOOL currentDirection = (zAcce >= 0);
                                                     if (currentDirection != previousDirection) {
                                                         previousDirection = currentDirection;
                                                         readyToSlap = true;
                                                     }
                                                 }
                                                 
                                                 if (readyToSlap) {
                                                     NSLog(@"inside ready to slap");
                                                     if (fabs(zAcce) > 2) {
                                                         AudioServicesPlaySystemSound(self.faceSlapSound);
                                                         NSLog(@"slapped!!");
                                                         readyToSlap = false;
                                                         previousDirection = (zAcce >= 0);
                                                     }
                                                 }
                                                 if(error){
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
