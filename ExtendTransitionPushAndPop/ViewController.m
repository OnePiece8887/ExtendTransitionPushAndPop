//
//  ViewController.m
//  ExtendTransitionPushAndPop
//
//  Created by 神州锐达 on 17/3/28.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "ViewController.h"
#import "LSDTableViewCell.h"
#import "LSDDetailViewController.h"
#import "LSDExtendTransition.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>

@property (strong, nonatomic)UITableView *tableview;

///
@property(strong,nonatomic)NSArray *dataArray;

///
@property(strong,nonatomic)LSDExtendTransition *transition;

///
@property(assign,nonatomic)CGRect selectedCellFrame;

@end

static NSString *reusedID = @"LSDTableViewCell";

@implementation ViewController

-(LSDExtendTransition *)transition
{

    if (_transition == nil) {
        _transition = [[LSDExtendTransition alloc]init];
    }
    return _transition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
 
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    self.tableview = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"LSDTableViewCellXib" bundle:nil] forCellReuseIdentifier:reusedID];
    [self.view addSubview:tableView];

    
    NSMutableArray *muarray = [NSMutableArray array];
    for (int i = 1; i < 13 ; i ++) {
        NSString *str = [NSString stringWithFormat:@"sea%zd.png",i];
        [muarray addObject:str];
    }
    self.dataArray = muarray.copy;
    
    [self.tableview reloadData];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    LSDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
   
    if (cell == nil) {
        cell = [[LSDTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    
    cell.imageStr = self.dataArray[indexPath.row];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.selectedCellFrame =  [tableView convertRect:[tableView cellForRowAtIndexPath:indexPath].frame toView:tableView.superview];
    
    LSDDetailViewController *detailVC = [[LSDDetailViewController alloc]init];
    
    detailVC.imageStr = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 160;
}

-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{

//    UINavigationControllerOperationNone,
//    UINavigationControllerOperationPush,
//    UINavigationControllerOperationPop,
    if (operation == UINavigationControllerOperationPush) {
        
        self.transition.operation = UINavigationControllerOperationPush;
        self.transition.duration = 1.0;
        self.transition.selectedFrame = self.selectedCellFrame;
        return self.transition;
    }
    
    if (operation == UINavigationControllerOperationPop) {
        
        self.transition.operation = UINavigationControllerOperationPop;
        self.transition.duration = 1.0;
        return self.transition;
    }
    
    return nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
