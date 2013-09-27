//
//  MainScreenViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "MainScreenViewController.h"

@interface MainScreenViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *topGreenImage;

@end

@implementation MainScreenViewController

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
    self.navigationController.navigationBarHidden = YES;

    
    _calendarView.frame = CGRectMake(0, 100, self.view.frame.size.width, 300);
    //_departureCompleteView.backgroundColor = [UIColor orangeColor];
    
    cm = [CitiesManager new];
    cm.delay = 500;
    fm = [FlightsManager new];
    departureDates = [NSArray new];
    returnDates = [NSArray new];
    
    _searchForm.viewForSpawnSubviews = self.view;
    _searchForm.citiesManager = cm;
    
    currentSearchConditions = [[SearchConditions alloc] init];
    currentSearchConditions.isBothWays = NO;
    currentSearchConditions.countOfTickets = [[NSNumber alloc] initWithInt:1];
    currentSearchConditions.typeOfFlight = econom;
    currentSearchConditions.direction_departure = nil;
    currentSearchConditions.direction_return = nil;
    
    //[self setupTextForFlightTypeButton];
    //[self setupSwitchBoth];
    
    [_calendarView setDelegate:self];
    [_calendarView selectFlyToDaysByDateArray:[CACalendarMockDates generateFlyToDates]];
    [_calendarView selectFlyReturnDaysByDateArray:[CACalendarMockDates generateFlyReturnDates:[NSDate date]]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Tab Bar delegate methods

- (NSString *)tabTitle
{
	return @"Календарь";
}

-(NSString*)tabImageName
{
    return nil;
}

- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    if(_calendarView.flyToDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            NSLog(@"Была выбрана дата вылета");
        }
    }
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        NSLog(@"IPAD");
    }
    else
    {
        NSLog(@"IPhone");
    }
    
    NSLog([date description]);
}
- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    NSLog([date description]);
}

#pragma mark CAFieldCompleteViewDelegate
- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView selectedDestination:(Destination*) destination
{
    //[self setupDestinationFrom:fieldCompleteView withValue:destination];
    //[self reloadDates];
}

- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView textChanged:(NSString*) text
{
    if(fieldCompleteView == _departureCompleteView)
    {
        [cm getDestinationsForDeparture:text completeBlock:^(NSArray *array)
         {
             [_departureCompleteView setAutocompleteData:array];
         }];
    }
    if(fieldCompleteView == _returnCompleteView)
    {
        [cm getDestinationsForReturn:text forDepartureDestination:currentSearchConditions.direction_departure completeBlock:^(NSArray *array)
         {
             [_returnCompleteView setAutocompleteData:array];
         }];
    }
}

-(void)fieldCompleteViewBeginEditing:(CAFieldCompleteView *)fieldCompleteView
{
    if(fieldCompleteView == _departureCompleteView)
    {
        [cm getDestinationsForDeparture:_departureCompleteView.text completeBlock:^(NSArray *array)
         {
             [_departureCompleteView setAutocompleteData:array];
         }];
    }
    if(fieldCompleteView == _returnCompleteView)
    {
        [cm getDestinationsForReturn:_returnCompleteView.text forDepartureDestination:currentSearchConditions.direction_departure completeBlock:^(NSArray *array)
         {
             [_returnCompleteView setAutocompleteData:array];
         }];
    }
}

- (IBAction)find:(id)sender
{
    //[self getOfferConditions];
}
@end
