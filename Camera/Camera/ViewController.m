//
//  ViewController.m
//  Camera
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.takePictureButton.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)updateDisplay{
    NSString *mediaType = self.lastChosenMediaType;
    if (mediaType) {
        if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]) {
            self.imageView.image = self.image;
            self.imageView.hidden = NO;
            if (self.avPlayerViewController) {
                self.avPlayerViewController.view.hidden = YES;
            }
        }else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]){
            if (!self.avPlayerViewController) {
                self.avPlayerViewController = [[AVPlayerViewController alloc] init];
                UIView *avPlayerView = self.avPlayerViewController.view;
                avPlayerView.frame = self.imageView.frame;
                avPlayerView.clipsToBounds = YES;
                [self.view addSubview:avPlayerView];
                [self setAVPlayerViewControllerLayoutConstraints];
            }
            
            NSURL *url = self.movieURL;
            
            if (url) {
                self.imageView.hidden = YES;
                self.avPlayerViewController.player = [AVPlayer playerWithURL:url];
                self.avPlayerViewController.view.hidden = NO;
                [self.avPlayerViewController.player play];
                
            }
        }
    }
}

- (void)setAVPlayerViewControllerLayoutConstraints{
    UIView *avPlayerView = self.avPlayerViewController.view;
    avPlayerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{
        @"avPlayerView" : avPlayerView,
        @"takePictureButton" : self.takePictureButton
    };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[avPlayerView]|" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[avPlayerView]-0-[takePictureButton]" options:NSLayoutFormatAlignAllLeft metrics:nil views:views]];
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && mediaTypes.count > 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error accessing media" message:@"Unsupported media source" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)shootPictureOrVideo:(UIButton *)sender{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (void)selectExistingPictureOrVideo:(id)sender{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    
    NSString *mediaType = self.lastChosenMediaType;
    if (mediaType) {
        if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]) {
            self.image = info[UIImagePickerControllerEditedImage];
        }else if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeMovie]){
            self.movieURL = info[UIImagePickerControllerMediaURL];
        }
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self updateDisplay];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
