//
//  MKScrollBall.m
//  Ball
//
//  Created by Face on 2020/5/26.
//  Copyright © 2020 Face. All rights reserved.
//

#import "BTScrollBallView.h"

@implementation CAScrollLayer (Animates)

- (void)removeAllSublayers{
    [self.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

- (void)stopAnimate{
    if (self.animationKeys.count>0) {
        [self removeAllAnimations];
    }
}

- (void)scrollPoint:(CGPoint)p animate:(BOOL)animate{
    [self stopAnimate];
    [CATransaction begin];
    [CATransaction setDisableActions:!animate];
    [CATransaction setAnimationDuration:animate?3:0];
    [self scrollToPoint:p];
    [CATransaction commit];
}

-(void)pauseLayer:(CALayer*)layer{
    CFTimeInterval pausedTime =
    [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer{
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}


@end

@interface BTScrollBallView ()

@end

@implementation BTScrollBallView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColor.greenColor;
        
    }
    return self;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self createLayers];
}

// MARK: - layout
- (void)layoutSubviews{
    [super layoutSubviews];
    [self updateScrollLayerFrames];
    [self updateSublayerPosition];
}

- (void)updateScrollLayerFrames {
    
    for (int section = 0; section<self.layer.sublayers.count; section++) {
        CAScrollLayer * scrollLayer = self.layer.sublayers[section];
        
        CGSize itemSize = CGSizeMake(CGRectGetWidth(self.bounds) / self.layer.sublayers.count,
                                     CGRectGetHeight(self.bounds));
        if ([self.delegate respondsToSelector:@selector(scrollBall:sizeForItemAtIndex:)]) {
            itemSize = [self.delegate scrollBall:self sizeForItemAtIndex:section];
        }
        
        CGPoint itemPoint = CGPointMake((section * (itemSize.width)),
                                        CGRectGetMinY(self.bounds));
        
        CGRect scrollFrame = CGRectMake(itemPoint.x, itemPoint.y,
                                        itemSize.width, itemSize.height);
        
        scrollLayer.frame = scrollFrame;
        
        for (int row = 0; row < scrollLayer.sublayers.count; row++) {
            CALayer * obj = scrollLayer.sublayers[row];
            
            CGRect ballFrame = CGRectMake(CGRectGetMinX(scrollLayer.bounds),
                                          row * (CGRectGetHeight(scrollLayer.bounds)),
                                          CGRectGetWidth(scrollLayer.bounds),
                                          CGRectGetHeight(scrollLayer.bounds));
            obj.frame = ballFrame;
        }
    }
    
    
}

- (void)updateSublayerPosition{
    
    CGFloat minimumInteritemSpacingSum = 0;
    for (int section = 0; section<self.layer.sublayers.count; section++) {
        CAScrollLayer * scrollLayer = self.layer.sublayers[section];
        
        CGFloat minimumInteritemSpacing = 0;
        if ([self.delegate respondsToSelector:@selector(scrollBall:minimumInteritemSpacingForSectionAtIndex:)]) {
            minimumInteritemSpacing = [self.delegate scrollBall:self minimumInteritemSpacingForSectionAtIndex:section];
        }
        CGFloat insetSpaceing = 0;
        if ([self.delegate respondsToSelector:@selector(scrollBall:insetSpaceingForSectionAtIndex:)]) {
             insetSpaceing = [self.delegate scrollBall:self insetSpaceingForSectionAtIndex:section];
        }
        
        CGFloat leadingSpaceing = 0;
        if ([self.delegate respondsToSelector:@selector(leadingOfSectionsInScrollBall:)]) {
            leadingSpaceing = [self.delegate leadingOfSectionsInScrollBall:self];
        }
        scrollLayer.position = CGPointMake(scrollLayer.position.x+minimumInteritemSpacingSum+leadingSpaceing,
                                           scrollLayer.position.y+insetSpaceing);
        minimumInteritemSpacingSum+=minimumInteritemSpacing;
//        leadingSpaceingSum+=leadingSpaceing;
        
        CGFloat lineSpaceingSum = 0;
        for (int row = 0; row < scrollLayer.sublayers.count; row++) {
            CALayer * obj = scrollLayer.sublayers[row];
            CGFloat minimumLineSpacing = 0;
            if ([self.delegate respondsToSelector:@selector(scrollBall:minimumLineSpacingForSectionAtIndexPath:)]) {
                NSIndexPath * indePath = [NSIndexPath indexPathForRow:row inSection:section];
                minimumLineSpacing = [self.delegate scrollBall:self minimumLineSpacingForSectionAtIndexPath:indePath];
            }
            obj.position = CGPointMake(obj.position.x, obj.position.y+minimumLineSpacing+lineSpaceingSum);
            lineSpaceingSum += minimumLineSpacing;
        }
    }
}

// MARK: - datas

- (void)createLayers{
    NSInteger sections = 0;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInScrollBall:)]) {
        sections = [self.dataSource numberOfSectionsInScrollBall:self];
    }
    
    for (NSInteger section = 0; section < sections; section++) {
        NSInteger rows = 0;
        if ([self.dataSource respondsToSelector:@selector(scrollBall:numberOfRowsInSection:)]) {
            rows = [self.dataSource scrollBall:self numberOfRowsInSection:section];
        }
        
        CAScrollLayer * scrollLayer = [[CAScrollLayer alloc]init];
        for (NSInteger row = 0; row < rows; row++) {
            if ([self.dataSource respondsToSelector:@selector(scrollBall:ballForRowAtIndexPath:)]) {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                CALayer * layer = [self.dataSource scrollBall:self ballForRowAtIndexPath:indexPath];
                [scrollLayer addSublayer:layer];
            }
        }
        [self.layer addSublayer:scrollLayer];
    }
}

// MARK: - interface
- (void)reloadData{
    [self removeAllSublayers];
    [self createLayers];
    [self layoutIfNeeded];
}

- (void)stopScrollAnimate{
    [self stopAnimate];
}

- (void)scrollToBottomWithAnimate:(BOOL)animate{
    [self performSelector:@selector(scrollToBottom:) withObject:@(animate) afterDelay:0.05];
}

- (void)scrollToTopWithAnimate:(BOOL)animate{
    [self performSelector:@selector(scrollToTop:) withObject:@(animate) afterDelay:0.01];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    [self setScrollLayerBackgroundColor:backgroundColor];
}

- (void)setScrollLayerBackgroundColor:(UIColor*)backgroundColor{
    for (CAScrollLayer * layer in self.subviews) {
        layer.backgroundColor = backgroundColor.CGColor;
    }
}

// MARK: - scroll animate

- (void)scrollToTop:(NSNumber*)animate{
    BOOL anima = animate.boolValue;
    for (int i=0; i<self.layer.sublayers.count; i++) {
        CAScrollLayer * obj = self.layer.sublayers[i];
        [obj scrollPoint:CGPointZero animate:anima];
    }
}

- (void)scrollToBottom:(NSNumber*)animate{
    BOOL anima = animate.boolValue;
    for (int i=0; i<self.layer.sublayers.count; i++) {
        CAScrollLayer * obj = self.layer.sublayers[i];
        CGPoint p = CGPointMake(CGRectGetMinX(obj.sublayers.lastObject.frame),
                                CGRectGetMinY(obj.sublayers.lastObject.frame));
        [obj scrollPoint:p animate:anima];
    }
}

- (void)stopAnimate{
    for (int i=0; i<self.layer.sublayers.count; i++) {
        CAScrollLayer * obj = self.layer.sublayers[i];
        [obj stopAnimate];
    }
}


- (void)removeAllSublayers{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}

@end
