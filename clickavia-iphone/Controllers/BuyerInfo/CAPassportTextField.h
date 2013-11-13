//
//  CAPassportTextField.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 30/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WTReTextField.h"

@protocol CAPassportTextFieldDelegate
-(void)passportSeries:(UITextField *)passportSeries;
-(void)passportNumber:(UITextField *)passportNumber;
-(void)activeTextFieldPassport:(UITextField*)activeTextFieldPassport;
@end


@interface CAPassportTextField : UIView <UITextFieldDelegate>
{
    id <CAPassportTextFieldDelegate> delegate;
}

@property (nonatomic, retain) id <CAPassportTextFieldDelegate> delegate;
@property (strong, nonatomic) WTReTextField *passportSeries;
@property (strong, nonatomic) WTReTextField *passportNumber;

- (id)initWithFrame:(CGRect)frame initPasportSerial:(NSString*)initPasportSerial initPassportNumber:(NSString* )initPassportNumber;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
