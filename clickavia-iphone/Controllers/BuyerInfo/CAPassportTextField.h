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
@end


@interface CAPassportTextField : UIView <UITextFieldDelegate>
{
    id <CAPassportTextFieldDelegate> delegate;
    NSInteger serialTag;
    NSInteger numberTag;
}

@property (nonatomic, retain) id <CAPassportTextFieldDelegate> delegate;
@property (strong, nonatomic) WTReTextField *passportSeries;
@property (strong, nonatomic) WTReTextField *passportNumber;
- (id)initWithFrame:(CGRect)frame tag:(NSUInteger)tag;
@end
