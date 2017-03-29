//
//  LSDExtendTransition.m
//  ExtendTransitionPushAndPop
//
//  Created by 神州锐达 on 17/3/29.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDExtendTransition.h"

@interface LSDExtendTransition ()<UIViewControllerTransitioningDelegate>

@end

@implementation LSDExtendTransition

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{

    return self.duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ///来源控制器
    UIViewController *sourceViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *sourceView = sourceViewController.view;
    
    UIViewController *destinationViewController  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *destinationView = destinationViewController.view;
    
    UIView *containerView = transitionContext.containerView;
    
    ///最终的frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:destinationViewController];
    
    destinationView.frame = finalFrame;
    
    UIImage *snapShot = [[UIImage alloc]init];
    CGRect bounds = CGRectMake(0, 0, sourceView.bounds.size.width, sourceView.bounds.size.height);
    
    ///push 绘制图片
    if (self.operation == UINavigationControllerOperationPush) {
        
        ///开启图片上下文
        UIGraphicsBeginImageContextWithOptions(sourceView.bounds.size, YES, 1);
        [sourceView drawViewHierarchyInRect:bounds afterScreenUpdates:NO];
        snapShot = UIGraphicsGetImageFromCurrentImageContext();
        ///关闭图片上下文
        UIGraphicsEndImageContext();
        
        ///获取来源view的截图图片
        CGImageRef tempImageRef = snapShot.CGImage;
        
        // selectedFrame是使用者所选中cell的属性frame
        CGFloat  topHeight = self.selectedFrame.origin.y;
        
        ///计算上部分图片的frame
        CGRect imageViewTopFrame = CGRectMake(0, 0, bounds.size.width, topHeight);
        
        ///计算下部分图片的frame
        CGRect imageViewBottomFrame = CGRectMake(0, topHeight, bounds.size.width, bounds.size.height - self.selectedFrame.origin.y);
        
        ///将截图画到上半部
        CGImageRef topImageRef = CGImageCreateWithImageInRect(tempImageRef, imageViewTopFrame);
        ///将截图画到下半部
        CGImageRef  bottomImageRef = CGImageCreateWithImageInRect(tempImageRef, imageViewBottomFrame);
        
        //上半部分图片
        if (topImageRef != nil) {
            self.imageViewTop = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:topImageRef scale:snapShot.scale orientation:UIImageOrientationUp]];
            
            self.imageViewTop.frame = imageViewTopFrame;
          
        }
        ///下半部分图片
        if (bottomImageRef != nil) {
            self.imageViewBottom = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:bottomImageRef scale:snapShot.scale orientation:UIImageOrientationUp]];
            
            self.imageViewBottom.frame = imageViewBottomFrame;
            
        }
        
    }
    destinationView.alpha = 0.0;
    sourceView.alpha = 0.0;
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    
    ///动画
    if (self.operation == UINavigationControllerOperationPush) {
    
        [containerView addSubview:backgroundView];
        [containerView addSubview:destinationView];
        [containerView addSubview:self.imageViewTop];
        [containerView addSubview:self.imageViewBottom];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]  animations:^{
            self.imageViewTop.frame = CGRectMake(0, -self.imageViewTop.frame.size.height, self.imageViewTop.frame.size.width, self.imageViewTop.frame.size.height);
            
            self.imageViewBottom.frame = CGRectMake(0, bounds.size.height, self.imageViewBottom.frame.size.width, self.imageViewBottom.frame.size.height);
            
            destinationView.alpha = 1.0;
            
        } completion:^(BOOL finished) {
            
            [self.imageViewTop removeFromSuperview];
            [self.imageViewBottom removeFromSuperview];
            
            [transitionContext completeTransition:YES];
            
        }];
    }else
    {
    
        sourceView.alpha = 1.0;
        
        [containerView addSubview:backgroundView];
        [containerView addSubview:sourceView];
        [containerView addSubview:destinationView];
        [containerView addSubview:self.imageViewTop];
        [containerView addSubview:self.imageViewBottom];
        
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
           
            self.imageViewTop.frame = CGRectMake(0, 0, self.imageViewTop.frame.size.width, self.imageViewTop.frame.size.height);
            
            self.imageViewBottom.frame = CGRectMake(0, bounds.size.height - self.imageViewBottom.frame.size.height, self.imageViewBottom.frame.size.width, self.imageViewBottom.frame.size.height);
            
            sourceView.alpha = 0.0;
            
            
        } completion:^(BOOL finished) {
            
            [self.imageViewTop removeFromSuperview];
            [self.imageViewBottom removeFromSuperview];
            
            destinationView.alpha = 1.0;
            
            [transitionContext completeTransition:YES];
            
        }];
        
    }
    
}

#pragma mark -- delegate
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
//{
//    
//    return self;
//}
//
//-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
//{
//
//    return self;
//}


@end
