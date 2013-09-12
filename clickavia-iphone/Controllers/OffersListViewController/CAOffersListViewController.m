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
#import "CAOfferCell.h"
#import "CAOfferGreenBar.h"
#import <QuartzCore/QuartzCore.h>
#import "Offer.h"
#import "Flight.h"
#import "FlightPassengersCount.h"

#define HEIGHT_GREEN_BAR 50
#define MARGIN_NUMBER_FLIGHT 5
#define SectionHeaderHeight 170

#define WIDTH_BUTTON 186
#define HEIGHT_BUTTON 44
#define MARGIN_RIGHT_BUTTON 15

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
    Offer *offer1, *offer2, *offer3;
    
    BOOL isReturn;
    CGRect mainFrame;
    UIBarButtonItem *onAddGreenBar;
    UIBarButtonItem *onReturn;

    UISwitch *switchReturnFlight;
    UIView *viewOneWay;
    UIView *viewOnBack;
    
    UIButton *onDetail;
    
    NSArray* arrayOffers;
    NSArray* arrayPassangers;
}
@synthesize columnDepartureControlView, columnArrivialControlView;
@synthesize tableOffers;
@synthesize topGreenView;
@synthesize labelBack, labelBackDate, labelThere, labelThereDate;
@synthesize caoffersData;

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
    self.navigationController.navigationBarHidden = NO;
    [self showNavBar];
    
    tableOffers.scrollEnabled = YES;
    
    [topGreenView setFrame:CGRectMake(self.view.frame.origin.x,
                                      self.view.frame.origin.y,
                                      self.view.frame.size.width,
                                      HEIGHT_GREEN_BAR)];
    topGreenView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bar-green-warm@2x.png"]];

    labelThere.frame = CGRectMake(30, 15, 0, 0);
    labelBack.backgroundColor = labelThere.backgroundColor = [UIColor clearColor];
    labelBack.textColor = labelThere.textColor = [UIColor whiteColor];
    labelBack.font = labelThere.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelThere.text = @"туда";
    [labelThere sizeToFit];
    
    labelThereDate.frame = CGRectMake(labelThere.frame.origin.x + labelThere.frame.size.width +3, 14, 0, 0);
    labelBackDate.backgroundColor = labelThereDate.backgroundColor = [UIColor clearColor];
    labelBackDate.textColor = labelThereDate.textColor = [UIColor whiteColor];
    labelBackDate.font = labelThereDate.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    labelThereDate.text = @"21 сентября";
    [labelThereDate sizeToFit];
    
    labelBack.frame = CGRectMake(labelThereDate.frame.origin.x + labelThereDate.frame.size.width + 20, 15, 0, 0);
    labelBack.text = @"обратно";
    [labelBack sizeToFit];
    
    labelBackDate.frame = CGRectMake(labelBack.frame.origin.x + labelBack.frame.size.width +3, 14, 0, 0);
    labelBackDate.text = @"22 сентября";
    [labelBackDate sizeToFit];
    
    labelThereDate.layer.shadowOpacity = labelBackDate.layer.shadowOpacity = 0.2f;
    labelThereDate.layer.shadowRadius = labelBackDate.layer.shadowRadius = 0.0f;
    labelThereDate.layer.shadowColor = labelBackDate.layer.shadowColor = [[UIColor blackColor] CGColor];
    labelThereDate.layer.shadowOffset = labelBackDate.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    UITapGestureRecognizer *tapGreenBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(detail)];
    [topGreenView addGestureRecognizer:tapGreenBar];
    topGreenView.userInteractionEnabled = YES;
    
    caoffersData = [[CAOffersData alloc] init];
    arrayOffers = [caoffersData arrayOffer];
    arrayPassangers = [caoffersData arrayPassangers];
}

-(void) viewWillAppear:(BOOL)animated
{
    mainFrame = self.view.frame;

    viewOneWay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 140)];
    viewOnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 280)];
    
    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, viewOneWay.frame.size.height) title:@"туда" withTarget:nil];
    columnDepartureControlView.delegate = (id)self;
    NSArray *departureFlights = [CAColumnMockDates generateFlyToDates];
    //[columnDepartureControlView importFlights: departureFlights];
    
    columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, viewOneWay.frame.size.height, mainFrame.size.width, viewOneWay.frame.size.height) title:@"обратно" withTarget:nil];
    
    tableOffers.bounds = mainFrame;
    tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                   mainFrame.origin.y,
                                   mainFrame.size.width,
                                   mainFrame.size.height);
    [tableOffers setContentOffset:CGPointMake(0, viewOneWay.frame.size.height - topGreenView.frame.size.height) animated:NO];
}

