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
#import "SearchConditions.h"
#import "CAPassengersCountButton.h"
#import "CAAppDelegate.h"

#define Y_OFFSET 5
#define X_OFFSET 5
#define HEIGHT_FOR_ROW_AT_INDEXPATH 45
#define WIDTH_TABLE_BORDER 10

@interface CAFlightDataView ()

@end

@implementation CAFlightDataView
{
    Offer* offerdata;

    CAFlightPassengersCount* passengersCount;
    
    CASearchFormPickerView *passengerCountPicker;
    CAPassengersCountButton *passengerCountButton;
    CATooltipSelect *classSelector;
    
    CGSize countPickerViewSize;
    CGSize classSelectorViewSize;
    
    BOOL isShowPassengersCountPicker;
    BOOL isShowClassSelectorPopover;
    
    NSArray* paymentOptions;
    UIButton* onPaymentMethod;
    
    SearchConditions *currentSearchConditions;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengerCount:(CAFlightPassengersCount*)passengerCount
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offerdata = [[Offer alloc] init];
        offerdata = offer;
        passengersCount = passengerCount;
        currentSearchConditions = [[SearchConditions alloc]init];
        isShowPassengersCountPicker = NO;
        isShowClassSelectorPopover = NO;
        NSLog(@"DATA> %d %d %d", passengersCount.adultsCount, passengersCount.childrenCount, passengersCount.infantsCount);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
    paymentOptions = @[@"Евросеть или связной", @"MasterCard или Visa", @"Наличными в офисе"];
    
    UIView* assistView = [[CAAssistView alloc] initByAssistText:@"Atlassian's Git Tutorial provides an approachable introduction to Git revision control by not only explaining fundamental rkflow. " font:[UIFont fontWithName:@"HelveticaNeue" size:12] indentsBorder:5];
    [self.view addSubview:assistView];
    
    UILabel* passengersLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, assistView.frame.origin.y + assistView.frame.size.height + Y_OFFSET, 0, 0)];
    passengersLabel.text = @"Пассажиры";
    passengersLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [passengersLabel sizeToFit];
    //[self.view addSubview:passengersLabel];
    
    CGRect passengerCountButtonFrame = CGRectMake(passengersLabel.frame.origin.x-X_OFFSET, passengersLabel.frame.origin.y + passengersLabel.frame.size.height + Y_OFFSET, self.view.frame.size.width/3 - X_OFFSET, 25);
    passengerCountButton = [[CAPassengersCountButton alloc] initWithFrame:passengerCountButtonFrame];
    [passengerCountButton setPassengersCount:passengersCount];
    [passengerCountButton addTarget:self action:@selector(passengerCountButtonPress) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview: passengerCountButton];
    [passengerCountButton setTypeButton:gray];
    
    //(self.view.frame.size.width/3 + X_OFFSET, passengerCountButton.frame.origin.y,  self.view.frame.size.width*2/3 - 2*X_OFFSET, 25)
    onPaymentMethod = [[UIButton alloc] initWithFrame:CGRectMake(X_OFFSET, passengerCountButton.frame.origin.y,  self.view.frame.size.width - 2*X_OFFSET, 25)];
    [onPaymentMethod addTarget:self action:@selector(classSelectButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [onPaymentMethod setTitle:[paymentOptions objectAtIndex:0] forState:UIControlStateNormal];
    [onPaymentMethod.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [onPaymentMethod setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [onPaymentMethod setBackgroundImage:[[UIImage imageNamed:@"CASearchFormControls-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.view addSubview: onPaymentMethod];
    
    UILabel* paymentMethod = [[UILabel alloc] initWithFrame:CGRectMake(onPaymentMethod.frame.origin.x + X_OFFSET, passengersLabel.frame.origin.y, 0, 0)];
    paymentMethod.text = @"Способ оплаты";
    paymentMethod.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [paymentMethod sizeToFit];
    [self.view addSubview:paymentMethod];
    
    UIView* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offerdata passengers:passengersCount];
    CGRect orderDetalsFrame = orderDetailsView.frame;
    orderDetalsFrame.origin.y = passengerCountButton.frame.origin.y + passengerCountButton.frame.size.height + Y_OFFSET;
    orderDetailsView.frame = orderDetalsFrame;
    [self.view addSubview:orderDetailsView];
    
    ////
    
    countPickerViewSize.height = 220;
    countPickerViewSize.width = self.view.frame.size.width;
    
    classSelectorViewSize.height = 110;
    classSelectorViewSize.width = self.view.frame.size.width;
    
    passengerCountPicker = [[CASearchFormPickerView alloc]initWithFrame:CGRectMake(0, 0, countPickerViewSize.width, countPickerViewSize.height)];
    passengerCountPicker.delegate = self;
    
    classSelector = [[CATooltipSelect alloc] initWithFrame:CGRectMake(0,
                                                                         onPaymentMethod.frame.origin.y + onPaymentMethod.frame.size.height,
                                                                         classSelectorViewSize.width,
                                                                         HEIGHT_FOR_ROW_AT_INDEXPATH*paymentOptions.count+2*WIDTH_TABLE_BORDER) widthTableBorder:WIDTH_TABLE_BORDER];
    [classSelector heightForRowAtIndexPath:HEIGHT_FOR_ROW_AT_INDEXPATH];
    [classSelector setFrameForTrianglePlace:CGRectMake(self.view.frame.size.width*2/3,0,50,30)];
    classSelector.delegate = self;
    [classSelector setCheckClassSelectorImage:[UIImage imageNamed:@"check-icon-green.png"]];
}

- (IBAction) passengerCountButtonPress {
    if (isShowClassSelectorPopover)
        [self hideClassSelectorPopover];

    isShowPassengersCountPicker = YES;
    [passengerCountPicker setPassengersCountValues:passengersCount];
    passengerCountPicker.frame = CGRectMake(0,
                                            self.view.frame.size.height - countPickerViewSize.height,
                                            self.view.frame.size.width,
                                            countPickerViewSize.height);
    
    [self.view addSubview: passengerCountPicker];
}

- (IBAction) classSelectButtonPress {
    if (isShowPassengersCountPicker)
        [self hidePassengersCountPicker];
    
    isShowClassSelectorPopover = YES;
    [classSelector valuesTableRows:paymentOptions];
    [self.view addSubview:classSelector];
}

- (void) hidePassengersCountPicker
{
    isShowPassengersCountPicker = NO;
    [passengerCountPicker removeFromSuperview];
}

- (void) hideClassSelectorPopover
{
    isShowClassSelectorPopover = NO;
    [classSelector removeFromSuperview];
}

#pragma mark PickerViewDelegate

- (void) searchFormPickerView:(CASearchFormPickerView*)searchFormPickerView didSelectPassengersCount:(CAFlightPassengersCount*)flightpassengersCount
{
    [self hidePassengersCountPicker];
    [passengerCountButton setPassengersCount:flightpassengersCount];
    passengersCount = flightpassengersCount;
    
    //without infants
    currentSearchConditions.countOfTickets = [[NSNumber alloc ]initWithInteger:(passengersCount.adultsCount + passengersCount.childrenCount)];
}

- (void) searchFormPickerViewDidCancelButtonPress:(CASearchFormPickerView*)searchFormPickerView
{
    [self hidePassengersCountPicker];
}

#pragma mark CAPaymentTableViewDelegate

- (void) paymentTableView:(CATooltipSelect*)paymentTableView currentPayment:(NSString*)currentPayment
{
    [self hideClassSelectorPopover];
    [onPaymentMethod setTitle:currentPayment forState:UIControlStateNormal];
    NSLog(@"Выбран: %@", currentPayment);
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
    passengersCount = nil;
}

@end
