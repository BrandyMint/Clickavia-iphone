//
//  CAOffersListViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersListViewController.h"
#import <CAColumnsControl/CAColumnsControlView.h>
#import <CAColumnsControl/CAColumnMockDates.h>
#import <CAManagers/Flight.h>
#import <CAManagers/FlightDescriptionManager.h>
#import "CAOfferGreenBar.h"
#import <QuartzCore/QuartzCore.h>
#import "Offer.h"
#import "FlightPassengersCount.h"

#import "CAOffersCell.h"
#import "CAOffersCellView.h"

#import "CAOrderDetails.h"
#import "CAOrderDetailsPersonal.h"
#import "CAContract.h"
#import "CAColorSpecOffers.h"
#import "CAAppDelegate.h"
#define HEIGHT_GREEN_BAR 50
#define MARGIN_NUMBER_FLIGHT 5
#define SectionHeaderHeight 170

#define WIDTH_BUTTON 186
#define HEIGHT_BUTTON 30
#define MARGIN_RIGHT_BUTTON 8

#define COLOR_AVAILABLE_FLIGHTS colorWithRed:193.0f/255.0f green:193.0f/255.0f blue:193.0f/255.0f alpha:1

@interface CAOffersListViewController ()
@property (nonatomic, retain) CAOffersData* caoffersData;
@property (retain, nonatomic) IBOutlet CAOfferGreenBar *topGreenView;
@property (weak, nonatomic) IBOutlet UILabel *labelThere;
@property (weak, nonatomic) IBOutlet UILabel *labelThereDate;
@property (weak, nonatomic) IBOutlet UILabel *labelBack;
@property (weak, nonatomic) IBOutlet UILabel *labelBackDate;

@property (nonatomic, strong) CAColumnsControlView *columnDepartureControlView;
@property (nonatomic, strong) CAColumnsControlView *columnArrivialControlView;
@end

