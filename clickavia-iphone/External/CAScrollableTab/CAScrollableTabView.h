//
//  CAScrollableTabView.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAScrollableTabViewDataSource.h"
#import "CAScrollableTabViewDelegate.h"
#import "CAScrollableTabScrollViewDelegate.h"
#import "CATabCell.h"

@interface CAScrollableTabView : UIView <CAScrollableTabScrollViewDelegate>

@property (nonatomic, weak) id <CAScrollableTabViewDelegate> delegate;
@property (nonatomic, weak) id <CAScrollableTabViewDataSource> dataSource;

-(void) reloadData;

- (void)setSelectedItemIndex:(NSInteger)index;

@end
