//
//  CAReplacePassportCard.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 13/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAReplacePassportCard.h"
#import "WTReTextField.h"

@interface CAReplacePassportCard ()
{
    PersonInfo* personInfo;
    WTReTextField* surnameTextField;
    WTReTextField* nameTextField;
    UIButton* birthdayButton;
    UIButton* validDayButton;
    UISegmentedControl* segmentedControl;
    BOOL isPickerViewVisible;
    CABuyerPickerView* pickerView;
    NSDateFormatter* dateformatter;
    NSInteger indexCell;
}

@end

@implementation CAReplacePassportCard

-(void)viewWillAppear:(BOOL)animated
{
    pickerView = [[CABuyerPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 220, 320, 220)];
    pickerView.delegate = self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil personInfoCard:(PersonInfo *)personInfoCard index:(NSInteger)index
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        indexCell = index;
        personInfo = [PersonInfo new];
        personInfo = personInfoCard;
        isPickerViewVisible = NO;
        
        dateformatter = [NSDateFormatter new];
        [dateformatter setDateFormat:@"dd.MM.yyyy"];
        
        UIView* mainView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.view.frame.size.width - 4, 200)];
        mainView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:mainView];
        
        UILabel *numberBuyer = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 0, 0)];
        //numberBuyer.text = [NSString stringWithFormat:@"%d",index+1];
        [numberBuyer sizeToFit];
        numberBuyer.backgroundColor = [UIColor clearColor];
        //[self.view addSubview:numberBuyer];
        
        UIButton *onInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [onInfo addTarget:nil action:@selector(deleteTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        [onInfo setTitle:@"Delete" forState:UIControlStateNormal];
        onInfo.frame = CGRectMake(numberBuyer.frame.origin.x + numberBuyer.frame.size.width + 15, numberBuyer.frame.origin.y, 20, numberBuyer.frame.size.height);
        //[self addSubview:onInfo];
        
        UILabel* alreadyHave = [[UILabel alloc] initWithFrame:CGRectMake(onInfo.frame.origin.x + onInfo.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
        alreadyHave.text = @"Уже заполняли?";
        [alreadyHave sizeToFit];
        alreadyHave.backgroundColor = [UIColor clearColor];
        //[self addSubview:alreadyHave];
        
        UIButton *deleteCell = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [deleteCell addTarget:nil action:@selector(deleteTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        [deleteCell setTitle:@"Delete" forState:UIControlStateNormal];
        deleteCell.frame = CGRectMake(alreadyHave.frame.origin.x + alreadyHave.frame.size.width + 15, alreadyHave.frame.origin.y, 20, alreadyHave.frame.size.height);
        //[mainView addSubview:deleteCell];
        
        UILabel* delete = [[UILabel alloc] initWithFrame:CGRectMake(deleteCell.frame.origin.x + deleteCell.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
        delete.text = @"Удалить";
        [delete sizeToFit];
        delete.backgroundColor = [UIColor clearColor];
        //[mainView addSubview:delete];
        
        surnameTextField = [[WTReTextField alloc] initWithFrame:CGRectMake(10, numberBuyer.frame.origin.y + 23, 300, 30)];
        surnameTextField.borderStyle = UITextBorderStyleRoundedRect;
        surnameTextField.font = [UIFont systemFontOfSize:15];
        surnameTextField.placeholder = @"ФАМИЛИЯ";
        surnameTextField.text = personInfo.lastName;
        surnameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        surnameTextField.keyboardType = UIKeyboardTypeDefault;
        surnameTextField.returnKeyType = UIReturnKeyDone;
        surnameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        surnameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        surnameTextField.delegate = self;
        surnameTextField.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
        [mainView addSubview:surnameTextField];
        
        nameTextField = [[WTReTextField alloc] initWithFrame:CGRectMake(10, surnameTextField.frame.origin.y + surnameTextField.frame.size.height + 2, 300, 30)];
        nameTextField.borderStyle = UITextBorderStyleRoundedRect;
        nameTextField.font = [UIFont systemFontOfSize:15];
        nameTextField.placeholder = @"ИМЯ";
        nameTextField.text = personInfo.name;
        nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        nameTextField.keyboardType = UIKeyboardTypeDefault;
        nameTextField.returnKeyType = UIReturnKeyDone;
        nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nameTextField.delegate = self;
        nameTextField.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
        [mainView addSubview:nameTextField];
        
        UILabel *asking = [[UILabel alloc] initWithFrame:CGRectMake(nameTextField.frame.origin.x, nameTextField.frame.origin.y + nameTextField.frame.size.height, 0, 0)];
        asking.text = @"  MR   MRS  CHD   INF";
        [asking sizeToFit];
        asking.backgroundColor = [UIColor clearColor];
        [mainView addSubview:asking];
        
        NSArray *itemArray = [NSArray arrayWithObjects: @"One", @"Two", @"Three", @"Four", nil];
        segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-man.png"] forSegmentAtIndex:0];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:1];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:2];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-baby.png"] forSegmentAtIndex:3];
        segmentedControl.frame = CGRectMake(surnameTextField.frame.origin.x, nameTextField.frame.origin.y + nameTextField.frame.size.height + 20, 180, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
        segmentedControl.selectedSegmentIndex = personInfo.personType;
        [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
        [mainView addSubview:segmentedControl];
        
        UILabel *passport = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x, segmentedControl.frame.origin.y + segmentedControl.frame.size.height, 0, 0)];
        passport.text = @"Серия и № паспорта";
        [passport sizeToFit];
        passport.backgroundColor = [UIColor clearColor];
        [mainView addSubview:passport];
        
        //2 TextField с разделенной чертой
        CAPassportTextField* _passportField = [[CAPassportTextField alloc]initWithFrame:CGRectMake(passport.frame.origin.x, passport.frame.origin.y + passport.frame.size.height + 2, segmentedControl.frame.size.width, 30) initPasportSerial:personInfo.passportSeries initPassportNumber:personInfo.passportNumber];
        //_passportField.tag = indexPath.section;
        _passportField.delegate = self;
        [mainView addSubview:_passportField];
        
        UILabel * dateBirth = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, asking.frame.origin.y, 0, 0)];
        dateBirth.text = @"Дата рождения";
        [dateBirth sizeToFit];
        dateBirth.backgroundColor = [UIColor clearColor];
        [mainView addSubview:dateBirth];
        
        UILabel * validity = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, passport.frame.origin.y, 0, 0)];
        validity.text = @"Срок действия";
        [validity sizeToFit];
        validity.backgroundColor = [UIColor clearColor];
        [mainView addSubview:validity];
        
        birthdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        birthdayButton.frame = CGRectMake(200, 110, 120, 30);
        [birthdayButton setTitle:[dateformatter stringFromDate:personInfo.birthDate] forState:UIControlStateNormal];
        [birthdayButton addTarget:self action:@selector(birthday:) forControlEvents:UIControlEventTouchUpInside];
        birthdayButton.tag = 1;
        [mainView addSubview:birthdayButton];
        
        validDayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        validDayButton.frame = CGRectMake(200, 160, birthdayButton.frame.size.width, 30);
        [validDayButton setTitle:[dateformatter stringFromDate:personInfo.validDate] forState:UIControlStateNormal];
        [validDayButton addTarget:self action:@selector(validDay:) forControlEvents:UIControlEventTouchUpInside];
        validDayButton.tag = 2;
        [mainView addSubview:validDayButton];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
                                 initWithTitle:@"Отмена"
                                 style:UIBarButtonItemStyleBordered
                                 target:self
                                 action:@selector(cancel)];
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Сохранить"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(confirm)];
    self.navigationItem.rightBarButtonItem = confirm;
    self.navigationItem.leftBarButtonItem = cancel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentedControl:(id)sender;
{
    [self.view endEditing:YES];
    personInfo.personType = segmentedControl.selectedSegmentIndex;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == surnameTextField) {
        personInfo.lastName = textField.text;
    }
    else if (textField == nameTextField) {
        personInfo.name = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark CAPassportTextFieldDelegate

-(void)activeTextFieldPassport:(UITextField*)activeTextFieldPassport
{
    
}

-(void)passportSeries:(UITextField *)textField;
{
    personInfo.passportSeries = textField.text;
}

-(void)passportNumber:(UITextField*)textField
{
    personInfo.passportNumber = textField.text;
}

-(void)birthday:(id)sender
{
    [self.view endEditing:YES];
    [self.view addSubview:pickerView];
    isPickerViewVisible = YES;
    [pickerView setDate:personInfo.birthDate];
    [pickerView indexCell:0 typeButton:birthday sender:sender];
}

-(void)validDay:(id)sender
{
    [self.view endEditing:YES];
    [self.view addSubview:pickerView];
    isPickerViewVisible = NO;
    [pickerView setDate:personInfo.validDate];
    [pickerView indexCell:0 typeButton:validDay sender:sender];
}

#pragma mark CABuyerPickerViewDelegate

- (void) cancelButtonPress
{
    [pickerView removeFromSuperview];
    isPickerViewVisible = NO;
}

- (void) acceptButtonPress
{
    [pickerView removeFromSuperview];
    isPickerViewVisible = NO;
}

- (void) datePickerDidSelectedDate:(NSDate*)selectedDate fieldId:(idField)fieldId indexCell:(NSInteger)indexCell sender:(id)sender
{
    if (fieldId == birthday)
    {
        personInfo.birthDate = selectedDate;
        [sender setTitle:[dateformatter stringFromDate:selectedDate] forState:UIControlStateNormal];
    }
    else if (fieldId == validDay)
    {
        personInfo.validDate = selectedDate;
        [sender setTitle:[dateformatter stringFromDate:selectedDate] forState:UIControlStateNormal];
    }
}

- (void)cancel
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

- (void)confirm
{
    [_delegate modified:personInfo index:indexCell];
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

@end
