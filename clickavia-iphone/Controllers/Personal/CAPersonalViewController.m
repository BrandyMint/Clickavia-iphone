//
//  CAPersonalViewController.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 21/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPersonalViewController.h"
#import "CAColorSpecOffers.h"
#import "ChatViewController.h"
#import "MessageReceiver.h"
#import "CAAssistView.h"
#import "CAPersonalLaterViewController.h"

#import "SpecialOfferCell.h"
#import "CAFlightPassengersCount.h"
#import "CAAppDelegate.h"
#import "Offer.h"

@interface CAPersonalViewController ()
{
    BOOL isCurrentOrders;
    
    UISegmentedControl* segmentedControl;
    NSArray* person;
    NSArray* currentOrder;
    NSArray* archiveOrder;
    
    NSArray* orderNumber;
    NSMutableArray* currentOrderNumber;
    NSMutableArray* archiveOrderNumber;
    NSMutableArray* passangersArray;
    NSMutableArray* specialOfferArray;
    SpecialOffer* specialoffer;
    CAFlightPassengersCount* passenger;
    Offer* offer;
}
@property (nonatomic, strong) ChatViewController *chatViewController;
@property (strong, nonatomic) MessageReceiver *message_reciever;
@end

@implementation CAPersonalViewController

-(void)baseData
{
    currentOrder = [NSArray arrayWithObjects:@"first", @"second", @"third", @"fourth", @"fifth", nil];
    archiveOrder = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
    passenger = [CAFlightPassengersCount new];
    specialoffer = [SpecialOffer new];
    offer = [Offer new];
    
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    passenger = appDelegate.passengersCount;
    specialoffer = appDelegate.specialOffer;
    offer = appDelegate.offer;
    
    currentOrderNumber = [NSMutableArray new];
    passangersArray = [NSMutableArray new];
    specialOfferArray = [NSMutableArray new];
    for (int i=0; i< currentOrder.count; i++) {
        NSUInteger r = arc4random_uniform(999999) + 100000;
        [currentOrderNumber addObject:[NSNumber numberWithInteger:r]];
        [passangersArray addObject:passenger];
        [specialOfferArray addObject:specialoffer];
    }
    
    archiveOrderNumber = [NSMutableArray new];
    for (int i=0; i< archiveOrder.count; i++) {
        NSUInteger r = arc4random_uniform(999999) + 100000;
        [archiveOrderNumber addObject:[NSNumber numberWithInteger:r]];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(User *)_user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self showNavBar];
        [self baseData];
        User* user = [User new];
        user = _user;
        NSString* text = [NSString stringWithFormat:@"%@\n%@\n%@",user.name, user.email, user.phoneNumber];
        UIFont *font = [UIFont systemFontOfSize:14];
        CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:text font:font indentsBorder:5 background:YES];
        [self.view addSubview:assistView];
        
        UIButton *replaceUser = [UIButton buttonWithType:UIButtonTypeInfoDark];
        [replaceUser addTarget:nil action:@selector(replaceUser) forControlEvents:UIControlEventTouchUpInside];
        replaceUser.frame = CGRectMake(assistView.frame.size.width - 60, assistView.frame.size.height/2 - 15, 30, 30);
        [assistView addSubview:replaceUser];
        
        NSArray *itemArray = [NSArray arrayWithObjects: [NSString stringWithFormat:@"Текущие заказы %d", [currentOrder count]],
                                                        [NSString stringWithFormat:@"Архив заказов %d", [archiveOrder count]], nil];
        segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
        segmentedControl.frame = CGRectMake(10, assistView.frame.origin.y + assistView.frame.size.height + 10, 300, 30);
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
        segmentedControl.selectedSegmentIndex = 0;
        isCurrentOrders = YES;
        [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        
        person = currentOrder;
        orderNumber = currentOrderNumber;
    }
    return self;
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
    titleLabel.text = @"Личный кабинет";
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
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)segmentedControl:(id)sender
{
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            orderNumber = currentOrderNumber;
            person = currentOrder;
            isCurrentOrders = YES;
            break;
        case 1:
            orderNumber = archiveOrderNumber;
            person = archiveOrder;
            isCurrentOrders = NO;
            break;
        default:
            break;
    }
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isCurrentOrders) {
        return 170;
    }
    return 125;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [person count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CAPersonCell *cell = (CAPersonCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CAPersonCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.delegate = self;
        SpecialOffer* special = [SpecialOffer new];
        special = [specialOfferArray objectAtIndex:indexPath.section];
        CAFlightPassengersCount* passengers = [CAFlightPassengersCount new];
        passengers = [passangersArray objectAtIndex:indexPath.section];
        
        [cell orderNumber:[[orderNumber objectAtIndex:indexPath.section] integerValue] specialOffer:special passengers:passengers];
        
        cell.orderNumber.text = [NSString stringWithFormat:@"Заказ № %@", [orderNumber objectAtIndex:indexPath.section]];
        cell.confirm.text = @"оплачен ";
        cell.detail.text = @"подробнее >";
	}

    //cell.name.text = [person objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CAPersonCell *customCell = [[CAPersonCell alloc] initWithCell];
    //customCell.mylabel.text = [person objectAtIndex:indexPath.section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CAPersonalLaterViewController* personalLaterViewController = [[CAPersonalLaterViewController alloc]
                                                                  initWithNibName:@"CAPersonalLaterViewController"
                                                                  bundle:Nil
                                                                  status:@"оплачено"
                                                                  manager:@"Василий Васильев"
                                                                  numberOrder:[[orderNumber objectAtIndex:indexPath.section] integerValue]
                                                                  offer:offer
                                                                  passenger:passenger
                                                                  isCurrentOrders:isCurrentOrders];
    [self.navigationController pushViewController:personalLaterViewController animated:YES];
}

#pragma mark CAPersonCellDelegate
-(void)didselectTellManager:(NSInteger)numberOrder
{
    UIImage *remoteAvatar = [UIImage imageNamed:@"local.png"];
    _message_reciever = [MessageReceiver new];
    _chatViewController = [[ChatViewController alloc] initBMChatViewController: _message_reciever localName:@"Gagа" localAvatar:remoteAvatar];
    _message_reciever.bmChatViewController = _chatViewController;
    [_chatViewController title:[NSString stringWithFormat:@"Заказ №%d",numberOrder]];
    [self.navigationController pushViewController:_chatViewController animated:YES];
}

-(void)replaceUser
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"accessToken"];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

@end
