//
//  CAColumnView.h
//  CAColumnsControl
//
//  Created by denisdbv@gmail.com on 18.07.13.
//  Copyright (c) 2013 DenisDbv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flight.h"
#import "CAColumnViewDelegate.h"

#define COLUMN_WIDTH  40
#define COLUMN_HEIGHT  150
#define COLUMNS_MARGIN  1
#define COLUMN_ALL_WIDTH ((COLUMN_WIDTH+COLUMNS_MARGIN)+COLUMNS_MARGIN)

@interface CAColumnView : UIView

@property (nonatomic, retain) id delegate;

- (id)initWithFrame:(CGRect)frame byObject:(Flight*)flightObject;
-(void) unselectBackgroundColorView;
-(void) selectBackgroundColorView;

@end
