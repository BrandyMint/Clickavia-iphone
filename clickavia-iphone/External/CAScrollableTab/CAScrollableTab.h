//
//  CAScrollableTab.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAScrollableTabDelegate.h"
#import "CATabCell.h"

@interface CAScrollableTab : UIView

@property (nonatomic, weak) id <CAScrollableTabDelegate> delegate;

@property (nonatomic, assign, getter = isSelected) BOOL selected;

+ (CGFloat)widthForText:(NSString *)sampleText;

- (id)initWithFrame:(CGRect)frame tabCell:(CATabCell*)cell index:(NSInteger)index;

@end
