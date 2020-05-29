//
//  MKScrollBallLayer.m
//  Ball
//
//  Created by Face on 2020/5/28.
//  Copyright © 2020 Face. All rights reserved.
//

#import "BTScrollBallLayer.h"

@implementation BTScrollBallLayer


- (void)initControl{
    self.backgroundColor = UIColor.blueColor.CGColor;
    self.ballTitle = @"0";
    self.ballFont = [UIFont systemFontOfSize:30];
    self.fontSize = [_ballTitle sizeWithAttributes:@{NSFontAttributeName:_ballFont}];
    self.ballBackgroundColor = UIColor.greenColor;
    [self addSublayer:self.ballBackgroundLayer];
    [self addSublayer:self.ballTitleLayer];
}

- (instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self initControl];
        self.ballTitle = title;
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self initControl];
    }
    return self;
}

- (void)layoutSublayers{
    [super layoutSublayers];
    [self updateFontSize];
    [self updateTitleLayerPosition];
    [self updateBackgroundLayerPositon];
    
    CGFloat min = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));
    self.ballBackgroundLayer.cornerRadius = min/2.0;
}

- (void)updateFontSize{
    if (_ballFont) {
        _fontSize = [_ballTitle sizeWithAttributes:@{NSFontAttributeName:_ballFont}];
    }
}

- (void)updateTitleLayerPosition{
    CGSize layerSize = CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    CGPoint textPoint = CGPointMake((layerSize.width-_fontSize.width)/2.0,
                                    (layerSize.height-_fontSize.height)/2.0);
    self.ballTitleLayer.frame = CGRectMake(textPoint.x,
                                           textPoint.y,
                                           _fontSize.width,
                                           _fontSize.height);
}

- (void)updateBackgroundLayerPositon{
    CGFloat min = MIN(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame));
    CGFloat x = (CGRectGetWidth(self.frame) - min)/2.0;
    CGFloat y = (CGRectGetHeight(self.frame) - min)/2.0;
    self.ballBackgroundLayer.frame = CGRectMake(x, y, min, min);
}

- (void)setBallTitleColor:(UIColor *)ballTitleColor{
    _ballTitleColor = ballTitleColor;
    self.ballTitleLayer.foregroundColor = ballTitleColor.CGColor;
}

- (void)setBallFont:(UIFont *)font{
    _ballFont = font;
    self.ballTitleLayer.font = (__bridge CFTypeRef _Nullable)(font);
    self.ballTitleLayer.fontSize = self.ballFont.pointSize;
}

- (void)setBallTitle:(NSString *)title{
    _ballTitle = title;
    self.ballTitleLayer.string = title;
}

- (void)setBallBackgroundImage:(UIImage *)ballBackgroundImage{
    _ballBackgroundImage = ballBackgroundImage;
    self.ballBackgroundLayer.contents = (__bridge id)ballBackgroundImage.CGImage;
}

- (void)setBallBackgroundColor:(UIColor *)ballBackgroundColor{
    _ballBackgroundColor = ballBackgroundColor;
    self.ballBackgroundLayer.backgroundColor = ballBackgroundColor.CGColor;
}

// MARK: - lazy

- (CATextLayer *)ballTitleLayer{
    if (!_ballTitleLayer) {
        _ballTitleLayer = [[CATextLayer alloc]init];
        _ballTitleLayer.foregroundColor = UIColor.whiteColor.CGColor;
        _ballTitleLayer.alignmentMode = kCAAlignmentCenter;
        _ballTitleLayer.string = @"0";
        _ballTitleLayer.contentsScale = [UIScreen mainScreen].scale;
        [_ballTitleLayer setFont:(__bridge CFStringRef)self.ballFont];
        _ballTitleLayer.fontSize = self.ballFont.pointSize;
        _ballTitleLayer.wrapped = YES;
    }
    return _ballTitleLayer;
}

- (CALayer *)ballBackgroundLayer{
    if (!_ballBackgroundLayer) {
        _ballBackgroundLayer = [[CALayer alloc]init];
        _ballBackgroundLayer.contentsGravity = kCAGravityResizeAspect;
        _ballBackgroundLayer.contentsScale = UIScreen.mainScreen.scale;
        _ballBackgroundLayer.masksToBounds = YES;
    }
    return _ballBackgroundLayer;;
}

@end
