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

@interface CAOffersListViewController ()
@property (nonatomic, strong) CAColumnsControlView *columnDepartureControlView;
@property (nonatomic, strong) CAColumnsControlView *columnArrivialControlView;
@end

@implementation CAOffersListViewController
{
    NSMutableArray *offerArray;
    Offer *offer1, *offer2, *offer3;
}
@synthesize columnDepartureControlView, columnArrivialControlView;
@synthesize tableOffers;

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
    
    //self.navigationController.navigationBarHidden = YES;
    self.title = @"Москва - Краснодар";
    
    NSArray *departureFlights = [CAColumnMockDates generateFlyToDates];
    
    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(1, 1, self.view.frame.size.width-2, 150-2) title:@"туда" withTarget:self];
    columnDepartureControlView.delegate = (id)self;
    [self.view addSubview:columnDepartureControlView];
    [columnDepartureControlView importFlights: departureFlights];
    
    columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(1, columnDepartureControlView.frame.size.height+2, self.view.frame.size.width-2, 150-2)
                                 title:@"обратно"
                            withTarget:nil];
    [self.view addSubview:columnArrivialControlView];
    
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
}

-(void) viewWillAppear:(BOOL)animated
{
    tableOffers.frame = CGRectMake(1, columnArrivialControlView.frame.origin.y+columnArrivialControlView.frame.size.height,
                                   self.view.frame.size.width-2, 170);
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
    return 3;
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

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

@end
