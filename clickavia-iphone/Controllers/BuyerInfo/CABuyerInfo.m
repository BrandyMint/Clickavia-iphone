//
//  CABuyerInfo.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerInfo.h"
#import "CAColorSpecOffers.h"
#import "WTReTextField.h"
#import "PersonInfo.h"

#define HEIGHT_CELL 200

@interface CABuyerInfo ()
{
    NSMutableArray *buyerArray;
    NSString* passportSer;
    NSString* passportNum;
}
@property (strong, nonatomic) WTReTextField *surname;
@property (strong, nonatomic) WTReTextField *name;
@property (strong, nonatomic) WTReTextField *dateBirthday;
@property (strong, nonatomic) WTReTextField *validDay;
@property (nonatomic, retain) PersonInfo *personInfo;

@property (nonatomic, retain) PersonInfo *personInfoCard;
@end

@implementation CABuyerInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
    
    PersonInfo* myCard = [PersonInfo new];
    myCard.lastName = nil;
    myCard.name = nil;
    myCard.personType = male;
    myCard.birthDate = nil;
    myCard.validDate = nil;
    myCard.passportSeries = nil;
    myCard.passportNumber = nil;
    
    buyerArray = [NSMutableArray arrayWithObjects:myCard, nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)showNavBar
{
    UIImage *navBackImage = [UIImage imageNamed:@"toolbar-back-icon.png"];
    UIButton *navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBack setImage:navBackImage forState:UIControlStateNormal];
    navBack.frame = CGRectMake(0, 0, navBackImage.size.width, navBackImage.size.height);
    [navBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor COLOR_TITLE_TEXT];
    titleLabel.text = @"Пассажиры";
    titleLabel.layer.shadowOpacity = 0.4f;
    titleLabel.layer.shadowRadius = 0.0f;
    titleLabel.layer.shadowColor = [[UIColor COLOR_TITLE_TEXT_SHADOW] CGColor];
    titleLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [titleLabel sizeToFit];
    
    UIView* titleBarItemView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        titleLabel.frame.origin.x + titleLabel.frame.size.width,
                                                                        self.navigationController.navigationBar.frame.size.height/2)];
    [titleBarItemView addSubview:titleLabel];
    self.navigationItem.titleView = titleBarItemView;
    
    UIBarButtonItem *addCell =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTappedOnCell:)];
	self.navigationItem.rightBarButtonItem = addCell;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [buyerArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CELL;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        //если ячейка не найдена - создаем новую
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        UILabel *numberBuyer = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 0, 0)];
        //numberBuyer.text = [NSString stringWithFormat:@"%d",indexPath.section+1];
        numberBuyer.text = [NSString stringWithFormat:@"%d",indexPath.section+1];
        NSLog(@"%d",indexPath.section);
    
        [numberBuyer sizeToFit];
        numberBuyer.backgroundColor = [UIColor clearColor];
        [cell addSubview:numberBuyer];
        
        UIButton *onInfo = [UIButton buttonWithType:UIButtonTypeInfoLight];
        [onInfo addTarget:nil action:@selector(deleteTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        [onInfo setTitle:@"Delete" forState:UIControlStateNormal];
        onInfo.frame = CGRectMake(numberBuyer.frame.origin.x + numberBuyer.frame.size.width + 15, numberBuyer.frame.origin.y, 20, numberBuyer.frame.size.height);
        [cell addSubview:onInfo];
        
        UILabel *alreadyHave = [[UILabel alloc] initWithFrame:CGRectMake(onInfo.frame.origin.x + onInfo.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
        alreadyHave.text = @"Уже заполняли?";
        [alreadyHave sizeToFit];
        alreadyHave.backgroundColor = [UIColor clearColor];
        [cell addSubview:alreadyHave];
        
        UIButton *onDeleteCell = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [onDeleteCell addTarget:self action:@selector(deleteTappedOnCell:) forControlEvents:UIControlEventTouchUpInside];
        [onDeleteCell setTitle:@"Delete" forState:UIControlStateNormal];
        onDeleteCell.frame = CGRectMake(alreadyHave.frame.origin.x + alreadyHave.frame.size.width + 15, alreadyHave.frame.origin.y, 20, alreadyHave.frame.size.height);
        [cell addSubview:onDeleteCell];
        
        UILabel* delete = [[UILabel alloc] initWithFrame:CGRectMake(onDeleteCell.frame.origin.x + onDeleteCell.frame.size.width + 5, numberBuyer.frame.origin.y, 0, 0)];
        delete.text = @"Удалить";
        [delete sizeToFit];
        delete.backgroundColor = [UIColor clearColor];
        [cell addSubview:delete];
        
        _surname = [[WTReTextField alloc] initWithFrame:CGRectMake(10, numberBuyer.frame.origin.y + 23, 300, 30)];
        _surname.borderStyle = UITextBorderStyleRoundedRect;
        _surname.font = [UIFont systemFontOfSize:15];
        _surname.placeholder = @"ФАМИЛИЯ";
        _surname.autocorrectionType = UITextAutocorrectionTypeNo;
        _surname.keyboardType = UIKeyboardTypeDefault;
        _surname.returnKeyType = UIReturnKeyDone;
        _surname.clearButtonMode = UITextFieldViewModeWhileEditing;
        _surname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _surname.tag = indexPath.section;
        _surname.delegate = self;
        _surname.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
        [cell addSubview:_surname];
        
        _name = [[WTReTextField alloc] initWithFrame:CGRectMake(10, _surname.frame.origin.y + _surname.frame.size.height + 2, 300, 30)];
        _name.borderStyle = UITextBorderStyleRoundedRect;
        _name.font = [UIFont systemFontOfSize:15];
        _name.placeholder = @"ИМЯ";
        _name.autocorrectionType = UITextAutocorrectionTypeNo;
        _name.keyboardType = UIKeyboardTypeDefault;
        _name.returnKeyType = UIReturnKeyDone;
        _name.clearButtonMode = UITextFieldViewModeWhileEditing;
        _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _name.tag = indexPath.section;
        _name.delegate = self;
        _name.pattern = @"^[a-zA-Z а-яА-Я]{3,}$";
        [cell addSubview:_name];
        
        UILabel *asking = [[UILabel alloc] initWithFrame:CGRectMake(_name.frame.origin.x, _name.frame.origin.y + _name.frame.size.height, 0, 0)];
        asking.text = @"  MR   MRS  CHD   INF";
        [asking sizeToFit];
        asking.backgroundColor = [UIColor clearColor];
        [cell addSubview:asking];
        
        NSArray *itemArray = [NSArray arrayWithObjects: @"One", @"Two", @"Three", @"Four", nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-man.png"] forSegmentAtIndex:0];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:1];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-kid.png"] forSegmentAtIndex:2];
        [segmentedControl setImage:[UIImage imageNamed:@"passengers-icon-baby.png"] forSegmentAtIndex:3];
        segmentedControl.frame = CGRectMake(_surname.frame.origin.x, _name.frame.origin.y + _name.frame.size.height + 20, 180, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
        [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
        segmentedControl.tag = indexPath.section;
        [cell addSubview:segmentedControl];
        
        UILabel *passport = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x, segmentedControl.frame.origin.y + segmentedControl.frame.size.height, 0, 0)];
        passport.text = @"Серия и № паспорта";
        [passport sizeToFit];
        passport.backgroundColor = [UIColor clearColor];
        [cell addSubview:passport];

        _passportField = [[CAPassportTextField alloc]initWithFrame:CGRectMake(passport.frame.origin.x, passport.frame.origin.y + passport.frame.size.height + 2, segmentedControl.frame.size.width, 30)];
        _passportField.tag = indexPath.section;
        _passportField.delegate = self;
        [cell addSubview:_passportField];
        
        UILabel * dateBirth = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, asking.frame.origin.y, 0, 0)];
        dateBirth.text = @"Дата рождения";
        [dateBirth sizeToFit];
        dateBirth.backgroundColor = [UIColor clearColor];
        [cell addSubview:dateBirth];
        
        _dateBirthday = [[WTReTextField alloc] initWithFrame:CGRectMake(dateBirth.frame.origin.x, segmentedControl.frame.origin.y, 120, 30)];
        _dateBirthday.borderStyle = UITextBorderStyleRoundedRect;
        _dateBirthday.font = [UIFont systemFontOfSize:15];
        _dateBirthday.placeholder = @"10.10.1900";
        _dateBirthday.autocorrectionType = UITextAutocorrectionTypeNo;
        _dateBirthday.keyboardType = UIKeyboardTypeDefault;
        _dateBirthday.returnKeyType = UIReturnKeyDone;
        _dateBirthday.clearButtonMode = UITextFieldViewModeWhileEditing;
        _dateBirthday.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _dateBirthday.tag = indexPath.section;
        _dateBirthday.delegate = self;
        _dateBirthday.pattern = @"^(3[0-1]|[1-2][0-9]|(?:0)[1-9])(?:\\.)(1[0-2]|(?:0)[1-9])(?:\\.)[1-9][0-9]{3}$";
        [cell addSubview:_dateBirthday];
        
        UILabel * validity = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, passport.frame.origin.y, 0, 0)];
        validity.text = @"Срок действия";
        [validity sizeToFit];
        validity.backgroundColor = [UIColor clearColor];
        [cell addSubview:validity];
        
        _validDay = [[WTReTextField alloc] initWithFrame:CGRectMake(dateBirth.frame.origin.x, passport.frame.origin.y + passport.frame.size.height + 2, _dateBirthday.frame.size.width, 30)];
        _validDay.borderStyle = UITextBorderStyleRoundedRect;
        _validDay.font = [UIFont systemFontOfSize:15];
        _validDay.placeholder = @"10.10.1900";
        _validDay.autocorrectionType = UITextAutocorrectionTypeNo;
        _validDay.keyboardType = UIKeyboardTypeDefault;
        _validDay.returnKeyType = UIReturnKeyDone;
        _validDay.clearButtonMode = UITextFieldViewModeWhileEditing;
        _validDay.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _validDay.tag = indexPath.section;
        _validDay.delegate = self;
        _validDay.pattern = @"^(3[0-1]|[1-2][0-9]|(?:0)[1-9])(?:\\.)(1[0-2]|(?:0)[1-9])(?:\\.)[1-9][0-9]{3}$";
        [cell addSubview:_validDay];
        
        cell.backgroundColor = [UIColor grayColor];
	}
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)willShowKeyboard:(NSNotification*)notification
{
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.4];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height - keyboardFrame.size.height + 35);
    [UIView commitAnimations];
    
    //[_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)willHideKeyboard:(NSNotification*)notification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.2];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
    
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)deleteTappedOnCell:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    
    if (buyerArray.count > 1) {
        [buyerArray removeObjectAtIndex:indexPath.section];
        [_tableView beginUpdates];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:YES];
        [_tableView endUpdates];
        [_tableView reloadData];
    }
}

