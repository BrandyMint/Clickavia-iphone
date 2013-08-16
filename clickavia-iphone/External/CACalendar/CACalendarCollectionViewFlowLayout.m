//
//  CACalendarCollectionViewFlowLayout.m
//  CAManagersLib
//
//  Created by macmini1 on 17.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CACalendarCollectionViewFlowLayout.h"

@implementation CACalendarCollectionViewFlowLayout
- (id) initWithParentFrame:(CGRect) frame
{
    self = [super init];
    if(self)
    {
        _parentFrame = frame;
        self.minimumLineSpacing = 1;
        self.minimumInteritemSpacing = 1000;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.itemSize = CGSizeMake(frame.size.width/2.0, frame.size.height);
    }
    return self;
}
@end
