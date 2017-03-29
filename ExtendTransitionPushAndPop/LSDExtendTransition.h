//
//  LSDExtendTransition.h
//  ExtendTransitionPushAndPop
//
//  Created by 神州锐达 on 17/3/29.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSDExtendTransition : NSObject<UIViewControllerAnimatedTransitioning>

///
@property(assign,nonatomic)UINavigationControllerOperation operation;

///
@property(assign,nonatomic)NSTimeInterval duration;

///
@property(assign,nonatomic)CGRect selectedFrame;

///
@property(strong,nonatomic)UIImageView *imageViewTop;

///
@property(strong,nonatomic)UIImageView *imageViewBottom;

@end
