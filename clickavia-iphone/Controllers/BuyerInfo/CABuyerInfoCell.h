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

@end

@interface CABuyerInfoCell : UITableViewCell <UITextFieldDelegate, CAPassportTextFieldDelegate>
{
    NSInteger indexCell;
}

@property (assign) id <CABuyerInfoCellDelegate> delegate;
@property (nonatomic, retain) WTReTextField* nameTextField;
@property (nonatomic, retain) WTReTextField* surnameTextField;

- (void) initByIndex:(NSInteger)index;
- (void) dateFromPicker:(NSDate*)date;
-(void)didSelectDatePicker:(NSDate *)date typeField:(idField)typeField indexCell:(NSInteger)indexCell sender:(id)sender;
@end