- (void)addTappedOnCell:(id)sender
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard.lastName = nil;
    personInfoCard.name = nil;
    personInfoCard.personType = male;
    personInfoCard.birthDate = nil;
    personInfoCard.validDate = nil;
    personInfoCard.passportSeries = nil;
    personInfoCard.passportNumber = nil;
    [buyerArray addObject:personInfoCard];
    [_tableView reloadData];
}

-(void) segmentedControl:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    [_surname resignFirstResponder];
    [_name resignFirstResponder];
    [_dateBirthday resignFirstResponder];
    [_validDay resignFirstResponder];
    
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:segmentedControl.tag];
    personInfoCard.personType = segmentedControl.selectedSegmentIndex;
    [self fullCard:segmentedControl.tag];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:textField.tag];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy"];
    
    if (textField == _surname) {
        personInfoCard.lastName = textField.text;
        NSLog(@"surname %@",textField.text);
    }
    if (textField == _name) {
        personInfoCard.name = textField.text;
        NSLog(@"name %@",textField.text);
    }
    if (textField == _dateBirthday) {
        personInfoCard.birthDate = [df dateFromString:textField.text];
        NSLog(@"birthday %@",textField.text);
    }
    if (textField == _validDay) {
        personInfoCard.validDate = [df dateFromString:textField.text];
        NSLog(@"validDay %@",textField.text);
    }
    [self fullCard:textField.tag];
}

-(void)passportSeries:(NSString*)passportSeries
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:_passportField.tag];
    personInfoCard.passportSeries = passportSeries;
    [self fullCard:_passportField.tag];
}

-(void)passportNumber:(NSString*)passportNumber
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:_passportField.tag];
    personInfoCard.passportNumber = passportNumber;
    [self fullCard:_passportField.tag];
}

-(BOOL) fullCard:(NSInteger)index
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:index];
    
    if (personInfoCard.lastName != nil && personInfoCard.name != nil && personInfoCard.birthDate != nil && personInfoCard.validDate != nil && personInfoCard.passportSeries != nil && personInfoCard.passportNumber != nil) {
        NSLog(@"%d карточка готова: %@ %@ - %@ %@",index+1, personInfoCard.lastName, personInfoCard.name, personInfoCard.birthDate, personInfoCard.validDate);
        return YES;
    }
    return NO;
}

@end
