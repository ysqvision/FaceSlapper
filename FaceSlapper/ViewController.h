//
//  ViewController.h
//  FaceSlapper
//
//  Created by Shaoqing Yang on 7/12/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) CMMotionManager *motionManager;

@property (assign) SystemSoundID faceSlapSound;
@end
