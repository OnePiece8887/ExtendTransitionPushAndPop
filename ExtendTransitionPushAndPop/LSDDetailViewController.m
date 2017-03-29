
//
//  LSDDetailViewController.m
//  ExtendTransitionPushAndPop
//
//  Created by 神州锐达 on 17/3/28.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDDetailViewController.h"

@interface LSDDetailViewController ()

@end

@implementation LSDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView  = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    
    imageView.image = [UIImage imageNamed:self.imageStr];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItemClick)];
    
    self.navigationItem.leftBarButtonItem = backItem;
}

-(void)backItemClick
{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
