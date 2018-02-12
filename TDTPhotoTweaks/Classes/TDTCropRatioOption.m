//
//  TDTCropRatioOption.m
//  Pods
//
//  Created by Dinesh Kumar on 2/12/18.
//

#import "TDTCropRatioOption.h"

@interface TDTCropRatioOption()

@property (nonatomic, strong, readwrite) NSString *name;
@property (nonatomic, assign, readwrite) double widthToHeightRatio;

@end

@implementation TDTCropRatioOption

- (instancetype)initWithName:(NSString *)name widthHeightRatio:(CGFloat)widthToHeightRatio {
  self = [super init];
  if (self) {
    _name = name;
    _widthToHeightRatio = widthToHeightRatio;
  }
  return self;
}

+(instancetype)cropOptionNone {
  return [[TDTCropRatioOption alloc] initWithName:@"None" widthHeightRatio:-1];
}

@end
