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
    
    _calendarView.frame = CGRectMake(0, 100, self.view.frame.size.width, 380);

    cm = [CitiesManager new];
    cm.delay = 500;
    fm = [FlightsManager new];
    departureDates = [NSArray new];
    returnDates = [NSArray new];
    
    _searchForm.viewForSpawnSubviews = self.view;
    _searchForm.citiesManager = cm;
    _searchForm.delegate = self;
    
    currentSearchConditions = [[SearchConditions alloc] init];
    currentSearchConditions.isBothWays = NO;
    currentSearchConditions.countOfTickets = [[NSNumber alloc] initWithInt:1];
    currentSearchConditions.typeOfFlight = econom;
    currentSearchConditions.direction_departure = nil;
    currentSearchConditions.direction_return = nil;
    
    [_calendarView setDelegate:self];
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

#pragma mark CASearchFormViewDelegate
- (void) searchFormView:(CASearchFormView *)searchFormView didSelectClassOfFlight:(flightType)typeOfFlight
{
    currentSearchConditions.typeOfFlight = typeOfFlight;
    [self reloadDates];
}

- (void) searchFormView:(CASearchFormView *)CASearchFormView didSelectPassengersCount:(CAFlightPassengersCount *)passengersCount
{
    //without infants
    currentSearchConditions.countOfTickets = [[NSNumber alloc ]initWithInteger:(passengersCount.adultsCount + passengersCount.childrenCount)];
    [self reloadDates];
}

- (void) searchFormView:(CASearchFormView*)searchFormView didSelectBothWays:(BOOL)isBothWays
{
    if(isBothWays)
    {
        NSLog(@"both way");
        
        if(_calendarView.flyReturnDate==nil && _calendarView.flyToDate != nil)
        {
            NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
            dayComponent.day = 7;
            
            [_calendarView selectDate:[[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:_calendarView.flyToDate options:0]];
            returnDate = _calendarView.flyReturnDate;
        }
    }
    else
    {
        NSLog(@"one way");
        
        if(_calendarView.flyReturnDate!=nil)
        {
            [_calendarView selectDate:_calendarView.flyReturnDate];
            returnDate = nil;
        }
    }
    
    currentSearchConditions.isBothWays = isBothWays;
}

- (void) searchFormView:(CASearchFormView *)searchFormView selectedDepartureDestination:(Destination *)destination
{
    currentSearchConditions.direction_departure = destination;
    [self reloadDates];
}

-(void) searchFormView:(CASearchFormView *)searchFormView selectedArrivalDestination:(Destination *)destination
{
    currentSearchConditions.direction_return = destination;
    [self reloadDates];
}

#pragma mark CACalendarViewDelegate

- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    if(_calendarView.flyToDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            departureDate = date;
        }
        
        if(_calendarView.flyReturnDate!=nil)
        {
            if(currentSearchConditions.isBothWays == NO)
            {
                [_searchForm setBothWaySwitch:YES withAnimation:YES];
            }
        }
        else
        {
            if(currentSearchConditions.isBothWays == YES)
            {
                [_searchForm setBothWaySwitch:NO withAnimation:YES];
            }
        }
    }
    if(_calendarView.flyReturnDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            returnDate = date;
        }
    }
    
    if(_calendarView.flyToDate==nil)
    {
        if(currentSearchConditions.isBothWays == YES)
        {
            [_searchForm setBothWaySwitch:NO withAnimation:YES];
        }
    }
}

- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    
}

- (void) reloadDates
{
    if(currentSearchConditions.direction_departure!=nil&&currentSearchConditions.direction_return!=nil)
    {
        [_calendarView resetSelections];
        [fm getAvailableDepartureDates:currentSearchConditions departureDate:[NSDate date] completeBlock:^(NSArray *dates)
         {
             departureDates = dates;
             [fm getAvailableReturnDates:currentSearchConditions withDepartureDate:[NSDate date] completeBlock:^(NSArray *array)
              {
                  returnDates = array;
                  [self updateCalendarDates];
              }];
             
         }];
    }
    else
    {
        [_calendarView resetSelections];
    }
}
-(void)updateCalendarDates
{
    [_calendarView selectFlyToDaysByDateArray:departureDates];
    [_calendarView selectFlyReturnDaysByDateArray:returnDates];
}

- (SearchConditions*)getSearchConditions
{
    if(currentSearchConditions.direction_departure==nil||currentSearchConditions.direction_return==nil)
        return nil;
    return currentSearchConditions;
}
- (OfferConditions*)getOfferConditions
{
    if([self getSearchConditions]==nil)
        return  nil;
    else
    {
        CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        OfferConditions *fc = [[OfferConditions alloc] initWithSearchConditions:currentSearchConditions withDepartureDate:departureDate andReturnDate:returnDate];
        appDelegate.offerConditions = fc;
        return fc;
    }
}
- (IBAction)find:(id)sender
{
    [self getOfferConditions];
}
@end
