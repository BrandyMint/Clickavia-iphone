//
//  CAPassportTextField.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 30/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPassportTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation CAPassportTextField
@synthesize delegate;
@synthesize passportNumber, passportSeries;

- (id)initWithFrame:(CGRect)frame tag:(NSUInteger)tag;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        passportSeries = [[WTReTextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        passportSeries.borderStyle = UITextBorderStyleNone;
        passportSeries.font = [UIFont systemFontOfSize:15];
        passportSeries.placeholder = @"9708";
        passportSeries.autocorrectionType = UITextAutocorrectionTypeNo;
        passportSeries.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        passportSeries.returnKeyType = UIReturnKeyDone;
        passportSeries.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passportSeries.textAlignment = UITextAlignmentRight;
        passportSeries.backgroundColor = [UIColor whiteColor];
        passportSeries.delegate = self;
        passportSeries.clearButtonMode = UITextFieldViewModeWhileEditing;
        serialTag =  passportSeries.tag = tag;
        passportSeries.pattern = @"^[0-9]{1,}$";
        [self addSubview:passportSeries];
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(passportSeries.frame.origin.x+passportSeries.frame.size.width, passportSeries.frame.origin.y, 1, passportSeries.frame.size.height)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
        
        passportNumber = [[WTReTextField alloc] initWithFrame:CGRectMake(line.frame.origin.x+line.frame.size.width, 0, self.frame.size.width - passportSeries.frame.size.width - line.frame.size.width, 30)];
        passportNumber.borderStyle = UITextBorderStyleNone;
        passportNumber.font = [UIFont systemFontOfSize:15];
        passportNumber.placeholder = @"777888";
        passportNumber.autocorrectionType = UITextAutocorrectionTypeNo;
        passportNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        passportNumber.returnKeyType = UIReturnKeyDone;
        passportNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passportNumber.backgroundColor = [UIColor whiteColor];
        passportNumber.delegate = self;
        passportNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        numberTag = passportNumber.tag = tag*10;
        passportNumber.pattern = @"^[0-9]{1,}$";
        [self addSubview:passportNumber];
        
        [self.layer setCornerRadius:6];
        self.layer.shadowColor = [[UIColor redColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(1.0, -1.0);
        self.layer.shadowRadius = 1;
        self.layer.shadowOpacity = 0.7;
        [self setClipsToBounds:YES];
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    if (textField == passportSeries) {
        if (newLength > 4) {
            [textField resignFirstResponder];
            [passportNumber becomeFirstResponder];
            return NO;
        }
        else
            return YES;
    }
    else {
        if (newLength > 6) {
            return NO;
        }
        else
            return YES;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == passportSeries)
        [delegate passportSeries:textField];
    else
        [delegate passportNumber:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
