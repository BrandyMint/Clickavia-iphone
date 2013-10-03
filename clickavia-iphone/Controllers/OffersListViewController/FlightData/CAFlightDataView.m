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
#import "CAPassengersCountButton.h"

#define Y_OFFSET 5
#define X_OFFSET 5

@interface CAFlightDataView ()

@end

@implementation CAFlightDataView
{
    Offer* offerdata;

    CAFlightPassengersCount *flightPAssengersCount;
    
    CASearchFormPickerView *passengerCountPicker;
    CAPassengersCountButton *passengerCountButton;
    
    BOOL isShowPassengersCountPicker;
    BOOL isShowClassSelectorPopover;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengers:(CAFlightPassengersCount*)passengers
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offerdata = [[Offer alloc] init];
        offerdata = offer;
        flightPAssengersCount = [[CAFlightPassengersCount alloc] init];
        flightPAssengersCount = passengers;
        
        NSLog(@"CAFlightPassengersCount %d %d %d", flightPAssengersCount.adultsCount, flightPAssengersCount.childrenCount, flightPAssengersCount.infantsCount);
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
    
    UILabel* passengersLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, assistView.frame.origin.y + assistView.frame.size.height + Y_OFFSET, 0, 0)];
    passengersLabel.text = @"Пассажиры";
    passengersLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [passengersLabel sizeToFit];
    [self.view addSubview:passengersLabel];
    
    passengerCountButton = [[CAPassengersCountButton alloc] initWithFrame:CGRectMake(passengersLabel.frame.origin.x-X_OFFSET, passengersLabel.frame.origin.y + passengersLabel.frame.size.height + Y_OFFSET, self.view.frame.size.width/3 - X_OFFSET, 25)];
    [passengerCountButton addTarget:self action:@selector(passengerCountButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [passengerCountButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview: passengerCountButton];
    [passengerCountButton setImageForAdults:[UIImage imageNamed:@"passengers-icon-man.png"]];
    [passengerCountButton setImageForChildren:[UIImage imageNamed:@"passengers-icon-kid.png"]];
    [passengerCountButton setImageForInfants:[UIImage imageNamed:@"passengers-icon-baby.png"]];
    
    UIButton* onPaymentMethod = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3 + X_OFFSET, passengerCountButton.frame.origin.y,  self.view.frame.size.width*2/3 - 2*X_OFFSET, 25)];
    [onPaymentMethod addTarget:self action:@selector(classSelectButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [onPaymentMethod setTitle:@"MasterCard или Visa" forState:UIControlStateNormal];
    [onPaymentMethod.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [onPaymentMethod setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [onPaymentMethod setBackgroundColor:[UIColor lightGrayColor]];
    [onPaymentMethod setBackgroundImage:[UIImage imageNamed:@"CASearchFormControls-button.png"] forState:UIControlStateNormal];
    [self.view addSubview: onPaymentMethod];
    
    UILabel* paymentMethod = [[UILabel alloc] initWithFrame:CGRectMake(onPaymentMethod.frame.origin.x + X_OFFSET, passengersLabel.frame.origin.y, 0, 0)];
    paymentMethod.text = @"Способ оплаты";
    paymentMethod.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [paymentMethod sizeToFit];
    [self.view addSubview:paymentMethod];
    
    UIView* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offerdata passengers:flightPAssengersCount];
    CGRect orderDetalsFrame = orderDetailsView.frame;
    orderDetalsFrame.origin.y = passengerCountButton.frame.origin.y + passengerCountButton.frame.size.height + Y_OFFSET;
    orderDetailsView.frame = orderDetalsFrame;
    [self.view addSubview:orderDetailsView];
    
    
    ////
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
    passengerCountPicker = [[CASearchFormPickerView alloc]initWithFrame:CGRectMake(0, 270, 320, 200)];
    passengerCountPicker.delegate = self;
}

- (IBAction) passengerCountButtonPress: (id) sender {
    NSLog(@"passengers");
    //[_delegate searchFormControlsViewOpenPassengerCountPicker:self];

    [self.view addSubview: passengerCountPicker];
}

- (IBAction) classSelectButtonPress: (id) sender {
    NSLog(@"payment");
    //[_delegate searchFormControlsViewOpenClassSelection:self];
    [passengerCountPicker removeFromSuperview];
}

- (void) showPassengersCountPicker
{
    isShowPassengersCountPicker = YES;
    
    passengerCountPicker.frame = CGRectMake(0, 320, 320, 200);
    [self.view addSubview: passengerCountPicker];
    [self.view setUserInteractionEnabled:NO];
}

- (void) hidePassengersCountPicker
{
    [passengerCountPicker removeFromSuperview];
    isShowPassengersCountPicker = NO;
    [self.view setUserInteractionEnabled:YES];
}

#pragma mark PickerViewDelegate

- (void) searchFormPickerView:(CASearchFormPickerView*)searchFormPickerView didSelectPassengersCount:(CAFlightPassengersCount*)passengersCount
{
    [self hidePassengersCountPicker];
    [passengerCountButton setPassengersCount:passengersCount];
}

- (void) searchFormPickerViewDidCancelButtonPress:(CASearchFormPickerView*)searchFormPickerView
{
    [self hidePassengersCountPicker];
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
    offerdata = nil;
    flightPAssengersCount = nil;
}

@end
