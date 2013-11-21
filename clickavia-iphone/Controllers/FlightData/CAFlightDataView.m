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
#import "CAOrderDetailsPersonal.h"
#import "CAColorSpecOffers.h"
#import "SearchConditions.h"
#import "CAPassengersCountButton.h"
#import "CABuyerInfo.h"
#import "CAAppDelegate.h"

#define Y_OFFSET 5
#define X_OFFSET 5
#define HEIGHT_FOR_ROW_AT_INDEXPATH 45
#define WIDTH_TABLE_BORDER 10

@interface CAFlightDataView ()
- (IBAction)onNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *next_ou;

@end

@implementation CAFlightDataView
{
    Offer* offerdata;
    SpecialOffer* specialOffer;
    CAFlightPassengersCount* passengersCount;
    SearchConditions *currentSearchConditions;
    CASearchFormPickerView *passengerCountPicker;
    CAPassengersCountButton *passengerCountButton;
    WYPopoverController* settingsPopoverController;
    
    CGSize countPickerViewSize;
    CGSize classSelectorViewSize;
    
    BOOL isShowPassengersCountPicker;
    BOOL isShowClassSelectorPopover;
    BOOL isSpecialOffer;
    
    NSArray* paymentOptions;
    UIButton* onPaymentMethod;
    CGPoint paymentButtonPosition;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengerCount:(CAFlightPassengersCount*)passengerCount
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isSpecialOffer = NO;
        offerdata = [[Offer alloc] init];
        offerdata = offer;
        passengersCount = passengerCount;
        currentSearchConditions = [[SearchConditions alloc]init];
        isShowPassengersCountPicker = NO;
        isShowClassSelectorPopover = NO;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil specialOffer:(SpecialOffer*)_specialOffer
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isSpecialOffer = YES;
        specialOffer = [SpecialOffer new];
        specialOffer = _specialOffer;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    passengersCount = appDelegate.passengersCount;
    [passengerCountButton setPassengersCount:passengersCount];
    
    if (isSpecialOffer)
        [self loadSpecialOffer];
    else
        [self loadOffer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
    
    paymentOptions = @[@"Евросеть или связной", @"MasterCard или Visa", @"Наличными в офисе"];
    
    CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:@"Проверьте правильность данных, перелета. Укажите количество билетов - отдельно для детей, взрослых и младенцев." font:[UIFont fontWithName:@"HelveticaNeue" size:14] indentsBorder:5 background:YES];
    [self.view addSubview:assistView];
    
    UILabel* passengersLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, assistView.frame.origin.y + assistView.frame.size.height + Y_OFFSET, 0, 0)];
    passengersLabel.text = @"Пассажиры";
    passengersLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [passengersLabel sizeToFit];
    [self.view addSubview:passengersLabel];
    
    CGRect passengerCountButtonFrame = CGRectMake(passengersLabel.frame.origin.x-X_OFFSET, passengersLabel.frame.origin.y + passengersLabel.frame.size.height + Y_OFFSET, self.view.frame.size.width/3 - X_OFFSET, 25);
    passengerCountButton = [[CAPassengersCountButton alloc] initWithFrame:passengerCountButtonFrame];
    [passengerCountButton addTarget:self action:@selector(passengerCountButtonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: passengerCountButton];
    [passengerCountButton setTypeButton:gray];
    
    onPaymentMethod = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3 + X_OFFSET, passengerCountButton.frame.origin.y,  self.view.frame.size.width*2/3 - 2*X_OFFSET, 25)];
    [onPaymentMethod addTarget:self action:@selector(paymentButtonPress:) forControlEvents:UIControlEventTouchUpInside];
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
    

    
    countPickerViewSize.height = 220;
    countPickerViewSize.width = self.view.frame.size.width;
    
    classSelectorViewSize.height = 110;
    classSelectorViewSize.width = self.view.frame.size.width;
    
    passengerCountPicker = [[CASearchFormPickerView alloc]initWithFrame:CGRectMake(0, 0, countPickerViewSize.width, countPickerViewSize.height)];
    passengerCountPicker.delegate = self;

    UIImage* buttonImage = [[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6) resizingMode:UIImageResizingModeStretch];
    _next_ou.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_next_ou setBackgroundImage:buttonImage forState:UIControlStateNormal];
    _next_ou.titleLabel.textColor = [UIColor whiteColor];
}

