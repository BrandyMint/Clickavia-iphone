//
//  CABuyerPickerView.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 06/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerPickerView.h"

@implementation CABuyerPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton* acceptButton = [[UIButton alloc] initWithFrame:CGRectMake(210, 5, 100, 30)];
        [acceptButton addTarget:self action:@selector(acceptlButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [acceptButton setBackgroundImage:[UIImage imageNamed:@"CASearchFormControls-button.png"] forState:UIControlStateNormal];
        [acceptButton setTitle:@"готово" forState:UIControlStateNormal];
        [acceptButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15.0]];
        [self addSubview: acceptButton];
        
        UIButton* cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
        [cancelButton addTarget:self action:@selector(cancelButtonPress) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"CASearchFormControls-button.png"] forState:UIControlStateNormal];
        [cancelButton setTitle:@"отменить" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:15.0]];
        [self addSubview: cancelButton];
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:[[UIImage imageNamed:@"_bar-green-warm.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch]]];
        
        datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 40, 320, 180)];
        [datepicker setDatePickerMode:UIDatePickerModeDate];
        [datepicker setDate:[NSDate date]];
        [datepicker addTarget:self action:@selector(showDate) forControlEvents:UIControlEventValueChanged];
        datepicker.backgroundColor = [UIColor whiteColor];
        [self addSubview: datepicker];
    }
    return self;
}

#pragma mark - action's methods -

- (void) cancelButtonPress
{
    [_delegate cancelButtonPress];
}

- (void) acceptlButtonPress
{
    if (isBirthday)
    {
        [_delegate datePickerDidSelectedDate:[datepicker date] fieldId:birthday indexCell:index sender:idSender];
    }
    else
    {
        [_delegate datePickerDidSelectedDate:[datepicker date] fieldId:validDay indexCell:index sender:idSender];
    }
    [_delegate acceptButtonPress];
}

- (void) showDate
{
    
}

-(void)indexCell:(NSInteger)indexCell typeButton:(idField)typeButton sender:(id)sender
{
    index = indexCell;
    idSender = sender;
    if (typeButton == birthday)
        isBirthday = YES;
    else
        isBirthday = NO;
}

@end
