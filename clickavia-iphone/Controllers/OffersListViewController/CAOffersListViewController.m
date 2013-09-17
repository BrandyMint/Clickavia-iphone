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

#define HEIGHT_GREEN_BAR 50
#define MARGIN_NUMBER_FLIGHT 5

@interface CAOffersListViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (retain, nonatomic) IBOutlet CAOfferGreenBar *topGreenView;

@property (weak, nonatomic) IBOutlet UILabel *topGreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberFlights;

@property (nonatomic, strong) CAColumnsControlView *columnDepartureControlView;
@property (nonatomic, strong) CAColumnsControlView *columnArrivialControlView;
@end

@implementation CAOffersListViewController
{
    NSMutableArray *offerArray;
    Offer *offer1, *offer2, *offer3;
    
    BOOL isReturn;
    //NSUInteger factor;
    CGRect mainFrame;
    UIBarButtonItem *onAddGreenBar;
    UIBarButtonItem *onReturn;
    float heightTable;
    NSUInteger counter;
    UISwitch *returnFly;
    UIView *viewOneWay;
    UIView *viewOnBack;
}
@synthesize columnDepartureControlView, columnArrivialControlView;
@synthesize tableOffers;
@synthesize scroll;
@synthesize topGreenView;
@synthesize topGreenLabel, numberFlights;

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
    self.title = @"Москва - Краснодар";
    tableOffers.scrollEnabled = NO;
    
    [topGreenView setFrame:CGRectMake(self.view.frame.origin.x,
                                      self.view.frame.origin.y,
                                      self.view.frame.size.width,
                                      HEIGHT_GREEN_BAR)];
    
    onAddGreenBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(bar)];
    self.navigationItem.rightBarButtonItem = onAddGreenBar;
    
    returnFly = [[UISwitch alloc] init];
    [returnFly addTarget:self action:@selector(switchToggled) forControlEvents: UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:returnFly];
    self.navigationItem.leftBarButtonItem = item;
    
    UITapGestureRecognizer *tapGreenBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bar)];
    [topGreenView addGestureRecognizer:tapGreenBar];
    topGreenView.userInteractionEnabled = YES;
    
    offerArray = [[NSMutableArray alloc] init];
    offer1 = [[Offer alloc] init];
    offer1.isSpecial = NO;
    [offerArray addObject:offer1];
    offer2 = [[Offer alloc] init];
    offer2.isSpecial = YES;
    [offerArray addObject:offer2];
    offer3 = [[Offer alloc] init];
    offer3.isSpecial = NO;
    [offerArray addObject:offer3];
    
    heightTable = [self heightScrollView];
}

-(void) viewWillAppear:(BOOL)animated
{
    mainFrame = self.view.frame;
    NSInteger factor = [self factor];
    
    NSArray *departureFlights = [CAColumnMockDates generateFlyToDates];
    
    viewOneWay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 150)];
    viewOnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 300)];

    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 150) title:@"туда" flight_kind:@"" withTarget:nil];
    columnDepartureControlView.delegate = (id)self;
    
    [columnDepartureControlView importFlights: departureFlights];
    
    columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 150, mainFrame.size.width, 150) title:@"обратно" flight_kind:@"" withTarget:nil];
    
    numberFlights.text = @"Доступно перелетов: 3";
    CGSize textSize = [numberFlights.text sizeWithFont:[UIFont fontWithName:@"Arial" size:14]];
    numberFlights.frame = CGRectMake(mainFrame.origin.x,
                                     viewOneWay.frame.size.height + MARGIN_NUMBER_FLIGHT,
                                     mainFrame.size.width,
                                     textSize.height);
    
    tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                   viewOneWay.frame.size.height + numberFlights.frame.size.height + 2*MARGIN_NUMBER_FLIGHT,
                                   mainFrame.size.width,
                                   heightTable);

    
    scroll.frame = CGRectMake(mainFrame.origin.x,
                              mainFrame.origin.y,
                              mainFrame.size.width,
                              mainFrame.size.height) ;
    scroll.contentSize = CGSizeMake(mainFrame.size.width,
                                    viewOneWay.frame.size.height + heightTable + numberFlights.frame.size.height);
    [scroll setContentOffset:CGPointMake(0, viewOneWay.frame.size.height - topGreenView.frame.size.height) animated:NO];
}

