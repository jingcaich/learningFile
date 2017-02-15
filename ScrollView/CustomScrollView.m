//
//  CustomScrollView.m
//  aa
//
//  Created by macPro on 2017/2/15.
//  Copyright © 2017年 macPro. All rights reserved.
//

#import "CustomScrollView.h"
#import "Header.h"

@interface CustomScrollView (){
    NSMutableArray   *_collectionViews;//collectionview数组
    UICollectionViewCell  *_cell;//当前选中的cell
    CustomCollectionView *_currentCollectionView;//当前所在collectionview
    id    _selectedData;//当前选中的数据
    
    BOOL          _overstep;  //判断是否越界
}

@end



@implementation CustomScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.directionalLockEnabled = YES;
        self.contentSize = CGSizeMake(0, 0);
        self.backgroundColor = [UIColor whiteColor];
        self.alwaysBounceHorizontal = YES;
//        self.scrollEnabled = NO;
        self.pagingEnabled = YES;
    }
    return self;
}


- (void)setInitialDatas:(NSMutableArray *)initialDatas{
    _initialDatas = initialDatas;
    [self newCollection];
}


- (void)newCollection{
    CGSize size = self.contentSize;
    self.contentSize = CGSizeMake((size.width+widthH), size.height);
    
    CustomCollectionView *collectionView = [[CustomCollectionView alloc]initWithFrame:CGRectMake(_collectionViews.count*widthH, 0, widthH, self.frame.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    if (_collectionViews.count != 0) {
        collectionView.dataSources = [NSMutableArray arrayWithCapacity:0];
    }else{
        collectionView.dataSources = [NSMutableArray arrayWithArray:_initialDatas];
    }
    //    [_collectionViews addObject:collectionView];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_collectionViews];
    [arr addObject:collectionView];
    _collectionViews = arr;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    UIImage *i = [CustomScrollView conpressOriginalImage:[UIImage imageNamed:@"f.jpg"] toSize:collectionView.frame.size];
    
    collectionView.backgroundColor = [UIColor colorWithPatternImage:i];
    [collectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self addSubview:collectionView];
    
    
    [self addGestureOnCollectionView:collectionView];
}


+ (UIImage *)conpressOriginalImage:(UIImage *)image toSize:(CGSize)size{
//    UIImage *resultImage = image;
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}

//为collectionview添加手势
- (void)addGestureOnCollectionView:(UICollectionView *)collectionView{
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleGesture:)];
    lp.delegate = self;
    [collectionView addGestureRecognizer:lp];
    lp.minimumPressDuration = 0.5;
    
    
}

- (void)handleGesture:(UILongPressGestureRecognizer *)longGesture{
    //NSLog(@"==========================================");
    
    
    for (CustomCollectionView *cv in _collectionViews) {
        //NSLog(@"当前collectionview的index==========%u",[_collectionViews indexOfObject:cv]);
        if (longGesture.view == cv) {
            //判断手势状态
            switch (longGesture.state) {
                case UIGestureRecognizerStateBegan:{
  
                    //判断手势落点位置是否在路径上
                    NSIndexPath *indexPath = [cv indexPathForItemAtPoint:[longGesture locationInView:cv]];
                    
                    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[cv cellForItemAtIndexPath:indexPath];
                    //                    [self shakeImage:cell];
                    _cell = cell;
                    
                    _selectedData = cv.dataSources[indexPath.item];
                    
                    
                    if (indexPath == nil) {
                        break;
                    }
                    //在路径上则开始移动该路径上的cell
                    [cv beginInteractiveMovementForItemAtIndexPath:indexPath];
                }
                    break;
                case UIGestureRecognizerStateChanged:{
                    //            移动时更新cell
                    [cv updateInteractiveMovementTargetPosition:[longGesture locationInView:cv]];
                    _overstep = YES;
                    if (_cell.frame.origin.x+_cell.frame.size.width>widthH) {
                        //NSLog(@"右越界处理");
                        
                        NSInteger index = [_collectionViews indexOfObject:cv];
                        //位于最后一个collectionview 越界新建
                        if (index == _collectionViews.count-1) {
                            [self newCollection];
                        }
                        
                        _currentCollectionView = _collectionViews[index+1];
                        if ([_currentCollectionView.dataSources indexOfObject:_selectedData] == NSNotFound) {
                            
                            [_currentCollectionView.dataSources addObject:_selectedData];
                            [_currentCollectionView reloadData];
                            [self setContentOffset:CGPointMake(self.contentOffset.x+widthH, 0)];
                        }
                        
                    }else if (_cell.frame.origin.x < 0){
                        //NSLog(@"左越界处理");
                        
                        if (self.contentOffset.x == 0) {
                            return;
                        }else if (_cell.frame.origin.x < 0 && _cell.frame.origin.x > -widthH){
                            
                            NSInteger index = [_collectionViews indexOfObject:cv];
                            _currentCollectionView = _collectionViews[index-1];
                            [_currentCollectionView.dataSources addObject:_selectedData];
                            
                            [self setContentOffset:CGPointMake(self.contentOffset.x-widthH, 0)];
                        }
                        
                    }else{
                        _overstep = NO;
                    }
                    
                }
                    break;
                case UIGestureRecognizerStateEnded:{
                  
                    
//                    NSIndexPath *indexPath = [cv indexPathForItemAtPoint:[longGesture locationInView:cv]];
                    
//                    CustomCollectionViewCell *cell = (CustomCollectionViewCell *)[cv cellForItemAtIndexPath:indexPath];
//                    [self resume:cell];
                    //
                    //移动结束后关闭cell移动
                    [cv endInteractiveMovement];
                    [_currentCollectionView reloadData];
                    if (_overstep) {
                        [cv.dataSources removeObject:_selectedData];
                    }
                    
                    [cv reloadData];
                }
                    break;
                default:
                    [cv cancelInteractiveMovement];
//                    self.isHighlight = NO;
                    [cv reloadData];
                    break;
            }
            
        }
    }
    
}


#pragma mark -- collection view代理
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    
    CustomCollectionView *cv = (CustomCollectionView *)collectionView;
    //取出源item数据
    id objc = [cv.dataSources objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [cv.dataSources removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [cv.dataSources insertObject:objc atIndex:destinationIndexPath.item];
    if (_overstep) {
        NSLog(@"overstep");
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CustomCollectionView *cv = (CustomCollectionView *)collectionView;
    return cv.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCollectionView *cv = (CustomCollectionView *)collectionView;
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = cv.dataSources[indexPath.item];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40, 10, 10, 10);
}





@end
