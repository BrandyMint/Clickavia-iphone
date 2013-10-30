//
//  CAPassportTextField.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 30/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTReTextField.h"

@interface CAPassportTextField : UIView <UITextFieldDelegate>

@property (strong, nonatomic) WTReTextField *passportSeries;
@property (strong, nonatomic) WTReTextField *passportNumber;

@end
