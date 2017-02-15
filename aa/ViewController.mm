//
//  ViewController.m
//  aa
//
//  Created by macPro on 2017/1/12.
//  Copyright © 2017年 macPro. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"

#define widthH  [[UIScreen mainScreen] bounds].size.width
#define heightH  [[UIScreen mainScreen] bounds].size.height

@interface ViewController (){
    NSArray  *_colors;
    CustomScrollView *_scrollView;

    
    
}

@property(nonatomic,assign)BOOL isHighlight;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    
    if ([self.navigationController respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self initialData];
    
    [self initialSubviews];
    
    
}

- (void)initialData{
    
    _colors = @[[UIColor whiteColor],[UIColor blackColor],[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor yellowColor],[UIColor brownColor],[UIColor grayColor],[UIColor purpleColor]];
}

- (void)initialSubviews{
    _scrollView = [[CustomScrollView alloc]initWithFrame:CGRectMake(0, 40, widthH, self.view.frame.size.height)];
    self.view = _scrollView;
    _scrollView.initialDatas = [_colors mutableCopy];

    
}

//
//- (void)shakeImage:(CustomCollectionViewCell *)cell {
//    
//    //创建动画对象,绕Z轴旋转
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    
//    //设置属性，周期时长
//    
//    [animation setDuration:0.12];
//    
//    //抖动角度
//    
//    animation.fromValue = @(-M_1_PI/5);
//    
//    animation.toValue = @(M_1_PI/5);
//    
//    //重复次数，无限大
//    
//    animation.repeatCount = HUGE_VAL;
//    
//    //恢复原样
//    
//    animation.autoreverses = YES;
//    
//    //锚点设置为图片中心，绕中心抖动
//    
//    cell.layer.anchorPoint = CGPointMake(0.5, 0.5);
//    
//    [cell.layer addAnimation:animation forKey:@"rotation"];
//    
//}
//
//- (void)resume:(CustomCollectionViewCell *)cell {
//    
//    cell.layer.speed = 1.0;
//    
//}
//
//#pragma mark -- 界面切换动画
//
////导航栏动画设置
//- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                            animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                         fromViewController:(UIViewController *)fromVC
//                                                           toViewController:(UIViewController *)toVC  {
//    //NSLog(@"UINavigationControllerOperation======%ld",(long)operation);
//    _navigationOperation = operation;
//    return self;
//}
//
//
//- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    return 0.5;
//}
//
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    
//    UIView *containerView = transitionContext.containerView;
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *from = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    
//    UIView *destinationView ;
//    CGAffineTransform destinationTransform;
//    
//    if (_navigationOperation == UINavigationControllerOperationPush) {
//        [containerView insertSubview:toVC.view aboveSubview:from.view];
//        destinationView = toVC.view;
//        destinationView.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        destinationTransform = CGAffineTransformMakeScale(1, 1);
//        
//    }else if (_navigationOperation == UINavigationControllerOperationPop){
//        [containerView insertSubview:toVC.view belowSubview:from.view];
//        destinationView = from.view;
//        destinationTransform = CGAffineTransformMakeScale(0.1, 0.1);
//        
//    }else{
//        //NSLog(@"none");
//    }
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        destinationView.transform = destinationTransform;
//        [transitionContext completeTransition:YES];
//    }];
//    
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
