//
//  CustomCollectionViewCell.m
//  aa
//
//  Created by macPro on 2017/2/13.
//  Copyright © 2017年 macPro. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)setShake:(BOOL)shake{
    CALayer*viewLayer=[self layer];
    
    if (shake == YES) {
        CABasicAnimation*animation=[CABasicAnimation
                                    
                                    animationWithKeyPath:@"transform"];
        animation.duration=100000;
        animation.repeatCount = 100000;
        animation.autoreverses=YES;
        animation.fromValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                             
                             (viewLayer.transform, -0.3, 0.0, 0.0, 0.03)];
        animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate
                           
                           (viewLayer.transform, 0.3, 0.0, 0.0, 0.03)];
        
        [UIView animateWithDuration:100 animations:^{
            [viewLayer addAnimation:animation forKey:@"wiggle"];
        } completion:nil];
        
//        [viewLayer addAnimation:animation forKey:@"wiggle"];
    }else{
        [viewLayer removeAllAnimations];
    }
    
}

@end
