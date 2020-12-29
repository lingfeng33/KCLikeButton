//
//  KCLikeButton.m
//  KCLikeButton
//
//  Created by joly on 2020/12/29.
//

#import "KCLikeButton.h"

#define KCFavoriteViewLikeBeforeTag 1 //点赞
#define KCFavoriteViewLikeAfterTag  2 //取消点赞

@implementation KCLikeButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    CGRect frame = self.frame;
    //为点赞图片之前添加图片以及手势
    _likeBefore = [[UIImageView alloc]initWithFrame:frame];
    _likeBefore.contentMode = UIViewContentModeCenter;
    _likeBefore.image = [UIImage imageNamed:@"icon_home_like_before"];
    _likeBefore.userInteractionEnabled = YES;
    _likeBefore.tag = KCFavoriteViewLikeBeforeTag;
    [_likeBefore addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [self addSubview:_likeBefore];
    
    //为点赞图片之后添加图片以及手势
    _likeAfter = [[UIImageView alloc]initWithFrame:frame];
    _likeAfter.contentMode = UIViewContentModeCenter;
    _likeAfter.image = [UIImage imageNamed:@"icon_home_like_after"];
    _likeAfter.userInteractionEnabled = YES;
    _likeAfter.tag = KCFavoriteViewLikeAfterTag;
    [_likeAfter setHidden:YES];
    [_likeAfter addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];
    [self addSubview:_likeAfter];
}

- (void)handleGesture:(UITapGestureRecognizer *)sender {
   
    switch (sender.view.tag) {
        case KCFavoriteViewLikeBeforeTag:
            //开始动画(点赞)
            [self startLikeAnim:YES];
            break;
        case KCFavoriteViewLikeAfterTag:
            //开始动画(取消点赞)
            [self startLikeAnim:NO];
            
        default:
            break;
    }
    
    
}

-(void)startLikeAnim:(BOOL)isLike {
    
    _likeBefore.userInteractionEnabled = NO;
    _likeBefore.userInteractionEnabled = NO;
    
    if (isLike) {
        //点赞
        //三角形length
        CGFloat length = 30;
        
        //动画时长
        CGFloat duration = self.likeDuration >0?self.likeDuration:0.5f;
        for (int i = 0; i < 6; i++) {
            //围绕圆心360度创建6个三角形.循环6次
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.position = _likeBefore.center;
            layer.fillColor = self.zanFillColor == nil?[UIColor redColor].CGColor:self.zanFillColor.CGColor;
            
            //贝塞尔创建三角形
            UIBezierPath *startPath = [UIBezierPath bezierPath];
            [startPath moveToPoint:CGPointMake(-2.0, -length)];
            [startPath addLineToPoint:CGPointMake(2.0, -length)];
            [startPath addLineToPoint:CGPointMake(0, 0)];
            layer.path = startPath.CGPath;
            
            layer.transform = CATransform3DMakeRotation(M_PI/3.0*i, 0, 0, 1);
            [self.layer addSublayer:layer];
            
            //创建动画组
            CAAnimationGroup *group =[[CAAnimationGroup alloc]init];
            group.removedOnCompletion = NO;
            group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            group.fillMode = kCAFillModeForwards;
            group.duration = duration;
            
            //缩放! 路径
            CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            scaleAnima.fromValue = @(0.0);
            scaleAnima.toValue = @(1.0);
            scaleAnima.duration = duration * 0.2f;
            
            //结束路径
            UIBezierPath *endPath = [UIBezierPath bezierPath];
            [endPath moveToPoint:CGPointMake(-2.0, -length)];
            [endPath addLineToPoint:CGPointMake(2.0, -length)];
            [endPath addLineToPoint:CGPointMake(0, -length)];
            
            CABasicAnimation *pathAnim = [CABasicAnimation animationWithKeyPath:@"path"];
            pathAnim.fromValue = (__bridge id)layer.path;
            pathAnim.toValue = (__bridge id)endPath.CGPath;
            pathAnim.beginTime = duration * 0.2f;
            pathAnim.duration = duration * 0.8f;
            
            [group setAnimations:@[scaleAnima,pathAnim]];
            [layer addAnimation:group forKey:nil];

        }
        
        [_likeAfter setHidden:NO];
        _likeAfter.alpha = 0.0f;
        //桃心缩放且旋转
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI/3*2), 0.5, 0.5);
        
        [UIView animateWithDuration:0.4 delay:0.2 usingSpringWithDamping:0.6f initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            self.likeBefore.alpha = 0.0f;
            self.likeAfter.alpha = 1.0f;
            self.likeAfter.transform =CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1, 1);
            
            
        } completion:^(BOOL finished) {
            self.likeBefore.alpha = 1.0f;
            self.likeBefore.userInteractionEnabled = YES;
            self.likeAfter.userInteractionEnabled = YES;
            if (self.likeBeforBlock) {
                self.likeBeforBlock();
            }
        }];
        
        
        
    }else
    {
        
        _likeAfter.alpha = 1.0f;
        _likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(0), 1, 1);
        [UIView animateWithDuration:0.35f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.likeAfter.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(-M_PI_4), 0.1f, 0.1f);
                         }
                         completion:^(BOOL finished) {
                             [self.likeAfter setHidden:YES];
                             self.likeBefore.userInteractionEnabled = YES;
                             self.likeAfter.userInteractionEnabled = YES;
                            
            if (self.aftterBeforBlock) {
                self.aftterBeforBlock();
            }
                         }];
        
    }
    
   
}

@end