-(void)showNavBar
{
    UIButton *onBack = [[UIButton alloc] initWithFrame: CGRectMake(5, 12, 20, 20)];
    [onBack setImage:[UIImage imageNamed:@"toolbar-back-icon@2x.png"] forState:UIControlStateNormal];
    
    switchReturnFlight = [[UISwitch alloc] initWithFrame:CGRectMake(onBack.frame.origin.x + onBack.frame.size.width + 3, 8, 10, 10)];
    [switchReturnFlight addTarget:self action:@selector(switchToggled) forControlEvents: UIControlEventTouchUpInside];
    
    UILabel *departureCity = [[UILabel alloc] initWithFrame:CGRectMake(switchReturnFlight.frame.origin.x + switchReturnFlight.frame.size.width + 3 , 11, 0, 0)];
    departureCity.backgroundColor = [UIColor clearColor];
    departureCity.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    departureCity.textColor = [UIColor whiteColor];
    departureCity.text = @"Москва";
    departureCity.layer.shadowOpacity = 0.8f;
    departureCity.layer.shadowRadius = 0.0f;
    departureCity.layer.shadowColor = [[UIColor blackColor] CGColor];
    departureCity.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [departureCity sizeToFit];
    
    UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(departureCity.frame.origin.x + departureCity.frame.size.width + 3, 18, 8, 10)];
    arrow.image = [UIImage imageNamed:@"toolbar-arrow-right@2x.png"];
    
    UILabel *arrivalCity = [[UILabel alloc] initWithFrame:CGRectMake(arrow.frame.origin.x + arrow.frame.size.width + 3 , 11, 0, 0)];
    arrivalCity.backgroundColor = [UIColor clearColor];
    arrivalCity.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    arrivalCity.textColor = [UIColor whiteColor];
    arrivalCity.text = @"Краснодар";
    arrivalCity.layer.shadowOpacity = 0.8f;
    arrivalCity.layer.shadowRadius = 0.0f;
    arrivalCity.layer.shadowColor = [[UIColor blackColor] CGColor];
    arrivalCity.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [arrivalCity sizeToFit];
    
    onDetail = [[UIButton alloc] initWithFrame: CGRectMake(arrivalCity.frame.origin.x + arrivalCity.frame.size.width + 3, 4, 50, 35)];
    [onDetail setImage:[UIImage imageNamed:@"toolbar-button@2x.png"] forState:UIControlStateNormal];
    [onDetail setImage:[UIImage imageNamed:@"toolbar-button-selected@2x.png"] forState:UIControlStateHighlighted];
    [onDetail setTitleColor: [UIColor redColor] forState: UIControlStateNormal];
    [onDetail addTarget: self action: @selector(detail) forControlEvents: UIControlEventTouchDown];
    
    UIView* navControllerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x,
                                                                         self.view.frame.origin.y,
                                                                         self.view.frame.size.width,
                                                                         self.navigationController.toolbar.frame.size.height)];
    navControllerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"toolbar-background@2x.png"]];
    [navControllerView addSubview:onBack];
    [navControllerView addSubview:switchReturnFlight];
    [navControllerView addSubview:departureCity];
    [navControllerView addSubview:arrow];
    [navControllerView addSubview:arrivalCity];
    [navControllerView addSubview:onDetail];
    [self.navigationController.view addSubview:navControllerView];
}