@implementation CAOffersListViewController
{
    NSMutableArray *offerArray;
    
    BOOL isReturn;
    CGRect mainFrame;
    UIBarButtonItem *onAddGreenBar;
    UIBarButtonItem *onReturn;
    
    UIView *viewOneWay;
    UIView *viewOnBack;
    
    UIButton *onDetail;
    
    NSArray* arrayOffers;
    NSArray* arrayPassangers;
    
    UIView *headerTableView;
    FlightDescriptionManager *fdm;
    
    UIActivityIndicatorView *indicatorView;
}
@synthesize columnDepartureControlView, columnArrivialControlView;
@synthesize tableOffers;
@synthesize topGreenView;
@synthesize labelBack, labelBackDate, labelThere, labelThereDate;
@synthesize caoffersData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isBothWays:(BOOL) isBothWays;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        isReturn = isBothWays;
        
        [self factor];
        [self setupDatesText];
        //_offerConditions.searchConditions.isBothWays = switchReturnFlight.isOn;
        [self loadDataForColumnDeparture];
        [tableOffers reloadData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    fdm = [FlightDescriptionManager new];
    self.navigationController.navigationBarHidden = NO;
}
- (void)initControls
{
    
    tableOffers.scrollEnabled = YES;
    
    [topGreenView setFrame:CGRectMake(0,
                                      0,
                                      self.view.frame.size.width,
                                      HEIGHT_GREEN_BAR)];
    labelThere.frame = CGRectMake(self.view.frame.size.width/2-60, 16, 0, 0);
    labelBack.backgroundColor = labelThere.backgroundColor = [UIColor clearColor];
    labelBack.textColor = labelThere.textColor = [UIColor whiteColor];
    labelBack.font = labelThere.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelThere.text = @"туда";
    [labelThere sizeToFit];
    
    labelThereDate.frame = CGRectMake(labelThere.frame.origin.x + labelThere.frame.size.width +5, 15, 0, 0);
    labelBackDate.backgroundColor = labelThereDate.backgroundColor = [UIColor clearColor];
    labelBackDate.textColor = labelThereDate.textColor = [UIColor whiteColor];
    labelBackDate.font = labelThereDate.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    labelThereDate.text = @"abc";
    [labelThereDate sizeToFit];
    
    labelBack.frame = CGRectMake(self.view.frame.size.width/2+20, 16, 0, 0);
    labelBack.text = @"обратно";
    [labelBack sizeToFit];
    
    labelBackDate.frame = CGRectMake(labelBack.frame.origin.x + labelBack.frame.size.width +5, 15, 0, 0);
    labelBackDate.text = @"abc";
    [labelBackDate sizeToFit];
    
    labelBack.alpha = labelBack.alpha = labelBackDate.alpha = 0;
    labelThereDate.layer.shadowOpacity = labelBackDate.layer.shadowOpacity = 0.2f;
    labelThereDate.layer.shadowRadius = labelBackDate.layer.shadowRadius = 0.0f;
    labelThereDate.layer.shadowColor = labelBackDate.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelThereDate.layer.shadowOffset = labelBackDate.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    UITapGestureRecognizer *tapGreenBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detail)];
    [topGreenView addGestureRecognizer:tapGreenBar];
    topGreenView.userInteractionEnabled = YES;
    
    arrayOffers = nil;
    arrayPassangers = nil;
    indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0-20, self.view.frame.size.height/2.0-20, 10, 10)];
    indicatorView.color = [UIColor lightGrayColor];
    [_loadingView addSubview:indicatorView];
    
}
-(void)showLoading:(BOOL)show
{
    
    if(show)
    {
        [_loadingView removeFromSuperview];
        [[[UIApplication sharedApplication] keyWindow] addSubview:_loadingView];
        [_loadingView setHidden:NO];
        [indicatorView startAnimating];
        
    }
    else
    {
        [_loadingView removeFromSuperview];
        [_loadingView setHidden:YES];
        [indicatorView stopAnimating];
    }
}
-(void)setupDestinationsLabelsFrom:(UILabel*)fromLabel andTo:(UILabel*)toLabel
{
    fromLabel.text = _offerConditions.searchConditions.direction_departure.title;
    toLabel.text = _offerConditions.searchConditions.direction_return.title;
}
-(void)setupDatesText
{
    if(_offerConditions!=nil&&_offerConditions.departureDate!=nil)
    {
        labelThereDate.text = [self textForDate:_offerConditions.departureDate];
        CGSize stringBoundingBox = [labelThereDate.text sizeWithFont:labelThereDate.font];
        labelThereDate.frame = CGRectMake(labelThereDate.frame.origin.x, labelThereDate.frame.origin.y, stringBoundingBox.width, labelThereDate.frame.size.height);
    }
    if(_offerConditions!=nil&&_offerConditions.returnDate!=nil)
    {
        labelBackDate.text = [self textForDate:_offerConditions.returnDate];
        CGSize stringBoundingBox = [labelBackDate.text sizeWithFont:labelBackDate.font];
        labelBackDate.frame = CGRectMake(labelBackDate.frame.origin.x, labelBackDate.frame.origin.y, stringBoundingBox.width, labelBackDate.frame.size.height);
    }
}
-(NSString*)textForDate:(NSDate*)date
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    int month = dateComponents.month;
    NSString *monthString = @"";
    int day = dateComponents.day;
    switch (month) {
            
        case 1:
            monthString =@"января";
            break;
        case 2:
            monthString =@"февраля";
            break;
        case 3:
            monthString =@"марта";
            break;
        case 4:
            monthString =@"апреля";
            break;
        case 5:
            monthString =@"мая";
            break;
        case 6:
            monthString =@"июня";
            break;
        case 7:
            monthString =@"июля";
            break;
        case 8:
            monthString =@"августа";
            break;
        case 9:
            monthString =@"сентября";
            break;
        case 10:
            monthString =@"октября";
            break;
        case 11:
            monthString =@"ноября";
            break;
        case 12:
            monthString =@"декабря";
            break;
        default:
            break;
    }
    NSString *result = [[NSString alloc] initWithFormat:@"%i %@",day,monthString];
    return result;
    
}
-(void) viewWillAppear:(BOOL)animated
{
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _offerConditions = appDelegate.offerConditions;
    if(_offerConditions!=nil)
    {
        topGreenView.hidden = NO;
        if(_offerConditions.departureDate==nil)
        {
            _offerConditions.departureDate = [NSDate date];
        }
        [self loadOffers];
        [self showNavBar];
        [self initControls];
        [self loadDataForColumnDeparture];
        mainFrame = self.view.frame;
        
        viewOneWay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 140)];
        viewOnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 280)];
        
        columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, viewOneWay.frame.size.height) title:@"туда" flight_kind:ONEWAY_FLIGHT withTarget:nil];
        
        columnDepartureControlView.delegate = (id)self;
        
        
        columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, viewOneWay.frame.size.height, mainFrame.size.width, viewOneWay.frame.size.height) title:@"обратно" flight_kind:FLIGHT_BACK withTarget:nil];
        columnArrivialControlView.delegate = (id)self;
        tableOffers.bounds = mainFrame;
        tableOffers.frame = CGRectMake(0,
                                       0,
                                       mainFrame.size.width,
                                       mainFrame.size.height);
        [tableOffers setContentOffset:CGPointMake(0, 0) animated:NO];
        [self setupDatesText];
    }
    else
    {
        topGreenView.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Данные для поиска пусты" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (void)loadOffers
{
    [self showLoading:YES];
    fdm.offerConditions = _offerConditions;
    [fdm getAvailableOffersWithCompleteBlock:^(NSArray *offers)
     {
         [self setupDatesText];
         arrayOffers = offers;
         [tableOffers reloadData];
         [self showLoading:NO];
     }];
}
- (void)columnsControlViewDataLoaded:(CAColumnsControlView *)columnsControlView
{
    if(columnsControlView==columnDepartureControlView)
    {
        BOOL result = [columnDepartureControlView selectFlightWithDate:_offerConditions.departureDate];
        if(!result)
        {
            NSLog(@"NO FLIGHT");
        }
    }
    if(columnsControlView==columnArrivialControlView)
    {
        BOOL result = [columnArrivialControlView selectFlightWithDate:_offerConditions.returnDate];
        if(!result)
        {
            NSLog(@"NO FLIGHT");
        }
    }
}
-(void)loadDataForColumnDeparture
{
    [self showLoading:YES];
    fdm.offerConditions = _offerConditions;
    [fdm getFlightsDepartureByDateWithCompleteBlock:^(NSArray *flights){
        [columnDepartureControlView importFlights:flights];
        [self showLoading:NO];
        
        //[columnArrivialControlView importFlights:[NSArray new]];
    }];
}
-(void)loadDataForColumnsArrival
{
    [self showLoading:YES];
    fdm.offerConditions = _offerConditions;
    [fdm getFlightsReturnByDateWithCompleteBlock:^(NSArray *flights)
     {
         [columnArrivialControlView importFlights:flights];
         BOOL result = [columnArrivialControlView selectFlightWithDate:_offerConditions.returnDate];
         if(!result)
         {
             NSLog(@"NO FLIGHT");
         }

         [self showLoading:NO];
         
     }];
}
-(void)showNavBar
{
    UIImage *navBackImage = [UIImage imageNamed:@"toolbar-back-icon.png"];
    UIButton *navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBack setImage:navBackImage forState:UIControlStateNormal];
    navBack.frame = CGRectMake(0, 0, navBackImage.size.width, navBackImage.size.height);
    [navBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = navBackBarItem;
    
    onDetail = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 35)];
    UIImage *toolbarColumnsIcon = [UIImage imageNamed:@"columns-icon.png"];
    [onDetail setImage:toolbarColumnsIcon forState:UIControlStateNormal];
    [onDetail setImage:toolbarColumnsIcon forState:UIControlStateHighlighted];
    [onDetail setBackgroundImage:[UIImage imageNamed:@"toolbar-button.png"] forState:UIControlStateNormal];
    [onDetail setBackgroundImage:[UIImage imageNamed:@"toolbar-button-active.png"] forState:UIControlStateHighlighted];
    [onDetail setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [onDetail addTarget: self action: @selector(detail) forControlEvents: UIControlEventTouchDown];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:onDetail];
    self.navigationItem.rightBarButtonItem = customBarItem;
    
    UILabel *departureCity = [[UILabel alloc] initWithFrame:CGRectZero];
    departureCity.text = @"Москва";
    [departureCity sizeToFit];
    
    UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(departureCity.frame.origin.x + departureCity.frame.size.width + 3, 6, 8, 10)];
    arrow.image = [UIImage imageNamed:@"toolbar-arrow-right.png"];
    
    UILabel *arrivalCity = [[UILabel alloc] initWithFrame:CGRectMake(arrow.frame.origin.x + arrow.frame.size.width + 3 , 0, 0, 0)];
    arrivalCity.text = @"Краснодар";
    
    departureCity.backgroundColor = arrivalCity.backgroundColor = [UIColor clearColor];
    departureCity.font = arrivalCity.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    departureCity.textColor = arrivalCity.textColor = [UIColor COLOR_TITLE_TEXT];
    departureCity.layer.shadowOpacity = arrivalCity.layer.shadowOpacity = 0.4f;
    departureCity.layer.shadowRadius = arrivalCity.layer.shadowRadius = 0.0f;
    departureCity.layer.shadowColor = arrivalCity.layer.shadowColor = [[UIColor COLOR_TITLE_TEXT_SHADOW] CGColor];
    departureCity.layer.shadowOffset =  arrivalCity.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [arrivalCity sizeToFit];
    
    UIView* titleBarItemView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        arrivalCity.frame.origin.x + arrivalCity.frame.size.width,
                                                                        self.navigationController.navigationBar.frame.size.height/2)];
    [titleBarItemView addSubview:departureCity];
    [titleBarItemView addSubview:arrow];
    [titleBarItemView addSubview:arrivalCity];
    self.navigationItem.titleView = titleBarItemView;
    [self setupDestinationsLabelsFrom:departureCity andTo:arrivalCity];
}