-(void)loadOffer
{
    CAOrderDetails* orderDetailsView = [[CAOrderDetails alloc] initByOfferModel:offerdata passengers:passengersCount];
    CGRect orderDetalsFrame = orderDetailsView.frame;
    orderDetalsFrame.origin.y = passengerCountButton.frame.origin.y + passengerCountButton.frame.size.height + Y_OFFSET;
    orderDetailsView.frame = orderDetalsFrame;
    [self.view addSubview:orderDetailsView];
}

-(void)loadSpecialOffer
{
    CAOrderDetailsPersonal* orderDetailsPersonalView = [[CAOrderDetailsPersonal alloc] initByOfferModel:specialOffer passengers:passengersCount];
    CGRect orderDetalsFrame = orderDetailsPersonalView.frame;
    orderDetalsFrame.origin.y = passengerCountButton.frame.origin.y + passengerCountButton.frame.size.height + Y_OFFSET;
    orderDetailsPersonalView.frame = orderDetalsFrame;
    [self.view addSubview:orderDetailsPersonalView];
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

- (IBAction) paymentButtonPress:(id)sender {
    if (isShowPassengersCountPicker)
        [self hidePassengersCountPicker];
    
    isShowClassSelectorPopover = YES;
    
    paymentButtonPosition = [sender convertPoint:CGPointZero toView:self.view];
    [self showPopover:paymentButtonPosition];
}

- (void) hidePassengersCountPicker
{
    isShowPassengersCountPicker = NO;
    [passengerCountPicker removeFromSuperview];
}

- (void) hideClassSelectorPopover
{
    isShowClassSelectorPopover = NO;
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

- (void) didSelectRowAtIndexPath:(NSIndexPath *)indexPath currentPayment:(NSString*)currentPayment;
{
    [self hideClassSelectorPopover];
    [onPaymentMethod setTitle:currentPayment forState:UIControlStateNormal];
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

-(void)showPopover:(CGPoint)point
{
    point.y -= 110;
    
    UIView* btn = [UIView new];
    CAPopoverList *popoverList = [[CAPopoverList alloc] initWithStyle:UITableViewStylePlain arrayValues:paymentOptions];
    popoverList.contentSizeForViewInPopover = CGSizeMake(self.view.frame.size.width, HEIGHT_FOR_ROW_AT_INDEXPATH*paymentOptions.count);
    popoverList.delegate = self;
    popoverList.title = @"Список паспортов";
    popoverList.modalInPopover = NO;
    [popoverList heightRow:HEIGHT_FOR_ROW_AT_INDEXPATH];
    
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
    
    [settingsPopoverController presentPopoverFromRect:CGRectMake(0, point.y, self.view.frame.size.width, HEIGHT_FOR_ROW_AT_INDEXPATH*paymentOptions.count)
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
    
    [onPaymentMethod setTitle:[paymentOptions objectAtIndex:indexPath.row] forState:UIControlStateNormal];
}

- (IBAction)onNext:(id)sender {
    if (isSpecialOffer) {
        CABuyerInfo *buyerInfo = [[CABuyerInfo alloc] initWithNibName:@"CABuyerInfo" bundle:nil specialOffer:specialOffer];
        [self.navigationController pushViewController:buyerInfo animated:YES];
    }
    else
    {
        CABuyerInfo *buyerInfo = [[CABuyerInfo alloc] initWithNibName:@"CABuyerInfo" bundle:nil offer:offerdata];
        [self.navigationController pushViewController:buyerInfo animated:YES];
    }
}

@end