-(void) detail
{
    [self factor];
    NSInteger factor = [self factor];
    
    if(onDetail.selected) {
        [onDetail setSelected:NO];
        [onDetail setImage:[UIImage  imageNamed:@"toolbar-button@2x.png"] forState:UIControlStateNormal];
        
        
        
        [tableOffers setContentOffset:CGPointMake(0, factor*viewOneWay.frame.size.height - topGreenView.frame.size.height) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenView.alpha = 1;
        [UIView commitAnimations];
        
    }
    else
    {
        [onDetail setSelected:YES];
        [onDetail setImage:[UIImage  imageNamed:@"toolbar-button-selected@2x.png"] forState:UIControlStateSelected];
        
        [tableOffers setContentOffset:CGPointMake(0, 0) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenView.alpha = 0;
        [UIView commitAnimations];
    }
}

-(void)switchToggled
{
    [self factor];
    [self detail];
    [tableOffers reloadData];
}

-(NSInteger )factor
{
    if ([switchReturnFlight isOn]) {
        isReturn = YES;
        labelThere.text = @"туда";
        labelThereDate.text = @"21 сентября";
        labelThere.alpha = labelThereDate.alpha = 1;
        labelBack.alpha = labelBackDate.alpha = 1;
        
        return 2;
    }
    isReturn = NO;
    labelBack.text = @"обратно";
    labelBackDate.text = @"22 сентября";
    labelThere.alpha = labelThereDate.alpha = 1;
    labelBack.alpha = labelBackDate.alpha = 0;
    return 1;
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
    NSArray *arrivialFlights = [CAColumnMockDates generateFlyReturnDates:flight.dateAndTimeDeparture];
    [columnArrivialControlView importFlights: arrivialFlights];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OfferCell";
    
    CAOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Offer* offerdata = [[Offer alloc] init];
    Flight* flightdata = [[Flight alloc] init];
    FlightPassengersCount* passengersCount = [[FlightPassengersCount alloc] init];
    offerdata = [arrayOffers objectAtIndex:indexPath.section];
    flightdata = [arrayOffers objectAtIndex:indexPath.section];
    passengersCount = [arrayPassangers objectAtIndex:indexPath.section];
    flightdata = offerdata.flightDeparture;
    
    if (cell == nil) {
        cell = [[CAOfferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.isSpecial = offerdata.isSpecial;
        cell.isMomentaryConfirmation = offerdata.isMomentaryConfirmation;
        cell.cityDeparture = flightdata.cityDeparture;
        cell.cityArrival = flightdata.cityArrival;
        cell.airlineTitle = flightdata.airlineTitle;
        cell.airlineCode = flightdata.ID;
        cell.timeDeparture = flightdata.dateAndTimeDeparture;
        cell.timeArrival = flightdata.dateAndTimeArrival;
        cell.timeInFlight = flightdata.timeInFlight;
        
        cell.adultCount = passengersCount.adults;
        cell.kidCount = passengersCount.kids;
        cell.babuCount = passengersCount.babies;
        
        CGRect frameButton = CGRectMake(cell.frame.size.width - WIDTH_BUTTON - MARGIN_RIGHT_BUTTON, cell.frame.size.height - 2*MARGIN_RIGHT_BUTTON - HEIGHT_BUTTON, WIDTH_BUTTON, HEIGHT_BUTTON);
        NSDecimalNumber *boothPrice = offerdata.bothPrice;
        UIButton *button = [[UIButton alloc] initWithFrame: frameButton];
        UIImage * imgNormal = [UIImage imageNamed:@"btn-primary-for-light@2x.png"];
        [button setBackgroundImage:imgNormal forState:UIControlStateNormal];
        [button setTitle: [NSString stringWithFormat:@"Купить за %@ руб.",[boothPrice stringValue]] forState: UIControlStateNormal];
        [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
        button.titleLabel.layer.shadowOpacity = 0.4f;
        button.titleLabel.layer.shadowRadius = 0.0f;
        button.titleLabel.shadowColor = [UIColor blackColor];
        button.titleLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
        //[cell addSubview:button];
        
        //cell = [[UIView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        [cell initByOfferModel:offerdata];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        
        UILabel* numberFlights = [[UILabel alloc] init];
        numberFlights.text = [NSString stringWithFormat:@"Доступно перелетов %d",arrayOffers.count];
        numberFlights.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        numberFlights.textColor = [UIColor COLOR_AVAILABLE_FLIGHTS];
        CGSize textSize = [numberFlights.text sizeWithFont:numberFlights.font];
        numberFlights.frame = CGRectMake(mainFrame.size.width/2 - textSize.width/2, factor*viewOneWay.frame.size.height + 4, 0, 0);
        numberFlights.backgroundColor = [UIColor clearColor];
        [numberFlights sizeToFit];

        UIView *headerTableView = [[UIView alloc] initWithFrame:CGRectMake(mainFrame.origin.x,
                                                                mainFrame.origin.y,
                                                                mainFrame.size.width,
                                                                factor*viewOneWay.frame.size.height + 20)];
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
        [headerTableView addSubview:numberFlights];
        return headerTableView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer* offerdata = [[Offer alloc] init];
    offerdata = [arrayOffers objectAtIndex:indexPath.section];
    if(offerdata.isSpecial)
        return CELL_HEIGHT_SPECIAL;
    else
        return CELL_HEIGHT_NORMAL;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        return factor*viewOneWay.frame.size.height + 26; }
    else
        return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer* offerdata = [[Offer alloc] init];
    offerdata = [arrayOffers objectAtIndex:indexPath.section];
    NSLog(@"нажал на %d ячейку, special: %d, momentary: %d", indexPath.section, offerdata.isSpecial, offerdata.isMomentaryConfirmation);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)buttonClicked
{
    NSLog(@"click");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    onDetail.selected = YES;
    topGreenView.alpha = 0;
    [UIView commitAnimations];
}

@end
