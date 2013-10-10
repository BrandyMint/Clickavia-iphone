//
//  CASearchFormClassView.h
//  CASearchForm
//
//  Created by macmini2 on 11.09.13.
//  Copyright (c) 2013 easy-pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <QuartzCore/QuartzCore.h>
#import "SearchConditions.h"
#import "CASearchFormTriangleView.h"
#import "CASearchFormClassCell.h"

@class CATooltipSelect;
@protocol CAPaymentTableViewDelegate
- (void) paymentTableView:(CATooltipSelect*)paymentTableView currentPayment:(NSString*)currentPayment;
@end

@interface CATooltipSelect : UIView<UITableViewDataSource, UITableViewDelegate>

@property (assign) id<CAPaymentTableViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame widthTableBorder:(CGFloat)height;

- (void) setFrameForTrianglePlace:(CGRect)buttonFrame;
- (void) setClassCellHeight: (CGFloat)height;
- (void) setCheckClassSelectorImage: (UIImage*)image;

- (void) valuesTableRows:(NSArray*)valuesTableRows;
- (void) heightForRowAtIndexPath:(CGFloat)height;

@end
