//
//  CATicketsViewController.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 02/12/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CATicketsViewController.h"
#import "CAAssistView.h"
#import "CAAppDelegate.h"
#import "Offer.h"
#import "CAPassengersCountButton.h"
#import "CAOrderDetails.h"

@interface CATicketsViewController ()

@end

@implementation CATicketsViewController

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
    self.navigationItem.hidesBackButton = YES;
    NSString* assistText = @"Заказ №123456 \nСтатус: В листе ожидания \nМенеджер заказа: Василий Васильев";
    UIFont *font = [UIFont systemFontOfSize:14];
    CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:assistText font:font indentsBorder:5 background:YES];
    [self.view addSubview:assistView];
    
    Offer* offerdata = [Offer new];
    CAFlightPassengersCount* passengerdata = [CAFlightPassengersCount new];
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    offerdata = appDelegate.offer;
    passengerdata = appDelegate.passengersCount;

    CAOrderDetails* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offerdata passengers:passengerdata showPassengersView:YES];
    CGRect orderDetalsFrame = orderDetailsView.frame;
    orderDetalsFrame.origin.y = assistView.frame.origin.y + assistView.frame.size.height + 10;
    orderDetailsView.frame = orderDetalsFrame;
    [self.view addSubview:orderDetailsView];
    
    NSString* resultText = @"Ваш заказ отправлен на бронирование. Как только он будет подтвержден, вы сможете оплатить билет.";
    CAAssistView* resultView = [[CAAssistView alloc] initByAssistText:resultText font:font indentsBorder:5 background:NO];
    CGRect resultViewFrame = resultView.frame;
    resultViewFrame.origin.y = orderDetailsView.frame.origin.y + orderDetailsView.frame.size.height;
    resultView.frame = resultViewFrame;
    [self.view addSubview:resultView];
    
    UIButton* newFind = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [newFind setFrame:CGRectMake(20, resultView.frame.origin.y + resultView.frame.size.height + 100, 100, 30)];
    [newFind setFont:[UIFont systemFontOfSize:13]];
    [newFind setTitle:@"Новый поиск" forState:UIControlStateNormal];
    [newFind setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newFind addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newFind];
    
    UIButton* onPerson = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [onPerson setFrame:CGRectMake(newFind.frame.origin.x + newFind.frame.size.width + 50, newFind.frame.origin.y, 100, 30)];
    [onPerson setFont:[UIFont systemFontOfSize:13]];
    [onPerson setTitle:@"Все заказы" forState:UIControlStateNormal];
    [onPerson setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onPerson addTarget:self action:@selector(onPerson) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:onPerson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)onPerson
{
    NSInteger indexPage = 2;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openTab" object:[NSNumber numberWithInt:indexPage]];
}

@end
