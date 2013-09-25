//
//  CAFlightDataView.m
//  clickavia-iphone
//
//  Created by bespalown on 9/23/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAFlightDataView.h"
#import "CAAssistView.h"
#import "CAOrderDetails.h"
#import "CAColorSpecOffers.h"
#import "CAPassengersCountButton.h"

@interface CAFlightDataView ()

@end

@implementation CAFlightDataView
{
    Offer* offerdata;
    CAFlightPassengersCount* passengersCount;
    CAPassengersCountButton *passengerCountButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengers:(CAFlightPassengersCount*)passengers
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offerdata = [[Offer alloc] init];
        offerdata = offer;
        passengersCount = [[CAFlightPassengersCount alloc] init];
        passengersCount = passengers;
        
        NSLog(@"/*|sss special: %d, momentary: %d", offerdata.isSpecial, offerdata.isMomentaryConfirmation);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
    
    UIView* assistView = [[CAAssistView alloc] initByAssistText:@"Atlassian's Git Tutorial provides an approachable introduction to Git revision control by not only explaining fundamental rkflow. " font:[UIFont fontWithName:@"HelveticaNeue" size:12] indentsBorder:5];
    [self.view addSubview:assistView];
    
    UIButton* passengersButton = [[CAPassengersCountButton alloc] init];
    CGRect passengersButtonFrame = passengersButton.frame;
    passengersButtonFrame.origin.x = 50;
    passengersButtonFrame.origin.y = assistView.frame.origin.y + assistView.frame.size.height + 20;
    passengersButton.frame = passengersButtonFrame;
    passengersButton.backgroundColor = [UIColor lightGrayColor];
    //[passengersButton setimageForAdults:[UIImage imageNamed:@"toolbar-back-icon.png"]];
    [self.view addSubview:passengersButton];
    
    UIView* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offerdata passengers:passengersCount];
    CGRect orderDetalsFrame = orderDetailsView.frame;
    orderDetalsFrame.origin.y = passengersButton.frame.origin.y + passengersButton.frame.size.height + 50;
    orderDetailsView.frame = orderDetalsFrame;
    orderDetailsView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orderDetailsView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    offerdata = passengersCount = nil;
}

@end
