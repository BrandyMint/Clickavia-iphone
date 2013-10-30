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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _passportSeries = [[WTReTextField alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        _passportSeries.borderStyle = UITextBorderStyleNone;
        _passportSeries.font = [UIFont systemFontOfSize:15];
        _passportSeries.placeholder = @"9708";
        _passportSeries.autocorrectionType = UITextAutocorrectionTypeNo;
        _passportSeries.keyboardType = UIKeyboardTypeDefault;
        _passportSeries.returnKeyType = UIReturnKeyDone;
        _passportSeries.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passportSeries.textAlignment = UITextAlignmentRight;
        _passportSeries.backgroundColor = [UIColor whiteColor];
        _passportSeries.delegate = self;
        _passportSeries.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passportSeries.tag = 1;
        _passportSeries.pattern = @"^[0-9]{1,}$";
        [self addSubview:_passportSeries];
        
        UIView* line = [[UIView alloc]initWithFrame:CGRectMake(_passportSeries.frame.origin.x+_passportSeries.frame.size.width, _passportSeries.frame.origin.y, 1, _passportSeries.frame.size.height)];
        line.backgroundColor = [UIColor blackColor];
        [self addSubview:line];
        
        _passportNumber = [[WTReTextField alloc] initWithFrame:CGRectMake(line.frame.origin.x+line.frame.size.width, 0, self.frame.size.width - _passportSeries.frame.size.width - line.frame.size.width, 30)];
        _passportNumber.borderStyle = UITextBorderStyleNone;
        _passportNumber.font = [UIFont systemFontOfSize:15];
        _passportNumber.placeholder = @"777888";
        _passportNumber.autocorrectionType = UITextAutocorrectionTypeNo;
        _passportNumber.keyboardType = UIKeyboardTypeDefault;
        _passportNumber.returnKeyType = UIReturnKeyDone;
        _passportNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _passportNumber.backgroundColor = [UIColor whiteColor];
        _passportNumber.delegate = self;
        _passportNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passportNumber.tag = 2;
        _passportNumber.pattern = @"^[0-9]{1,}$";
        [self addSubview:_passportNumber];
        
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
    
    switch (textField.tag) {
        case 1:
            if (newLength > 4) {
                [textField resignFirstResponder];
                [_passportNumber becomeFirstResponder];
                return NO;
            }
            else
                return YES;
            break;
        case 2:
            if (newLength > 6) {
                //[textField resignFirstResponder];

                return NO;
            }
            else
                return YES;
            break;
        default:
            break;
    }
    return YES;
}

@end
