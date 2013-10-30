//
//  CABuyerInfo.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 29/10/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CABuyerInfo.h"
#import "CAColorSpecOffers.h"

@interface CABuyerInfo ()
{
    NSMutableArray *buyerArray;
}
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
    
    buyerArray = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", nil];
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


-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    //label.text = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    switch ([segmentedControl selectedSegmentIndex]) {
        case 0:
            NSLog(@"1 пассажир");
            break;
        case 1:
            NSLog(@"2 пассажир");
            break;
        case 2:
            NSLog(@"3 пассажир");
            break;
        case 3:
            NSLog(@"4 пассажир");
            break;
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (textField.tag) {
        case 0:
            if ([textField.text length] > 100) {
                return NO;
            }
            break;
        case 1:
            if ([textField.text length] > 100) {
                return NO;
            }
            break;
        case 2:
            if ([textField.text length] > 9) {
                return NO;
            }
            break;
        case 3:
            if ([textField.text length] > 7) {
                return NO;
            }
            break;
        case 4:
            if ([textField.text length] > 7) {
                return NO;
            }
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (void)editing {
    //[self.tableView setEditing:!self.tableView.editing animated:YES];
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
    return 200;
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
        numberBuyer.text = [buyerArray objectAtIndex:indexPath.section];
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
        
        UITextField* surname = [[UITextField alloc] initWithFrame:CGRectMake(10, numberBuyer.frame.origin.y + 23, 300, 30)];
        surname.borderStyle = UITextBorderStyleRoundedRect;
        surname.font = [UIFont systemFontOfSize:15];
        surname.placeholder = @"ФАМИЛИЯ";
        surname.autocorrectionType = UITextAutocorrectionTypeNo;
        surname.keyboardType = UIKeyboardTypeDefault;
        surname.returnKeyType = UIReturnKeyDone;
        surname.clearButtonMode = UITextFieldViewModeWhileEditing;
        surname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        surname.tag = 0;
        surname.delegate = self;
        [cell addSubview:surname];
        
        UITextField* name = [[UITextField alloc] initWithFrame:CGRectMake(10, surname.frame.origin.y + surname.frame.size.height + 2, 300, 30)];
        name.borderStyle = UITextBorderStyleRoundedRect;
        name.font = [UIFont systemFontOfSize:15];
        name.placeholder = @"ИМЯ";
        name.autocorrectionType = UITextAutocorrectionTypeNo;
        name.keyboardType = UIKeyboardTypeDefault;
        name.returnKeyType = UIReturnKeyDone;
        name.clearButtonMode = UITextFieldViewModeWhileEditing;
        name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        name.tag = 1;
        name.delegate = self;
        [cell addSubview:name];
        
        UILabel *asking = [[UILabel alloc] initWithFrame:CGRectMake(name.frame.origin.x, name.frame.origin.y + name.frame.size.height, 0, 0)];
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
        segmentedControl.frame = CGRectMake(surname.frame.origin.x, name.frame.origin.y + name.frame.size.height + 20, 180, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
        [segmentedControl addTarget:self action:@selector(pickOne:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:segmentedControl];
        
        UILabel *passport = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x, segmentedControl.frame.origin.y + segmentedControl.frame.size.height, 0, 0)];
        passport.text = @"Серия и № паспорта";
        [passport sizeToFit];
        passport.backgroundColor = [UIColor clearColor];
        [cell addSubview:passport];
        
        UITextField* passportField = [[UITextField alloc] initWithFrame:CGRectMake(passport.frame.origin.x, passport.frame.origin.y + passport.frame.size.height + 2, segmentedControl.frame.size.width, 30)];
        passportField.borderStyle = UITextBorderStyleRoundedRect;
        passportField.font = [UIFont systemFontOfSize:15];
        passportField.placeholder = @"9708 777888";
        passportField.autocorrectionType = UITextAutocorrectionTypeNo;
        passportField.keyboardType = UIKeyboardTypeDefault;
        passportField.returnKeyType = UIReturnKeyDone;
        passportField.clearButtonMode = UITextFieldViewModeWhileEditing;
        passportField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passportField.tag = 2;
        passportField.delegate = self;
        [cell addSubview:passportField];
        
        UILabel * dateBirth = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, asking.frame.origin.y, 0, 0)];
        dateBirth.text = @"Дата рождения";
        [dateBirth sizeToFit];
        dateBirth.backgroundColor = [UIColor clearColor];
        [cell addSubview:dateBirth];
        
        UITextField* dateBirthField = [[UITextField alloc] initWithFrame:CGRectMake(dateBirth.frame.origin.x, segmentedControl.frame.origin.y, 120, 30)];
        dateBirthField.borderStyle = UITextBorderStyleRoundedRect;
        dateBirthField.font = [UIFont systemFontOfSize:15];
        dateBirthField.placeholder = @"10.10.1900";
        dateBirthField.autocorrectionType = UITextAutocorrectionTypeNo;
        dateBirthField.keyboardType = UIKeyboardTypeDefault;
        dateBirthField.returnKeyType = UIReturnKeyDone;
        dateBirthField.clearButtonMode = UITextFieldViewModeWhileEditing;
        dateBirthField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        dateBirthField.tag = 3;
        dateBirthField.delegate = self;
        [cell addSubview:dateBirthField];
        
        UILabel * validity = [[UILabel alloc] initWithFrame:CGRectMake(segmentedControl.frame.origin.x + segmentedControl.frame.size.width + 5, passport.frame.origin.y, 0, 0)];
        validity.text = @"Срок действия";
        [validity sizeToFit];
        validity.backgroundColor = [UIColor clearColor];
        [cell addSubview:validity];
        
        UITextField* validityField = [[UITextField alloc] initWithFrame:CGRectMake(dateBirth.frame.origin.x, passportField.frame.origin.y, dateBirthField.frame.size.width, 30)];
        validityField.borderStyle = UITextBorderStyleRoundedRect;
        validityField.font = [UIFont systemFontOfSize:15];
        validityField.placeholder = @"10.10.1900";
        validityField.autocorrectionType = UITextAutocorrectionTypeNo;
        validityField.keyboardType = UIKeyboardTypeDefault;
        validityField.returnKeyType = UIReturnKeyDone;
        validityField.clearButtonMode = UITextFieldViewModeWhileEditing;
        validityField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        validityField.tag = 4;
        validityField.delegate = self;
        [cell addSubview:validityField];
        
        cell.backgroundColor = [UIColor grayColor];
	}
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
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
    UITableViewCell *newCell = [[UITableViewCell alloc] init];
    [buyerArray addObject:newCell];
    [_tableView reloadData];
}

@end
