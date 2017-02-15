//
//  Header.h
//  aa
//
//  Created by macPro on 2017/2/13.
//  Copyright © 2017年 macPro. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import <UIKit/UIKit.h>
#import "CustomCollectionViewCell.h"

#import "ViewController.h"
#import "CustomCollectionViewController.h"
#import "CustomCollectionView.h"
#import "CustomScrollView.h"


#define widthH  [[UIScreen mainScreen] bounds].size.width
#define heightH  [[UIScreen mainScreen] bounds].size.height


#define scaleImageToSize(image,w,h)   {\                                     UIImage *resultImage = image  \                         UIGraphicsBeginImageContext(CGSizeMake(w,h))   \                     [resultImage drawInRect:CGRectMake(0, 0, w, h)]   \            UIGraphicsEndImageContext() \                                           return resultImage}




#endif /* Header_h */
