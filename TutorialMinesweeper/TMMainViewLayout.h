//
//  TMMainViewLayout.h
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMMainViewLayout : UICollectionViewFlowLayout
@property float width;
@property float height;
-(id)initWithWidth:(float)width height:(float)height;
@end
