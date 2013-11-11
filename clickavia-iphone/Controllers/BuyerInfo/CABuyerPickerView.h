//
//  CABuyerPickerView.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 06/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CABuyerInfoCell.h"

@class CABuyerPickerView;
@protocol CABuyerPickerViewDelegate
@optional
- (void) cancelButtonPress;
- (void) acceptButtonPress;
- (void) datePickerDidSelectedDate:(NSDate*)selectedDate fieldId:(idField)fieldId indexCell:(NSInteger)indexCell sender:(id)sender;
@end

@interface CABuyerPickerView : UIView
{
    UIDatePicker* datepicker;
    NSInteger index;
    BOOL isBirthday;
    id idSender;
}

@property (assign) id<CABuyerPickerViewDelegate> delegate;

-(void)indexCell:(NSInteger)indexCell typeButton:(idField)typeButton sender:(id)sender;
@end
