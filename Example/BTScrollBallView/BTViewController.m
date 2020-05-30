//
//  BTViewController.m
//  BTScrollBallView
//
//  Created by biostome on 05/29/2020.
//  Copyright (c) 2020 biostome. All rights reserved.
//

#import "BTViewController.h"
#import "BTScrollBallView.h"
#import "NSArray+BTNumbers.h"

@interface BTViewController ()<BTScrollBallDataSource,BTScrollBallDelegate>
@property (strong,nonatomic) BTScrollBallView *scrollBall,*scrollBall1;
@property (strong,nonatomic) NSArray<NSArray<NSNumber*>*> *datas;
@end

@implementation BTViewController

- (void)setDatas:(NSArray *)datas{
    _datas = datas;
    [self.scrollBall reloadData];
    [self.scrollBall1 reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollBall];
    [self.view addSubview:self.scrollBall1];
    self.datas = [self makeDatas];;
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    CGFloat x = (CGRectGetWidth(self.view.frame)-250)/2.0;
    self.scrollBall.frame = CGRectMake(x, 100, 250, 50);
    self.scrollBall1.frame = CGRectMake(x, 200, 250, 50);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.datas = [self makeDatas];;
    [self.scrollBall scrollToBottomWithAnimate:YES];
    [self.scrollBall1 scrollToBottomWithAnimate:YES];
}

- (NSArray<NSArray<NSNumber*> *> *)makeDatas{
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        NSInteger f = (arc4random() % 20);
        NSNumber * las = @(0);
        if (self.datas != nil) {
            NSArray * obj = self.datas[i];
            las = obj.lastObject;
        }
        NSArray * mu = [NSArray arrayWithFromValue:las.integerValue toValue:f maxValue:10];
        [arr addObject:mu];
    }
    return arr;
}

// MARK: - MKScrollBallDataSource

- (NSInteger)numberOfSectionsInScrollBall:(BTScrollBallView *)scrollBall{
    return self.datas.count;
}

- (NSInteger)scrollBall:(BTScrollBallView *)scrollBall numberOfRowsInSection:(NSInteger)section{
    NSArray * datas = self.datas[section];
    return datas.count;
}

- (CALayer *)scrollBall:(BTScrollBallView *)scrollBall ballForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (scrollBall == self.scrollBall1) {
        NSNumber * data = self.datas[indexPath.section][indexPath.row];
        BTScrollBallLayer * ssc = [[BTScrollBallLayer alloc]initWithTitle:data.stringValue];
        ssc.ballBackgroundColor = UIColor.yellowColor;
        ssc.ballTitleColor = UIColor.blackColor;
        ssc.backgroundColor = UIColor.clearColor.CGColor;
        return ssc;
    }else{
        NSNumber * data = self.datas[indexPath.section][indexPath.row];
        BTScrollBallLayer * ssc = [[BTScrollBallLayer alloc]initWithTitle:data.stringValue];
        ssc.backgroundColor = UIColor.clearColor.CGColor;
        if (indexPath.section == 1) {
            ssc.ballBackgroundImage = [UIImage imageNamed:@"history_ball_ssc_highlight"];
        }else{
            ssc.ballBackgroundImage = [UIImage imageNamed:@"history_ball_ssc"];
        }
        return ssc;
    }
}

// MARK: - MKScrollBallDataDelegate
- (CGSize)scrollBall:(BTScrollBallView *)scrollBall sizeForItemAtIndex:(NSInteger)section{
    if (scrollBall == self.scrollBall1) {
        return CGSizeMake(CGRectGetHeight(scrollBall.bounds)-5, CGRectGetHeight(scrollBall.bounds)-5);
    }
    return CGSizeMake(CGRectGetHeight(scrollBall.bounds), CGRectGetHeight(scrollBall.bounds));
}

- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (scrollBall == self.scrollBall1) {
        return 2.5;
    }
    return 0;
}

- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall minimumLineSpacingForSectionAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall insetSpaceingForSectionAtIndex:(NSInteger)section{
    if (scrollBall == self.scrollBall1) {
        return 2.5;
    }
    return 0;
}

- (CGFloat)leadingOfSectionsInScrollBall:(BTScrollBallView *)scrollBall{
    if (scrollBall == self.scrollBall1) {
        return (25-(4*2.5))/2.0;
    }
    return 0;
}

- (void)scrollBall:(BTScrollBallView *)scrollBall animatedCompletion:(BOOL)completion{
    completion == YES ? NSLog(@"动画结束") : NSLog(@"动画结束失败");
}

- (void)scrollBall:(BTScrollBallView *)scrollBall animationStoped:(BOOL)stoped{
    stoped == YES ? NSLog(@"动画停止") : NSLog(@"动画停止失败");
}

- (BTScrollBallView *)scrollBall{
    if (!_scrollBall) {
        _scrollBall = [[BTScrollBallView alloc]init];
        _scrollBall.backgroundColor = UIColor.clearColor;
        _scrollBall.dataSource = self;
        _scrollBall.delegate = self;
        _scrollBall.backgroundColor = UIColor.blueColor;
    }
    return _scrollBall;;
}

- (BTScrollBallView *)scrollBall1{
    if (!_scrollBall1) {
        _scrollBall1 = [[BTScrollBallView alloc]init];
        _scrollBall1.backgroundColor = UIColor.clearColor;
        _scrollBall1.dataSource = self;
        _scrollBall1.delegate = self;
        _scrollBall1.backgroundColor = UIColor.blueColor;
    }
    return _scrollBall1;;
}

@end
