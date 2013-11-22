//
//  CAAutorizedController.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 12/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAutorizedController.h"
#import "CAColorSpecOffers.h"
#import "CAAutorizedCell.h"
#import "CAPersonalViewController.h"

#define BUTTON_HEIGHT 30
#define BUTTON_WIDTH 80
#define HEIGHT_CELL_PASSENGER 130
#define BUTTON_PAYMENT_W 250
#define BUTTON_PAYMENT_H 40

@interface CAAutorizedController ()
{
    NSMutableArray *usersPassportsArray;
    User* user;
}

@end

@implementation CAAutorizedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(User* )_user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        user = _user;
        NSData *usersPassportsData = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"userPassports_%@",user.authKey]];
        usersPassportsArray = [NSKeyedUnarchiver unarchiveObjectWithData:usersPassportsData];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    UIButton* toPayment = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BUTTON_PAYMENT_W/2,
                                                                     self.view.frame.size.height - BUTTON_PAYMENT_H - 10,
                                                                     BUTTON_PAYMENT_W,
                                                                     BUTTON_PAYMENT_H)];
    toPayment.titleLabel.textAlignment = NSTextAlignmentCenter;
    [toPayment setTitle:@"Перейти к оплате" forState:UIControlStateNormal];
    [toPayment setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
    [toPayment addTarget:self action:@selector(onPayment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toPayment];
}

-(void) replaceUser:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
}

-(void)showNavBar
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor COLOR_TITLE_TEXT];
    titleLabel.text = @"Данные перелета";
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CAReplacePassportCardDelegate
- (void) modified:(PersonInfo*)modified index:(NSInteger)index
{
    [usersPassportsArray replaceObjectAtIndex:index withObject:modified];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:usersPassportsArray];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"userPassports_%@",user.authKey]];
    
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonInfo* personinfo = [PersonInfo new];
    personinfo = [usersPassportsArray objectAtIndex:indexPath.section];
    
    static NSString *CellIdentifier = @"Cell";
    
    CAAutorizedCell *cell = (CAAutorizedCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CAAutorizedCell"owner:self options:nil];
        cell = [nib objectAtIndex:0];
        [cell initCell:personinfo];
        
        UIButton *change = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        change.frame = CGRectMake(cell.frame.size.width - BUTTON_WIDTH - 10, 10, BUTTON_WIDTH, BUTTON_HEIGHT);
        [change addTarget:nil action:@selector(replacePassportCard:) forControlEvents:UIControlEventTouchUpInside];
        [change setTitle:@"Изменить" forState:UIControlStateNormal];
        [change setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        change.tag = indexPath.section;
        [cell addSubview: change];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}

-(void) replacePassportCard:(id)sender
{
    PersonInfo* personInfo = [PersonInfo new];
    personInfo = [usersPassportsArray objectAtIndex:[sender tag]];
    
    CAReplacePassportCard* replacePassportCard = [[CAReplacePassportCard alloc] initWithNibName:@"CAReplacePassportCard" bundle:nil personInfoCard:personInfo index:[sender tag]];
    replacePassportCard.delegate = self;
    [self.navigationController pushViewController:replacePassportCard animated:YES];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [usersPassportsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 60;
    }
    else
        return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView* userView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            0,
                                                            self.view.frame.size.width,
                                                            60)];
        userView.backgroundColor = [UIColor lightGrayColor];
        
        UIImageView* backgroundImage = [[UIImageView alloc] initWithFrame:userView.frame];
        backgroundImage.image = [[UIImage imageNamed:@"_bar-green-warm.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
        [userView addSubview:backgroundImage];
        
        UILabel* userLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
        userLabel.text = @"Пользователь";
        userLabel.font = [UIFont systemFontOfSize:14];
        [userLabel sizeToFit];
        userLabel.backgroundColor = [UIColor clearColor];
        
        UILabel* userName = [[UILabel alloc] initWithFrame:CGRectMake(userLabel.frame.origin.x,
                                                                      userLabel.frame.origin.y + [userLabel.text sizeWithFont:userLabel.font].height + 10, 0,0)];
        userName.text = user.name;
        userName.font = [UIFont systemFontOfSize:14];
        [userName sizeToFit];
        userName.backgroundColor = [UIColor clearColor];
        
        UIButton *replaceUser = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        replaceUser.frame = CGRectMake(userView.frame.size.width - BUTTON_WIDTH - 10, userView.frame.size.height/2 - BUTTON_HEIGHT/2, BUTTON_WIDTH, BUTTON_HEIGHT);
        [replaceUser addTarget:self action:@selector(replaceUser:) forControlEvents:UIControlEventTouchUpInside];
        [replaceUser setTitle:@"Сменить" forState:UIControlStateNormal];
        [replaceUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [userView addSubview: replaceUser];
        
        [userView addSubview:userLabel];
        [userView addSubview:userName];
        return userView;
    }
    return nil;
}

-(void)onPayment:(id)sender
{
    CAPersonalViewController* personalViewController = [[CAPersonalViewController alloc] initWithNibName:@"CAPersonalViewController" bundle:nil user:user];
    [self.navigationController pushViewController:personalViewController animated:YES];
}

@end
