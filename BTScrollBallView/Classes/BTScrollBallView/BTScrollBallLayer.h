//
//  MKScrollBallLayer.h
//  Ball
//
//  Created by Face on 2020/5/28.
//  Copyright © 2020 Face. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTScrollBallLayer : CALayer

@property (assign,nonatomic) CGSize fontSize;

- (instancetype)initWithTitle:(NSString *)title;
@property (strong,nonatomic) NSString *ballTitle;
@property (strong,nonatomic) UIColor *ballTitleColor;
@property (strong,nonatomic) UIFont *ballFont;
@property (strong,nonatomic) UIImage *ballBackgroundImage;
@property (strong,nonatomic) UIColor *ballBackgroundColor;

@property (strong,nonatomic) CATextLayer *ballTitleLayer;
@property (strong,nonatomic) CALayer *ballBackgroundLayer;
@end

NS_ASSUME_NONNULL_END
