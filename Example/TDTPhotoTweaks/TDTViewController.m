//
//  TDTViewController.m
//  TDTPhotoTweaks
//
//  Created by dineshflock on 12/05/2017.
//  Copyright (c) 2017 dineshflock. All rights reserved.
//

#import "TDTViewController.h"
#import <TDTPhotoTweaks/TDTPhotoTweaksViewController.h>
#import <TDTPhotoTweaks/TDTCompassSlider.h>

static NSString * const SampleImageName = @"sample_image";
static NSString * const BarButtonTitleCrop = @"Crop";
static NSString * const BarButtonTitleReset = @"Reset";
static NSString * const ControllerTitle = @"Sample";

@interface TDTViewController () <TDTPhotoTweaksViewControllerDelegate>
{
  UIImageView * _imageView;
}
@end

@implementation TDTViewController

- (void)setupImageView {
  _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
  _imageView.center = self.view.center;
  _imageView.layer.cornerRadius = 3.0;
  _imageView.layer.masksToBounds = YES;
  _imageView.contentMode = UIViewContentModeScaleAspectFill;
  [self.view addSubview:_imageView];
}

- (void)resetImageInImageView {
  [_imageView setImage:[UIImage imageNamed:SampleImageName]];
}

- (void)viewDidLoad
{
  [self.view setBackgroundColor:[UIColor blackColor]];
  [super viewDidLoad];
  [self setupNavigationItem];
  [self setupImageView];
  [self resetImageInImageView];
}

- (void)setupNavigationItem {
  [self.navigationItem setTitle:ControllerTitle];
  UIBarButtonItem * cropButton = [[UIBarButtonItem alloc] initWithTitle:BarButtonTitleCrop style:UIBarButtonItemStylePlain target:self action:@selector(cropBarButtonTapped)];
  UIBarButtonItem * resetButton = [[UIBarButtonItem alloc] initWithTitle:BarButtonTitleReset style:UIBarButtonItemStylePlain target:self action:@selector(resetBarButtonTapped)];
  self.navigationItem.rightBarButtonItem = cropButton;
  self.navigationItem.leftBarButtonItem = resetButton;
}

// Bar button actions

- (void)cropBarButtonTapped {
  TDTPhotoTweaksViewController *photoTweaksViewController = [[TDTPhotoTweaksViewController alloc] initWithImage:_imageView.image];
  photoTweaksViewController.delegate = self;
  [self.navigationController presentViewController:photoTweaksViewController
                                          animated:YES
                                        completion:NULL];
}

- (void)resetBarButtonTapped {
  [self resetImageInImageView];
}

// Delegate Methods

- (void)photoTweaksControllerDidCancel:(TDTPhotoTweaksViewController *)controller {
  [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)photoTweaksController:(TDTPhotoTweaksViewController *)controller
        didFinishWithCroppedImage:(UIImage *)croppedImage {
  [_imageView setImage:croppedImage];
  [controller dismissViewControllerAnimated:YES completion:NULL];
}

- (void)photoTweaksControllerDidReset:(TDTPhotoTweaksViewController *)controller {
  NSLog(@"photoTweaksControllerDidReset");
}

- (void)photoTweaksControllerDidRotate:(TDTPhotoTweaksViewController *)controller {
  NSLog(@"photoTweaksControllerDidRotate");
}

- (void)photoTweaksControllerDidRotateSlider:(TDTPhotoTweaksViewController *)controller toAngle:(CGFloat)angle {
  NSLog(@"photoTweaksControllerDidRotateSlider, angle: %@",@(angle));
}

- (void)photoTweaksController:(TDTPhotoTweaksViewController *)controller didLockCroppingToOption:(TDTCropRatioOption *)option {
  NSLog(@"didLockCroppingToOption, option: %@ (%@)", option.name, @(option.widthToHeightRatio));
}

@end
