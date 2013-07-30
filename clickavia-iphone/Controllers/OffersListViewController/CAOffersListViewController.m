//
//  CAOffersListViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOffersListViewController.h"
#import "CAColumnsControlView.h"
#import "MockDates.h"
#import "Flight.h"

@interface CAOffersListViewController ()
@property (nonatomic, strong) CAColumnsControlView *columnDepartureControlView;
@property (nonatomic, strong) CAColumnsControlView *columnArrivialControlView;
@end

@implementation CAOffersListViewController
@synthesize columnDepartureControlView, columnArrivialControlView;

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
    
    NSArray *departureFlights = [MockDates generateFlyToDates];
    
    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(1, 1, self.view.frame.size.width-2, 150-2) type:caDepartureType];
    columnDepartureControlView.delegate = (id)self;
    [self.view addSubview:columnDepartureControlView];
    [columnDepartureControlView reloadData: departureFlights];
    
    columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(1, columnDepartureControlView.frame.size.height+2, self.view.frame.size.width-2, 150-2) type:caArrivialType];
    [self.view addSubview:columnArrivialControlView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)columnsControlView:(CAColumnsControlView *)columnsControlView didSelectColumnWithObject:(Flight*)flight
{
    NSArray *arrivialFlights = [MockDates generateFlyReturnDates:flight.dateAndTimeDeparture];
    [columnArrivialControlView reloadData: arrivialFlights];
}

@end
