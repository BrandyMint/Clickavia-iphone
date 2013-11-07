//
//  CABuyerInfo.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerInfo.h"
#import "CAColorSpecOffers.h"

#define HEIGHT_CELL 200
#define KEYBOARD_ANIMATION_DURATION 0.3
#define MINIMUM_SCROLL_FRACTION 0.2
#define MAXIMUM_SCROLL_FRACTION 1.0
#define PORTRAIT_KEYBOARD_HEIGHT 216
#define LANDSCAPE_KEYBOARD_HEIGHT 162

@interface CABuyerInfo ()
{
    NSMutableArray *buyerArray;
    NSString* passportSer;
    NSString* passportNum;
    CGFloat  animatedDistance;
    NSInteger tagForCell;
    CABuyerPickerView* pickerView;
    BOOL isPickerViewVisible;
    
    NSString* myString;
}

@property (nonatomic, retain) NSMutableArray* mut;
@property (nonatomic, retain) UIButton* birthdayButton;
@property (nonatomic, retain) UIButton* validDayButton;
@property (strong, nonatomic) WTReTextField *surname;
@property (strong, nonatomic) WTReTextField *name;
@property (strong, nonatomic) WTReTextField *dateBirthday;
@property (strong, nonatomic) WTReTextField *validDay;
@property (nonatomic, retain) PersonInfo *personInfo;

@property (nonatomic, retain) PersonInfo *personInfoCard;
@end

@implementation CABuyerInfo
@synthesize validDayButton, birthdayButton;
@synthesize testArray;

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
    

    
    myString = @"I am!";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)viewDidAppear:(BOOL)animated
{
    pickerView = [[CABuyerPickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 220, 320, 220)];
    pickerView.delegate = self;
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
    
    CABuyerInfoCell *cell = (CABuyerInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CABuyerInfoCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        birthdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        birthdayButton.frame = CGRectMake(200, 110, 120, 30);
        [birthdayButton setTitle:@"10.10.1900" forState:UIControlStateNormal];
        [birthdayButton addTarget:self action:@selector(birthday:) forControlEvents:UIControlEventTouchUpInside];
        birthdayButton.tag = 1;
        [cell addSubview:birthdayButton];
        
        validDayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        validDayButton.frame = CGRectMake(200, 160, birthdayButton.frame.size.width, 30);
        [validDayButton setTitle:@"10.10.1900" forState:UIControlStateNormal];
        [validDayButton addTarget:self action:@selector(validDay:) forControlEvents:UIControlEventTouchUpInside];
        validDayButton.tag = 2;
        [cell addSubview:validDayButton];
        
        cell.delegate = self;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)willShowKeyboard:(NSNotification*)aNotification
{
    if (isPickerViewVisible) {
        isPickerViewVisible = NO;
        [pickerView removeFromSuperview];
    }
}

-(void)birthday:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    [pickerView indexCell:indexPath.section typeButton:birthday sender:sender];
    [self.view addSubview:pickerView];
    isPickerViewVisible = YES;
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)validDay:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:_tableView];
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:buttonPosition];
    [pickerView indexCell:indexPath.section typeButton:validDay sender:sender];
    [self.view addSubview:pickerView];
    isPickerViewVisible = YES;
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CABuyerInfoCell *customCell = (CABuyerInfoCell*)cell;
    [customCell initByIndex:indexPath.section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
        NSLog(@"delete %d %@", buyerArray.count, buyerArray);
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
    NSLog(@"add %d %@", buyerArray.count, buyerArray);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height - PORTRAIT_KEYBOARD_HEIGHT + 35);
    [UIView commitAnimations];
    
    CGRect textFieldRect = [_tableView.window convertRect:textField.bounds fromView:textField];
    CGFloat midline = _tableView.frame.origin.y + 0.5*_tableView.frame.size.height;
    
    if (tagForCell != textField.tag) {
        tagForCell = textField.tag;
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:textField.tag] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    _tableView.frame = CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (void) cancelButtonPress
{
    NSLog(@"cancelButtonPress");
    [pickerView removeFromSuperview];
    isPickerViewVisible = NO;
    NSLog(@"%@",myString);
}

- (void) acceptButtonPress
{
    NSLog(@"acceptlButtonPress");
    [pickerView removeFromSuperview];
    isPickerViewVisible = NO;
}

- (void) dateFromPicker:(NSDate*)date
{
    
}
#pragma mark CABuyerInfoCellDelegate

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
    }
}

@end
