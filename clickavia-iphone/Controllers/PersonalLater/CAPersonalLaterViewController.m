//
//  CAPersonalLaterViewController.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 22/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPersonalLaterViewController.h"
#import "CAColorSpecOffers.h"
#import "CAAssistView.h"
#import "CAOrderDetails.h"
#import "ChatViewController.h"
#import "MessageReceiver.h"

#define BUTTON_W 250
#define BUTTON_H 40

@interface CAPersonalLaterViewController ()
{
    NSInteger numberOrder;
    NSString* name;
    Offer* offer;
    CAFlightPassengersCount* passenger;
}
@property (nonatomic, strong) ChatViewController *chatViewController;
@property (strong, nonatomic) MessageReceiver *message_reciever;
@end

@implementation CAPersonalLaterViewController

-(id)initWithNibName:(NSString *)nibNameOrNil
              bundle:(NSBundle *)nibBundleOrNil
              status:(NSString*)status
             manager:(NSString*)manager
            userName:(NSString*)userName
         numberOrder:(NSInteger)_numberOrder
               offer:(Offer *)_offer
           passenger:(CAFlightPassengersCount *)_passenger
           isCurrentOrders:(BOOL)isCurrentOrders;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offer = [Offer new];
        offer = _offer;
        passenger = [CAFlightPassengersCount new];
        passenger = _passenger;
        name = userName;
        
        numberOrder = _numberOrder;
        [self showNavBar];
        NSString* text = [NSString stringWithFormat:@"Статус: %@\nМенеджер заказа: %@",status, manager];
        UIFont *font = [UIFont systemFontOfSize:14];
        CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:text font:font indentsBorder:5 background:YES];
        [self.view addSubview:assistView];
        
        CAOrderDetails* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offer passengers:passenger showPassengersView:YES];
        CGRect orderDetalsFrame = orderDetailsView.frame;
        orderDetalsFrame.origin.y = assistView.frame.origin.y + assistView.frame.size.height + 10;
        orderDetailsView.frame = orderDetalsFrame;
        [self.view addSubview:orderDetailsView];
        
        if (isCurrentOrders) {
            UIButton* enter = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BUTTON_W/2,
                                                                         self.view.frame.size.height - 200,
                                                                         BUTTON_W,
                                                                         BUTTON_H)];
            enter.titleLabel.textAlignment = NSTextAlignmentCenter;
            [enter setTitle:@"Связаться с менеджером" forState:UIControlStateNormal];
            enter.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            enter.titleLabel.textAlignment = NSTextAlignmentCenter;
            enter.titleLabel.font = [UIFont systemFontOfSize:13];
            [enter setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
            [enter addTarget:self action:@selector(openChat:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:enter];
        }

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
    titleLabel.text = [NSString stringWithFormat:@"Заказ № %d",numberOrder];
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

-(void)openChat:(id)sender
{
    UIImage *remoteAvatar = [UIImage imageNamed:@"local.png"];
    _message_reciever = [[MessageReceiver alloc] initWithNameManager:@"Василий Васильев"];
    _chatViewController = [[ChatViewController alloc] initBMChatViewController: _message_reciever localName:name localAvatar:remoteAvatar];
    _message_reciever.bmChatViewController = _chatViewController;
    [_chatViewController title:[NSString stringWithFormat:@"Заказ №%d",numberOrder]];
    [self.navigationController pushViewController:_chatViewController animated:YES];
}

@end
