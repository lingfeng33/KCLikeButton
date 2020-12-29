//
//  KCLikeButton.h
//  KCLikeButton
//
//  Created by joly on 2020/12/29.
//

#import <UIKit/UIKit.h>

/// 点赞前回调
typedef void(^KCLikeBefreBlock)(void);

/// 点赞后回调
typedef void(^KCLikeAfterBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface KCLikeButton : UIView

//点赞前图片
@property (nonatomic, strong) UIImageView *likeBefore;
//点赞后图片
@property (nonatomic, strong) UIImageView *likeAfter;
//点赞时长
@property (nonatomic, assign) CGFloat     likeDuration;
//点赞按钮填充颜色
@property (nonatomic, strong) UIColor     * zanFillColor;

@property (nonatomic,copy) KCLikeBefreBlock likeBeforBlock;

@property (nonatomic,copy) KCLikeBefreBlock aftterBeforBlock;

@end

NS_ASSUME_NONNULL_END
