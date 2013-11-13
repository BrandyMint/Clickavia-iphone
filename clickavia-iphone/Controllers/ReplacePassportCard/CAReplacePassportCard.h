//
//  CAReplacePassportCard.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 13/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPassportTextField.h"
#import "PersonInfo.h"
#import "CABuyerPickerView.h"

@class CAReplacePassportCard;
@protocol CAReplacePassportCardDelegate
@optional
- (void) modified:(PersonInfo*)modified index:(NSInteger)index;
@end

@interface CAReplacePassportCard : UIViewController <UITextFieldDelegate, CAPassportTextFieldDelegate, CABuyerPickerViewDelegate>

@property (assign) id <CAReplacePassportCardDelegate> delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil personInfoCard:(PersonInfo* )personInfoCard index:(NSInteger)index;

@end
