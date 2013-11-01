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
-(void)passportSeries:(NSString*)passportSeries;
-(void)passportNumber:(NSString*)passportNumber;
@end

@interface CAPassportTextField : UIView <UITextFieldDelegate>
{
    id <CAPassportTextFieldDelegate> delegate;
}

@property (nonatomic, assign)id <CAPassportTextFieldDelegate> delegate;
@property (strong, nonatomic) WTReTextField *passportSeries;
@property (strong, nonatomic) WTReTextField *passportNumber;

@end
