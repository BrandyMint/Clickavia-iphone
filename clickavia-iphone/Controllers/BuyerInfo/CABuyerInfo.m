//
//  CABuyerInfo.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerInfo.h"
#import "CAColorSpecOffers.h"
#import "CAPassportTextField.h"
#import "LoginForm.h"
#import "AuthManager.h"

#define HEIGHT_CELL 200
#define KEYBOARD_ANIMATION_DURATION 0.3
#define MINIMUM_SCROLL_FRACTION 0.2
#define MAXIMUM_SCROLL_FRACTION 1.0
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT 162

@interface CABuyerInfo ()
{
    NSMutableArray *buyerArray;
    NSMutableArray *passportsAutorisedUsers;
    NSMutableArray* namesUsers;
    
    NSString* passportSer;
    NSString* passportNum;
    
    BOOL isPickerViewVisible;
    
    CABuyerPickerView* pickerView;
    FPPopoverController* popover;
    CGPoint alreadyHaveButtonPosition;
    NSInteger alreadyHaveButtonIndex;
    
    WYPopoverController* settingsPopoverController;
    
    CGRect alreadyHaveButtonFrame;
}

@property (strong, nonatomic) WTReTextField *surname;
@property (strong, nonatomic) WTReTextField *name;
@property (strong, nonatomic) WTReTextField *dateBirthday;
@property (strong, nonatomic) WTReTextField *validDay;
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
    isPickerViewVisible = NO;
    
    PersonInfo* myCard = [PersonInfo new];
    myCard.lastName = nil;
    myCard.name = nil;
    myCard.personType = male;
    myCard.birthDate = nil;
    myCard.validDate = nil;
    myCard.passportSeries = nil;
    myCard.passportNumber = nil;
    
    buyerArray = [NSMutableArray new];
    [buyerArray addObject:myCard];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    pickerView = [[CABuyerPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 220, 320, 220)];
    pickerView.delegate = self;
    [self readPassportsUsers];
    
    namesUsers = [[NSMutableArray alloc] initWithCapacity:6];
    
    for (int i = 0; i < passportsAutorisedUsers.count; i++) {
        PersonInfo*  personInfoCard = [PersonInfo new];
        personInfoCard = [passportsAutorisedUsers objectAtIndex:i];
        
        NSMutableString* fi = [NSMutableString new];
        [fi appendString:[NSString stringWithFormat:@"%@ ",personInfoCard.lastName]];
        [fi appendString:personInfoCard.name];
        [namesUsers addObject:fi];
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CABuyerInfoCell *cell = (CABuyerInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CABuyerInfoCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
    
        [cell initByIndex:indexPath.section];
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

-(void)willShowKeyboard:(NSNotification*)aNotification
{
    if (isPickerViewVisible) {
        isPickerViewVisible = NO;
        [pickerView removeFromSuperview];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height - PORTRAIT_KEYBOARD_HEIGHT + 35);
    [UIView commitAnimations];
}

-(void)willHideKeyboard:(NSNotification*)aNotification
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

#pragma mark Actions from cell
- (void)deleteTappedOnCell:(id)sender {
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    
    if (buyerArray.count > 1) {
        [buyerArray removeObjectAtIndex:indexPath.section];
        [_tableView beginUpdates];
        [_tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationTop];
        [_tableView endUpdates];
        [self performSelector:@selector(reloadTableView) withObject:self afterDelay:0.5 ];
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
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:buyerArray.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)reloadTableView
{
    [_tableView reloadData];
}

- (void)alreadyHave:(id)sender
{
    alreadyHaveButtonIndex = [sender tag];
    alreadyHaveButtonPosition = [sender convertPoint:CGPointZero toView:self.view];
    NSString* accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"accessToken"];
    
    if (accessToken == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Авторизуйтесь"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
        [alertView show];
    }
    else
    {
        [self showPopover:alreadyHaveButtonPosition];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        LoginForm* loginForm = [LoginForm new];
        loginForm.email = [alertView textFieldAtIndex:0].text;
        loginForm.password = [alertView textFieldAtIndex:1].text;
        
        AuthManager* authManager = [AuthManager new];
        [authManager getUser:loginForm completeBlock:^(User* user)
         {
             loginForm.accessToken = user.authKey;
             NSString* autorization = [NSString stringWithFormat:@"Имя: %@\n email: %@\n Номер телефона: %@\n token: %@",user.name, user.email, user.phoneNumber, user.authKey];
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Авторизиция прошла успешно" message:autorization delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alert show];
             [[NSUserDefaults standardUserDefaults] setObject:loginForm.accessToken forKey:@"accessToken"];
             //[self showPopover:alreadyHaveButtonPosition];
         }
                   failBlock:^(NSException* exception)
         {
             UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Проверьте ваш пароль или email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
             [alert show];
         }
         ];
    }
}

-(void)showPopover:(CGPoint)point
{
    float heightTableRow = 40;
    point.y -= 20;
    
    UIView* btn = [UIView new];
    CAPopoverList *popoverList = [[CAPopoverList alloc] initWithStyle:UITableViewStylePlain arrayValues:namesUsers];
    popoverList.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width, heightTableRow*namesUsers.count);
    popoverList.delegate = self;
    popoverList.title = @"Список паспортов";
    popoverList.modalInPopover = NO;
    [popoverList heightRow:heightTableRow];
    
    settingsPopoverController = [[WYPopoverController alloc] initWithContentViewController:popoverList];
    settingsPopoverController.delegate = self;
    settingsPopoverController.passthroughViews = @[btn];
    settingsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
    settingsPopoverController.wantsDefaultContentAppearance = NO;

    WYPopoverBackgroundView* popoverAppearance = [WYPopoverBackgroundView appearance];
    [popoverAppearance setOuterCornerRadius:5];
    [popoverAppearance setOuterStrokeColor:[UIColor blackColor]];
    [popoverAppearance setInnerCornerRadius:5];
    [popoverAppearance setInnerStrokeColor:[UIColor clearColor]];
    
    [popoverAppearance setBorderWidth:5];
    [popoverAppearance setArrowHeight:10];
    [popoverAppearance setArrowBase:20];
    
    [settingsPopoverController presentPopoverFromRect:CGRectMake(0, point.y, self.view.frame.size.width, heightTableRow*namesUsers.count)
                                               inView:self.view
                             permittedArrowDirections:WYPopoverArrowDirectionUp
                                             animated:YES
                                              options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark CAPopoverListDelegate
-(void)popoverListdidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [settingsPopoverController dismissPopoverAnimated:YES];
    settingsPopoverController.delegate = nil;
    settingsPopoverController = nil;
    
    PersonInfo* personInfo = [PersonInfo new];
    personInfo = [passportsAutorisedUsers objectAtIndex:indexPath.row];

    [buyerArray replaceObjectAtIndex:alreadyHaveButtonIndex withObject:personInfo];
    
    [_tableView reloadData];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CABuyerInfoCell *customCell = (CABuyerInfoCell*)cell;
    PersonInfo* personInfo = [PersonInfo new];
    
    personInfo = [buyerArray objectAtIndex:indexPath.section];
    
    NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
    [date_format setDateFormat: @"dd.MM.yyyy"];
    NSString * birthDateString = [date_format stringFromDate: personInfo.birthDate];
    NSString * validDateString = [date_format stringFromDate: personInfo.validDate];
    
    customCell.surnameTextField.text = personInfo.lastName;
    customCell.nameTextField.text = personInfo.name;
    customCell.segmentedControl.selectedSegmentIndex = personInfo.personType;
    [customCell setPassportSerial:personInfo.passportSeries];
    [customCell setPassportNumber:personInfo.passportNumber];
    
    if (personInfo.birthDate != nil) {
        [customCell setTitleButtonBirthday:birthDateString];
    }
    if (personInfo.validDate != nil) {
        [customCell setTitleButtonValidday:validDateString];
    }

    cell.backgroundColor = [UIColor clearColor];
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

- (void) datePickerDidSelectedDate:(NSDate*)selectedDate fieldId:(idField)fieldId indexCell:(NSInteger)indexCell sender:(id)sender;
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:indexCell];
    
    NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
    [date_format setDateFormat: @"dd.MM.yyyy"];
    NSString * date_string = [date_format stringFromDate: selectedDate];
    
    if (fieldId == birthday)
    {
        personInfoCard.birthDate = selectedDate;
        [sender setTitle:date_string forState:UIControlStateNormal];
    }
    else
    {
        personInfoCard.validDate = selectedDate;
        [sender setTitle:date_string forState:UIControlStateNormal];
    }
    [self fullCard:indexCell];
}

#pragma mark CABuyerInfoCellDelegate

-(void)birthday:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    [pickerView indexCell:indexPath.section typeButton:birthday sender:sender];
    [self.view addSubview:pickerView];
    isPickerViewVisible = YES;
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    [_tableView endEditing:YES];
}