-(void) detail
{
    [self factor];
    if(onDetail.selected) {
        [onDetail setSelected:NO];
        [onDetail setImage:[UIImage imageNamed:@"toolbar-button.png"] forState:UIControlStateNormal];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenView.alpha = 1;
        [UIView commitAnimations];
        
    }
    else
    {
        [onDetail setSelected:YES];
        [onDetail setImage:[UIImage  imageNamed:@"toolbar-button-selected.png"] forState:UIControlStateSelected];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenView.alpha = 0;
        [UIView commitAnimations];
    }
    [tableOffers setContentOffset:CGPointMake(0, 0) animated:YES];
    [tableOffers reloadData];
}

-(NSInteger )factor
{
    [self setupDatesText];
    if (onDetail.selected) {
        if (isReturn) {
            isReturn = YES;
            labelThere.text = @"туда";
            labelThereDate.text = @"21 сентября";
            labelThere.frame = CGRectMake(20, 11, labelThere.frame.size.width, labelThere.frame.size.width);
            labelThereDate.frame = CGRectMake(labelThere.frame.origin.x + labelThere.frame.size.width + 5, 15, 0, 0);
            [labelThereDate sizeToFit];
            labelThere.alpha = labelThereDate.alpha = 1;
            labelBack.alpha = labelBackDate.alpha = 1;
            
            return 2;
        }
        else
        {
            isReturn = NO;
            labelBack.text = @"обратно";
            labelBackDate.text = @"22 сентября";
            labelThere.frame = CGRectMake(self.view.frame.size.width/2-60, 11, labelThere.frame.size.width, labelThere.frame.size.width);
            labelThereDate.frame = CGRectMake(labelThere.frame.origin.x + labelThere.frame.size.width + 5, 15, 0, 0);
            [labelThereDate sizeToFit];
            labelThere.alpha = labelThereDate.alpha = 1;
            labelBack.alpha = labelBackDate.alpha = 0;
            return 1;
        }
    }
    return 0;
}

