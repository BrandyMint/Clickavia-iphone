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
#import "CAOfferGreenBar.h"
#import <QuartzCore/QuartzCore.h>
#import "Offer.h"
#import "Flight.h"
#import "FlightPassengersCount.h"

#import "CAOffersCell.h"
#import "CAOffersCellView.h"

#import "CAOrderDetails.h"
#import "CAOrderDetailsPersonal.h"
#import "CAContract.h"
#import "CAColorSpecOffers.h"

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

    UISwitch *switchReturnFlight;
    UIView *viewOneWay;
    UIView *viewOnBack;
    
    UIButton *onDetail;
    
    NSArray* arrayOffers;
    NSArray* arrayPassangers;
    
    UIView *headerTableView;
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
    labelThereDate.text = @"21 сентября";
    [labelThereDate sizeToFit];
    
    labelBack.frame = CGRectMake(self.view.frame.size.width/2+20, 16, 0, 0);
    labelBack.text = @"обратно";
    [labelBack sizeToFit];
    
    labelBackDate.frame = CGRectMake(labelBack.frame.origin.x + labelBack.frame.size.width +5, 15, 0, 0);
    labelBackDate.text = @"22 сентября";
    [labelBackDate sizeToFit];
    
    labelBack.alpha = labelBack.alpha = labelBackDate.alpha = 0;
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
    
}
-(void)showNavBar
{
    switchReturnFlight = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [switchReturnFlight addTarget:self action:@selector(switchToggled) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *switchBarItem = [[UIBarButtonItem alloc] initWithCustomView:switchReturnFlight];
    self.navigationItem.leftBarButtonItem = switchBarItem;
    
    onDetail = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 50, 35)];
    [onDetail setImage:[UIImage imageNamed:@"toolbar-button.png"] forState:UIControlStateNormal];
    [onDetail setImage:[UIImage imageNamed:@"toolbar-button-selected.png"] forState:UIControlStateHighlighted];
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
}

-(void) detail
{
    [self factor];
    NSInteger factor = [self factor];
    if(onDetail.selected) {
        [onDetail setSelected:NO];
        [onDetail setImage:[UIImage  imageNamed:@"toolbar-button.png"] forState:UIControlStateNormal];

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

-(void)switchToggled
{
    [self factor];
}

-(NSInteger )factor
{
    if (onDetail.selected) {
        if ([switchReturnFlight isOn]) {
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
    static NSString *CellIdentifier = @"Cell";
    
    Offer* offerObject = [[Offer alloc] init];
    Flight* flightObject = [[Flight alloc] init];
    FlightPassengersCount* passengersCount = [[FlightPassengersCount alloc] init];
    offerObject = [arrayOffers objectAtIndex:indexPath.section];
    flightObject = [arrayOffers objectAtIndex:indexPath.section];
    passengersCount = [arrayPassangers objectAtIndex:indexPath.section];
    flightObject = offerObject.flightDeparture;

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
    UIButton *button = [[UIButton alloc] initWithFrame: frameButton];
    UIImage * imgNormal = [UIImage imageNamed:@"btn-primary-for-light.png"];
    [button setBackgroundImage:imgNormal forState:UIControlStateNormal];
    [button setTitle: [NSString stringWithFormat:@"Купить за %@ руб.",[boothPrice stringValue]] forState: UIControlStateNormal];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        float marginNumberFlights = topGreenView.frame.size.height + 5;
        
        headerTableView = [[UIView alloc] initWithFrame:CGRectMake(mainFrame.origin.x,
                                                                   mainFrame.origin.y,
                                                                   mainFrame.size.width,
                                                                   factor*viewOneWay.frame.size.height + 20)];
        if (onDetail.selected) {
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

@end
