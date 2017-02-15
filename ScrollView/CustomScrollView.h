//
//  CustomScrollView.h
//  aa
//
//  Created by macPro on 2017/2/15.
//  Copyright © 2017年 macPro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollView : UIScrollView<UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property(nonatomic,strong)NSMutableArray *initialDatas;

//创建新的collectionview
- (void)newCollection;



@end
