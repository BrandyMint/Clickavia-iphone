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
    NSUInteger factor;
    CGRect mainFrame;
    UIBarButtonItem *onAddGreenBar;
    float heightTable;
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

-(void) viewWillAppear:(BOOL)animated
{
    mainFrame = self.view.frame;

    tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                   factor*columnDepartureControlView.frame.size.height + numberFlights.frame.size.height + 2*MARGIN_NUMBER_FLIGHT,
                                   mainFrame.size.width,
                                   heightTable);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isReturn = YES;
    self.navigationController.navigationBarHidden = NO;
    self.title = @"Москва - Краснодар";
    tableOffers.scrollEnabled = NO;
    
    [topGreenView setFrame:CGRectMake(self.view.frame.origin.x,
                                      self.view.frame.origin.y,
                                      self.view.frame.size.width,
                                      HEIGHT_GREEN_BAR)];
    
    onAddGreenBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(bar)];
    self.navigationItem.rightBarButtonItem = onAddGreenBar;
    
    NSArray *departureFlights = [CAColumnMockDates generateFlyToDates];
    
    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150) title:@"туда" withTarget:nil];
    columnDepartureControlView.delegate = (id)self;
    [scroll addSubview:columnDepartureControlView];
    
    [columnDepartureControlView importFlights: departureFlights];
    
    if (isReturn) {
        columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(columnDepartureControlView.frame.origin.x,
                                                                                           columnDepartureControlView.frame.size.height,
                                                                                           self.view.frame.size.width,
                                                                                           columnDepartureControlView.frame.size.height)
                                                                          title:@"обратно"
                                                                     withTarget:nil];
        [scroll addSubview:columnArrivialControlView];
        factor = 2;
    }
    else{
        factor = 1;
    }
    
    numberFlights.text = @"Доступно перелетов: 3";
    CGSize textSize = [numberFlights.text sizeWithFont:[UIFont fontWithName:@"Arial" size:14]];
    numberFlights.frame = CGRectMake(0,
                                     factor*columnDepartureControlView.frame.size.height + MARGIN_NUMBER_FLIGHT,
                                     self.view.frame.size.width,
                                     textSize.height);
    
    UITapGestureRecognizer *tapGreenBar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushGreenBar)];
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
    scroll.frame = CGRectMake(columnDepartureControlView.frame.origin.x,
                              topGreenView.frame.size.height,
                              scroll.frame.size.width,
                              scroll.frame.size.height) ;
    scroll.contentSize = CGSizeMake(mainFrame.size.width,
                                    factor*columnDepartureControlView.frame.size.height + numberFlights.frame.size.height + 2*MARGIN_NUMBER_FLIGHT + heightTable);
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> %f %f %d %f",
          factor*columnDepartureControlView.frame.size.height, numberFlights.frame.size.height, 2*MARGIN_NUMBER_FLIGHT, heightTable);
    
    [scroll setContentOffset:CGPointMake(0, factor*columnDepartureControlView.frame.size.height) animated:NO];
}

-(void)bar
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    topGreenLabel.alpha = topGreenView.alpha = 1;
    [scroll setContentOffset:CGPointMake(0, factor*columnDepartureControlView.frame.size.height) animated:YES];
    scroll.frame = CGRectMake(columnDepartureControlView.frame.origin.x,
                              topGreenView.frame.size.height,
                              scroll.frame.size.width,
                              scroll.frame.size.height);
    [UIView commitAnimations];
}

-(void) pushGreenBar
{
    [scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    topGreenLabel.alpha = topGreenView.alpha = 0;
    scroll.frame = CGRectMake(columnDepartureControlView.frame.origin.x,
                              0,
                              scroll.frame.size.width,
                              scroll.frame.size.height);
    [UIView commitAnimations];
        
    if (isReturn) {
        factor = 2;
    }
    else{
        factor = 1;
    }
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
    return heightScroll;
}

@end
