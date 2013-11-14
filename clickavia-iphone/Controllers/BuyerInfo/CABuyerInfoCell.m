//
//  CABuyerInfoCell.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 06/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerInfoCell.h"
#import "WTReTextField.h"
#import "CABuyerInfo.h"

@implementation CABuyerInfoCell
{
    CAPassportTextField* passportField;
    UIButton* validDayButton;
    UIButton* birthdayButton;
}

@synthesize nameTextField, surnameTextField, segmentedControl;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [surnameTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    // Configure the view for the selected state
}

-(void)initByIndex:(NSInteger)index
{
    indexCell = index;
    
    UILabel *numberBuyer = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 0, 0)];
    numberBuyer.text = [NSString stringWithFormat:@"%d",index+1];
    [numberBuyer sizeToFit];
    numberBuyer.backgroundColor = [UIColor clearColor];
    [self addSubview:numberBuyer];
    
    UIButton *onInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
    onInfo.tag = index;
    [onInfo addTarget:nil action:@selector(alreadyHave:) forControlEvents:UIControlEventTouchUpInside];
    [onInfo setTitle:@"Delete" forState:UIControlStateNormal];
    onInfo.frame = CGRectMake(numberBuyer.frame.origin.x + numberBuyer.frame.size.width + 15, numberBuyer.frame.origin.y, 20, numberBuyer.frame.size.height);
    [self addSubview:onInfo];
    
    UILabel* alreadyHave = [[UILabel alloc] initWithFrame:CGRectMake(onInfo.frame.origin.x + onInfo.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
    alreadyHave.text = @"Уже заполняли?";
    [alreadyHave sizeToFit];
    alreadyHave.backgroundColor = [UIColor clearColor];
    [self addSubview:alreadyHave];
    
    UIButton *deleteCell = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [deleteCell addTarget:nil action:@selector(deleteTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
    [deleteCell setTitle:@"Delete" forState:UIControlStateNormal];
    deleteCell.frame = CGRectMake(alreadyHave.frame.origin.x + alreadyHave.frame.size.width + 15, alreadyHave.frame.origin.y, 20, alreadyHave.frame.size.height);
    [self addSubview:deleteCell];
    
    UILabel* delete = [[UILabel alloc] initWithFrame:CGRectMake(deleteCell.frame.origin.x + deleteCell.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
    delete.text = @"Удалить";
    [delete sizeToFit];
    delete.backgroundColor = [UIColor clearColor];
    [self addSubview:delete];
    
    surnameTextField = [[WTReTextField alloc] initWithFrame:CGRectMake(10, numberBuyer.frame.origin.y + 23, 300, 30)];
    surnameTextField.borderStyle = UITextBorderStyleRoundedRect;
    surnameTextField.font = [UIFont systemFontOfSize:15];
    surnameTextField.placeholder = @"ФАМИЛИЯ";
    surnameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    surnameTextField.keyboardType = UIKeyboardTypeDefault;
    surnameTextField.returnKeyType = UIReturnKeyDone;
    surnameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    surnameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    surnameTextField.delegate = self;
    surnameTextField.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
    [self addSubview:surnameTextField];
    
    nameTextField = [[WTReTextField alloc] initWithFrame:CGRectMake(10, surnameTextField.frame.origin.y + surnameTextField.frame.size.height + 2, 300, 30)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.font = [UIFont systemFontOfSize:15];
    nameTextField.placeholder = @"ИМЯ";
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextField.returnKeyType = UIReturnKeyDone;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameTextField.delegate = self;
    nameTextField.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
    [self addSubview:nameTextField];
    
    UILabel *asking = [[UILabel alloc] initWithFrame:CGRectMake(nameTextField.frame.origin.x, nameTextField.frame.origin.y + nameTextField.frame.size.height, 0, 0)];
    asking.text = @"  MR   MRS  CHD   INF";
    [asking sizeToFit];
    asking.backgroundColor = [UIColor clearColor];
    [self addSubview:asking];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"One", @"Two", @"Three", @"Four", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-man.png"] forSegmentAtIndex:0];
    [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:1];
    [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:2];
    [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-baby.png"] forSegmentAtIndex:3];
    segmentedControl.frame = CGRectMake(surnameTextField.frame.origin.x, nameTextField.frame.origin.y + nameTextField.frame.size.height + 20, 180, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segmentedControl];
    
    UILabel *passport = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x, segmentedControl.frame.origin.y + segmentedControl.frame.size.height, 0, 0)];
    passport.text = @"Серия и № паспорта";
    [passport sizeToFit];
    passport.backgroundColor = [UIColor clearColor];
    [self addSubview:passport];
    
    //2 TextField с разделенной чертой
    passportField = [[CAPassportTextField alloc]initWithFrame:CGRectMake(passport.frame.origin.x, passport.frame.origin.y + passport.frame.size.height + 2, segmentedControl.frame.size.width, 30) initPasportSerial:nil initPassportNumber:nil];
    passportField.delegate = self;
    [self addSubview:passportField];
    
    UILabel * dateBirth = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, asking.frame.origin.y, 0, 0)];
    dateBirth.text = @"Дата рождения";
    [dateBirth sizeToFit];
    dateBirth.backgroundColor = [UIColor clearColor];
    [self addSubview:dateBirth];
    
    UILabel * validity = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, passport.frame.origin.y, 0, 0)];
    validity.text = @"Срок действия";
    [validity sizeToFit];
    validity.backgroundColor = [UIColor clearColor];
    [self addSubview:validity];
    
    validDayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    validDayButton.frame = CGRectMake(200, 160, 120, 30);
    [validDayButton setTitle:@"10.10.1900" forState:UIControlStateNormal];
    [validDayButton addTarget:self action:@selector(validDay:) forControlEvents:UIControlEventTouchUpInside];
    validDayButton.tag = 2;
    [self addSubview:validDayButton];
    
    birthdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    birthdayButton.frame = CGRectMake(200, 110, 120, 30);
    [birthdayButton setTitle:@"10.10.1900" forState:UIControlStateNormal];
    [birthdayButton addTarget:self action:@selector(birthday:) forControlEvents:UIControlEventTouchUpInside];
    birthdayButton.tag = 1;
    [self addSubview:birthdayButton];
}

-(void)segmentedControl:(id)sender;
{
    [surnameTextField resignFirstResponder];
    [nameTextField resignFirstResponder];

    [_delegate tableViewCell:self segmentedControlId:segmentedControl.selectedSegmentIndex indexCell:indexCell];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate activeTextField:textField indexCell:indexCell];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_delegate activeTextField:nil indexCell:indexCell];
    if (textField == surnameTextField) {
        [_delegate tableViewCell:self textDidEndEditing:textField.text fieldId:lastname indexCell:indexCell sender:nil];
    }
    if (textField == nameTextField) {
        [_delegate tableViewCell:self textDidEndEditing:textField.text fieldId:name indexCell:indexCell sender:nil];
    }
}

#pragma mark CAPassportTextFieldDelegate

-(void)activeTextFieldPassport:(UITextField*)activeTextFieldPassport
{
    [_delegate activeTextField:activeTextFieldPassport indexCell:indexCell];
}

-(void)passportSeries:(UITextField *)textField;
{
    [_delegate tableViewCell:self textDidEndEditing:textField.text fieldId:passportSeries indexCell:indexCell sender:nil];
}

-(void)passportNumber:(UITextField*)textField
{
    [_delegate tableViewCell:self textDidEndEditing:textField.text fieldId:passportNumber indexCell:indexCell sender:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)validDay:(id)sender
{
    [_delegate validDay:sender];
}

-(void)birthday:(id)sender
{
    [_delegate birthday:sender];
}

- (void)setPassportSerial:(NSString *)passportSerial
{
    passportField.passportSeries.text = passportSerial;
}

- (void)setPassportNumber:(NSString *)passportNumber
{
    passportField.passportNumber.text = passportNumber;
}

- (void)setTitleButtonBirthday:(NSString *)title
{
    [birthdayButton setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleButtonValidday:(NSString *)title
{
    [validDayButton setTitle:title forState:UIControlStateNormal];
}

@end