#pragma mark -
#pragma mark Tab Bar delegate methods

- (NSString *)tabTitle
{
	return @"Графики";
}

-(NSString*)tabImageName
{
    return nil;
}

- (void)columnsControlView:(CAColumnsControlView *)columnsControlView didSelectColumnWithObject:(Flight*)flight
{
    if(columnsControlView==columnDepartureControlView)
    {
        _offerConditions.departureDate = flight.dateAndTimeDeparture;
        if(_offerConditions.searchConditions.isBothWays)
        {
            [self loadDataForColumnsArrival];
        }
        else
        {
            [self loadOffers];
        }
    }
    if(columnsControlView==columnArrivialControlView)
    {
        
        _offerConditions.returnDate = flight.dateAndTimeDeparture;
        [self loadOffers];
    }
}

#pragma mark
#pragma mark Table Data Source Methods

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arrayOffers.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (FlightPassengersCount*)mapFrom:(CAFlightPassengersCount*)pasCount
{
    FlightPassengersCount *count = [FlightPassengersCount new];
    count.adults = pasCount.adultsCount;
    count.kids = pasCount.childrenCount;
    count.babies = pasCount.infantsCount;
    return count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    Offer* offerObject = [[Offer alloc] init];
    Flight* flightObject = [[Flight alloc] init];


    offerObject = [arrayOffers objectAtIndex:indexPath.section];
    flightObject = [arrayOffers objectAtIndex:indexPath.section];
    flightObject = offerObject.flightDeparture;
    
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    FlightPassengersCount* passengersCount = [self mapFrom:appDelegate.passengersCount];
    //поиск ячейки
	CAOffersCell *cell = (CAOffersCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        //если ячейка не найдена - создаем новую
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CAOffersCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        UIView* cardView = [[CAOffersCellView alloc] initByOfferModel:offerObject passengers:passengersCount];
        [cell transferView:cardView];
        
        //UIView* offerDataCard = [[OfferDetails alloc] initByOfferModel:offerdata passangers:passengersCount];
        //UIView* detailsPersonal = [[FlightDetails alloc] initByOfferModel:offerdata passangers:passengersCount];
        //[cell transferView:detailsPersonal];
        
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor redColor]; // any color of your choice.
        [v.layer setCornerRadius:6];
        v.layer.shadowColor = [[UIColor whiteColor] CGColor];
        v.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        v.layer.shadowRadius = 10;
        v.layer.shadowOpacity = 1.0;
        cell.selectedBackgroundView = v;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer* offerObject = [[Offer alloc] init];
    offerObject = [arrayOffers objectAtIndex:indexPath.section];
    
    CGRect frameButton = CGRectZero;
    if (offerObject.isSpecial) {
        if (offerObject.isMomentaryConfirmation) {
            frameButton = CGRectMake(cell.frame.size.width - WIDTH_BUTTON - MARGIN_RIGHT_BUTTON,
                                     cell.frame.size.height - HEIGHT_BUTTON - 2*CELL_SPECIAL_PADDING,
                                     WIDTH_BUTTON,
                                     HEIGHT_BUTTON);
        }
        else{
            frameButton = CGRectMake(cell.frame.size.width - WIDTH_BUTTON - MARGIN_RIGHT_BUTTON,
                                     cell.frame.size.height - HEIGHT_BUTTON - 1.7*CELL_SPECIAL_PADDING,
                                     WIDTH_BUTTON,
                                     HEIGHT_BUTTON);
        }
    }
    else {
        if (offerObject.isMomentaryConfirmation) {
        frameButton = CGRectMake(cell.frame.size.width - WIDTH_BUTTON - MARGIN_RIGHT_BUTTON,
                                 cell.frame.size.height - HEIGHT_BUTTON - CELL_SPECIAL_PADDING,
                                 WIDTH_BUTTON,
                                 HEIGHT_BUTTON);
        }
        else {
            frameButton = CGRectMake(cell.frame.size.width - WIDTH_BUTTON - MARGIN_RIGHT_BUTTON,
                                     cell.frame.size.height - HEIGHT_BUTTON - 0.7*CELL_SPECIAL_PADDING,
                                     WIDTH_BUTTON,
                                     HEIGHT_BUTTON);
        }
    }
    
    NSDecimalNumber *boothPrice = offerObject.bothPrice;
    NSString* boothPriceBehavior = [self priceBehavior:boothPrice];
    UIButton *button = [[UIButton alloc] initWithFrame: frameButton];
    UIImage * imgNormal = [UIImage imageNamed:@"btn-primary-for-light.png"];
    [button setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [button setTitle: [NSString stringWithFormat:@"Купить за %@ руб.",boothPriceBehavior] forState: UIControlStateNormal];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    button.titleLabel.layer.shadowOpacity = 0.4f;
    button.titleLabel.layer.shadowRadius = 0.0f;
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [cell addSubview:button];

    cell.backgroundColor = [UIColor clearColor];
}

-(NSString*)priceBehavior:(NSDecimalNumber*)priceBehavior
{
    NSDecimalNumberHandler *decimalNumberHandler = [NSDecimalNumberHandler
                                                    decimalNumberHandlerWithRoundingMode:NSRoundUp
                                                    scale:0
                                                    raiseOnExactness:NO
                                                    raiseOnOverflow:NO
                                                    raiseOnUnderflow:NO
                                                    raiseOnDivideByZero:YES];
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[priceBehavior stringValue]]];
    NSDecimalNumber *discount = [NSDecimalNumber decimalNumberWithString:@"1"];
    
    NSDecimalNumber *total = [price decimalNumberByMultiplyingBy:discount withBehavior:decimalNumberHandler];
    NSString* behavior = [total stringValue];
    return behavior;
}

