//
//  CABuyerInfoCell.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 06/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CAPassportTextField.h"

typedef enum
{
    lastname,
    name,
    typePassenger,
    passportSeries,
    passportNumber,
    birthday,
    validDay
} idField;

@class CABuyerInfoCell;
@protocol CABuyerInfoCellDelegate
-(void)tableViewCell:(UITableViewCell* )tableViewCell textDidEndEditing:(NSString *)text fieldId:(idField)fieldId indexCell:(NSInteger)indexCell sender:(id)sender;
-(void)tableViewCell:(UITableViewCell* )tableViewCell segmentedControlId:(idField)segmentedControlId indexCell:(NSInteger)indexCell;
-(void)activeTextField:(UITextField*)activeTextField indexCell:(NSInteger)indexCell;
-(void)validDay:(id)sender;
-(void)birthday:(id)sender;
@end

@interface CABuyerInfoCell : UITableViewCell <UITextFieldDelegate, CAPassportTextFieldDelegate>
{
    NSInteger indexCell;
    UITextField* activeField;
    
    WTReTextField* nameTextField;
    WTReTextField* surnameTextField;
    UISegmentedControl *segmentedControl;
}

@property (assign) id <CABuyerInfoCellDelegate> delegate;
@property (nonatomic, retain) WTReTextField* nameTextField;
@property (nonatomic, retain) WTReTextField* surnameTextField;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;

- (void) initByIndex:(NSInteger)index;
- (void) didSelectDatePicker:(NSDate *)date typeField:(idField)typeField indexCell:(NSInteger)indexCell sender:(id)sender;
- (void) setPassportSerial:(NSString *)passportSerial;
- (void) setPassportNumber:(NSString *)passportNumber;
- (void) setTitleButtonBirthday:(NSString *)title;
- (void) setTitleButtonValidday:(NSString *)title;
@end
