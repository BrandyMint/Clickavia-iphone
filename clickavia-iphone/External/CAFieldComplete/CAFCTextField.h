//
//  CATextFieldComplete.h
//  cafieldcomplete
//
//  Created by macmini1 on 29.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Destination.h"
#import <QuartzCore/QuartzCore.h>
#import "CAFCStyle.h"

@class CAFieldCompleteView;
@class CAFCTextField;
@protocol CATextFieldCompleteDelegate
- (void)textFieldComplete:(CAFCTextField*) textField changeString:(NSString*)oldText withString:(NSString*)newText;
- (void)textFieldCompleteDidBeginEditing:(CAFCTextField*)textField;
- (void)textFieldCompleteDidEndEditing:(CAFCTextField*) textField;
- (void)textFieldCompleteClear:(CAFCTextField*)textField;
- (void)textFieldCompleteReturn:(CAFCTextField*)textField;
@end

@interface CAFCTextField : UIView <UITextFieldDelegate>
{
    UITextField *destinationNameTextField;
    UILabel *cityCodeLabel;
    
    NSArray *gradientColors;
    CAGradientLayer *gradientLayer;
    UIImageView *backgroundView;
}
@property (assign) id <CATextFieldCompleteDelegate> delegate;
- (void) setDestination:(Destination*) destination;
- (void) becomeActive:(BOOL)needFR;
- (NSString*) text;
@end