-(void)bar
{
    [self factor];
    NSInteger heightFrame = 0;
    if (isReturn) {
        [viewOneWay removeFromSuperview];
        [viewOnBack removeFromSuperview];
        [viewOnBack addSubview:columnDepartureControlView];
        [viewOnBack addSubview:columnArrivialControlView];
        [scroll addSubview:viewOnBack];
        heightFrame = viewOnBack.frame.size.height;
        
        numberFlights.frame = CGRectMake(mainFrame.origin.x,
                                         heightFrame + MARGIN_NUMBER_FLIGHT,
                                         numberFlights.frame.size.width,
                                         numberFlights.frame.size.height);
        
        tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                       heightFrame + numberFlights.frame.size.height + 2*MARGIN_NUMBER_FLIGHT,
                                       tableOffers.frame.size.width,
                                       tableOffers.frame.size.height);
    }
    else {
        [viewOneWay removeFromSuperview];
        [viewOnBack removeFromSuperview];
        [viewOneWay addSubview:columnDepartureControlView];
        [scroll addSubview:viewOneWay];
        heightFrame = viewOneWay.frame.size.height;
        
        numberFlights.frame = CGRectMake(mainFrame.origin.x,
                                         heightFrame + MARGIN_NUMBER_FLIGHT,
                                         numberFlights.frame.size.width,
                                         numberFlights.frame.size.height);
        
        tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                       heightFrame + numberFlights.frame.size.height + 2*MARGIN_NUMBER_FLIGHT,
                                       tableOffers.frame.size.width,
                                       tableOffers.frame.size.height);
    }
    
    counter++;
    if (counter%2 == 0) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenLabel.alpha = topGreenView.alpha = 1;
        [scroll setContentOffset:CGPointMake(0, heightFrame - topGreenView.frame.size.height) animated:YES];
        /*
        scroll.frame = CGRectMake(columnDepartureControlView.frame.origin.x,
                                  topGreenView.frame.size.height,
                                  scroll.frame.size.width,
                                  scroll.frame.size.height);
         */
        [UIView commitAnimations];

    }
    else {
        counter = 1;
        [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenLabel.alpha = topGreenView.alpha = 0;
        /*
        scroll.frame = CGRectMake(columnDepartureControlView.frame.origin.x,
                                   0,
                                   scroll.frame.size.width,
                                   scroll.frame.size.height);
         */
        [UIView commitAnimations];
    }
}

-(void)switchToggled
{
    [self factor];
}

-(NSInteger )factor
{
    if ([returnFly isOn]) {
        isReturn = YES;
        NSLog(@"on");
        return 2;
    }
    isReturn = NO;
    NSLog(@"off");
    return 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return offerArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = [offerArray objectAtIndex:indexPath.section];
    if(offer.isSpecial)
        return CELL_HEIGHT_SPECIAL;
    else
        return CELL_HEIGHT_NORMAL;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return MARGIN_NUMBER_FLIGHT;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OfferCell";
    
    CAOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CAOfferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = [offerArray objectAtIndex:indexPath.section];
    CAOfferCell *customCell = (CAOfferCell*)cell;

    customCell.backgroundView = [[UIView alloc] initWithFrame:customCell.frame];
    
    [customCell initByOfferModel:offer];
}

- (float)heightScrollView
{
    float heightScroll = 0.0;
    for (int i = 0; i < offerArray.count; i++) {
        Offer *offer = [offerArray objectAtIndex:i];
        if (offer.isSpecial) {
           heightScroll += CELL_HEIGHT_SPECIAL;
        }
        else{
            heightScroll += CELL_HEIGHT_NORMAL;
        }
        heightScroll += MARGIN_NUMBER_FLIGHT;  
    }
    heightScroll += 2*MARGIN_NUMBER_FLIGHT;
    return heightScroll;
}

@end
