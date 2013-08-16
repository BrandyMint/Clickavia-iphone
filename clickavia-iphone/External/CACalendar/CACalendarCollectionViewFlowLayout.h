//
//  CACalendarCollectionViewFlowLayout.h
//  CAManagersLib
//
//  Created by macmini1 on 17.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CACalendarCollectionViewFlowLayout : UICollectionViewFlowLayout
@property CGRect parentFrame;
- (id) initWithParentFrame:(CGRect) frame;
@end
