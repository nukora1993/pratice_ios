//
//  ViewController.h
//  Camera
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) IBOutlet UIButton *takePictureButton;

@property (nonatomic) AVPlayerViewController *avPlayerViewController;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSURL *movieURL;
@property (nonatomic) NSString *lastChosenMediaType;

- (IBAction)shootPictureOrVideo:(UIButton *)sender;
- (IBAction)selectExistingPictureOrVideo:(id)sender;

@end

