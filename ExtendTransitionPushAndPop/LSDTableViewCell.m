//
//  LSDTableViewCell.m
//  ExtendTransitionPushAndPop
//
//  Created by 神州锐达 on 17/3/28.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDTableViewCell.h"

@interface LSDTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconimageView;

@end

@implementation LSDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.iconimageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setImageStr:(NSString *)imageStr
{

    _imageStr = imageStr;
    
    self.iconimageView.image = [UIImage imageNamed:imageStr];
}

@end