- (void)showOrCloseWays
{
    if (isReturn) {
        [viewOneWay removeFromSuperview];
        [viewOnBack removeFromSuperview];
        [viewOnBack addSubview:columnDepartureControlView];
        [viewOnBack addSubview:columnArrivialControlView];
        [headerTableView addSubview:viewOnBack];
    }
    else {
        [viewOneWay removeFromSuperview];
        [viewOnBack removeFromSuperview];
        [viewOneWay addSubview:columnDepartureControlView];
        [headerTableView addSubview:viewOneWay];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        float marginNumberFlights = topGreenView.frame.size.height + 5;
        
        headerTableView = [[UIView alloc] initWithFrame:CGRectMake(mainFrame.origin.x,
                                                                   mainFrame.origin.y,
                                                                   mainFrame.size.width,
                                                                   factor*viewOneWay.frame.size.height + 20)];
        if (onDetail.selected) {
            [self showOrCloseWays];
            marginNumberFlights = factor*viewOneWay.frame.size.height + 5;
        }
        
        UILabel* numberFlights = [[UILabel alloc] init];
        numberFlights.text = [NSString stringWithFormat:@"Доступно перелетов: %d",arrayOffers.count];
        numberFlights.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        numberFlights.textColor = [UIColor COLOR_AVAILABLE_FLIGHTS];
        CGSize textSize = [numberFlights.text sizeWithFont:numberFlights.font];
        numberFlights.frame = CGRectMake(mainFrame.size.width/2 - textSize.width/2, marginNumberFlights, 0, 0);
        numberFlights.backgroundColor = [UIColor clearColor];
        [numberFlights sizeToFit];


        
        [headerTableView addSubview:numberFlights];
        return headerTableView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer* offerObject = [[Offer alloc] init];
    offerObject = [arrayOffers objectAtIndex:indexPath.section];
    if(offerObject.isSpecial)
        return CELL_HEIGHT_SPECIAL;
    else
        return CELL_HEIGHT_NORMAL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        if (onDetail.selected) {
            return factor*viewOneWay.frame.size.height + 26;
        }
        else {
            return factor*viewOneWay.frame.size.height + 26 + topGreenView.frame.size.height;
        }
    }
    else
        return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer* offerdata = [[Offer alloc] init];
    offerdata = [arrayOffers objectAtIndex:indexPath.section];
    FlightPassengersCount* passengersCount = [[FlightPassengersCount alloc] init];
    passengersCount = [arrayPassangers objectAtIndex:indexPath.section];
    
    NSLog(@"нажал на %d ячейку, special: %d, momentary: %d", indexPath.section, offerdata.isSpecial, offerdata.isMomentaryConfirmation);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    CAContract* caContract = [[CAContract alloc] initWithNibName:@"CAContract" bundle:nil offer:offerdata passengers:passengersCount];
    [self.navigationController pushViewController:caContract animated:YES];
}

-(void)buttonClicked
{

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

@end
