//
//  TMMainViewLayout.m
//  TutorialMinesweeper
//
//  Created by hiroki8080 on 2014/03/27.
//  Copyright (c) 2014年 hiroki8080. All rights reserved.
//

#import "TMMainViewLayout.h"

@implementation TMMainViewLayout
@synthesize width;
@synthesize height;

-(id)initWithWidth:(float)w height:(float)h {
    self = [super init];
    if (self) {
        self.width = w;
        self.height = h;
    }
    return self;
}

-(CGSize)collectionViewContentSize{
    return CGSizeMake(self.width, self.height);
}

@end
