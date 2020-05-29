//
//  MKScrollBall.h
//  Ball
//
//  Created by Face on 2020/5/26.
//  Copyright © 2020 Face. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTScrollBallLayer.h"

NS_ASSUME_NONNULL_BEGIN
@class BTScrollBallView;




@protocol BTScrollBallDataSource <NSObject>

@optional

/// 要显示多少组号码
/// @param scrollBall 试图
- (NSInteger)numberOfSectionsInScrollBall:(BTScrollBallView *)scrollBall;


@required

/// 每滚动列的球数
/// @param scrollBall 视图
/// @param section 当前列
- (NSInteger)scrollBall:(BTScrollBallView *)scrollBall numberOfRowsInSection:(NSInteger)section;

/// 自定义显示的视图
/// @param scrollBall 视图
/// @param indexPath 当前球的位置
- (CALayer*)scrollBall:(BTScrollBallView *)scrollBall ballForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol BTScrollBallDelegate <NSObject>

@optional


/// 每个球的大小
/// @param scrollBall 试图
/// @param section 列位置
- (CGSize)scrollBall:(BTScrollBallView *)scrollBall sizeForItemAtIndex:(NSInteger)section;


/// 行间距，每列号码球之间的间距
/// @param scrollBall 试图
/// @param indexPath 当前球的位置
- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall minimumLineSpacingForSectionAtIndexPath:(NSIndexPath *)indexPath;


/// 列间距
/// @param scrollBall 视图
/// @param section 当前列的位置
- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;

/// 距离顶部间距
/// @param scrollBall 视图
/// @param section 每组球
- (CGFloat)scrollBall:(BTScrollBallView *)scrollBall insetSpaceingForSectionAtIndex:(NSInteger)section;

/// 距离左侧距离
/// @param scrollBall 视图
- (CGFloat)leadingOfSectionsInScrollBall:(BTScrollBallView *)scrollBall;

/// 动画结束回调代理方法
/// @param scrollBall 视图
/// @param completion 动画是否结束
- (void)scrollBall:(BTScrollBallView *)scrollBall animatedCompletion:(BOOL)completion;

/// 动画是否被停止回调
/// @param scrollBall 视图
/// @param stoped 动画是否停止
- (void)scrollBall:(BTScrollBallView *)scrollBall animationStoped:(BOOL)stoped;
@end

@interface BTScrollBallView : UIView

/// 数据源方法
@property (weak,nonatomic) id<BTScrollBallDataSource> dataSource;

/// 代理方法
@property (weak,nonatomic) id<BTScrollBallDelegate> delegate;

- (void)reloadData;

/// scroll to bottom for point, the imp delay is 0.05 second
/// @param animate defulat is NO
- (void)scrollToBottomWithAnimate:(BOOL)animate;

/// scroll to zero point,the imp delay is 0.01 second
/// @param animate defalut is NO
- (void)scrollToTopWithAnimate:(BOOL)animate;


@end

NS_ASSUME_NONNULL_END