-(void)validDay:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    [pickerView indexCell:indexPath.section typeButton:validDay sender:sender];
    [self.view addSubview:pickerView];
    isPickerViewVisible = YES;
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    [_tableView endEditing:YES];
}

-(void)activeTextField:(UITextField*)activeTextField indexCell:(NSInteger)indexCell
{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexCell] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

-(void)tableViewCell:(UITableViewCell* )tableViewCell textDidEndEditing:(NSString *)text fieldId:(idField)fieldId indexCell:(NSInteger)indexCell sender:(id)sender;
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:indexCell];
    
    switch (fieldId) {
        case lastname:
            personInfoCard.lastName = text;
            break;
        case name:
            personInfoCard.name = text;
            break;
        case passportSeries:
            personInfoCard.passportSeries = text;
            break;
        case passportNumber:
            personInfoCard.passportNumber = text;
            break;
        default:
            break;
    }
    [self fullCard:indexCell];
}

-(void)tableViewCell:(UITableViewCell* )tableViewCell segmentedControlId:(idField)segmentedControlId indexCell:(NSInteger)indexCell
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:indexCell];
    personInfoCard.personType = segmentedControlId;
    [self fullCard:indexCell];
}

-(void) fullCard:(NSInteger)indexCell
{
    PersonInfo*  personInfoCard = [PersonInfo new];
    personInfoCard = [buyerArray objectAtIndex:indexCell];
    
    if (personInfoCard.lastName != nil && personInfoCard.name != nil && personInfoCard.birthDate != nil && personInfoCard.validDate != nil && personInfoCard.passportSeries != nil && personInfoCard.passportNumber != nil) {
        
        NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
        [date_format setDateFormat: @"dd.MM.yyyy"];
        NSString * birthDate = [date_format stringFromDate: personInfoCard.birthDate];
        NSString * validDate = [date_format stringFromDate: personInfoCard.validDate];
        NSString * personType = [NSString new];
        
        switch (personInfoCard.personType) {
            case male:
                personType = @"male";
                break;
            case female:
                personType = @"female";
                break;
            case children:
                personType = @"children";
                break;
            case infant:
                personType = @"infant";
                break;
            default:
                break;
        }
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%d карточка заполнна",indexCell+1]
                                                        message:[NSString stringWithFormat:@"Имя: %@\n Фамилия: %@\n Серия паспорта: %@\n Номер паспорта: %@\n Дата рождения: %@\n Срок действия: %@\n Тип пассажира: %@",personInfoCard.lastName, personInfoCard.name, personInfoCard.passportSeries, personInfoCard.passportNumber, birthDate, validDate, personType]
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
        //Массив с заполненными карточками кодируется в NSData
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:buyerArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UsersPassports"];
    }
}

-(void)readPassportsUsers
{
    //Массив в формате NSData раскодируется в обычный массив с моделями PersonInfo
    NSData *notesData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersPassports"];
    passportsAutorisedUsers = [NSKeyedUnarchiver unarchiveObjectWithData:notesData];
}

#pragma mark CAPaymentTableViewDelegate

- (void) didSelectRowAtIndexPath:(NSIndexPath *)indexPath currentPayment:(NSString*)currentPayment;
{
    NSLog(@"выбран %d %@", indexPath.row ,currentPayment);
}

@end
