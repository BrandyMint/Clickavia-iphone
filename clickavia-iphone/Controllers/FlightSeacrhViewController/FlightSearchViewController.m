//
//  MainScreenViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "FlightSearchViewController.h"

@interface FlightSearchViewController ()

@end

@implementation FlightSearchViewController

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
    
    cm = [CitiesManager new];
    cm.delay = 10;
    fm = [FlightsManager new];
    departureDates = [NSArray new];
    returnDates = [NSArray new];
    _departureCompleteView.offsetTopForAutocomplete = _departureCompleteView.frame.origin.y+_departureCompleteView.frame.size.height;
    _returnCompleteView.offsetTopForAutocomplete = _returnCompleteView.frame.origin.y+_departureCompleteView.frame.size.height;
    _departureCompleteView.offsetLeftTriangleForAutocomplete = 40;
    _returnCompleteView.offsetLeftTriangleForAutocomplete = self.view.frame.size.width-60;
    
    
    currentSearchConditions = [[SearchConditions alloc] init];
    currentSearchConditions.isBothWays = NO;
    currentSearchConditions.countOfTickets = [[NSNumber alloc] initWithInt:1];
    currentSearchConditions.typeOfFlight = econom;
    currentSearchConditions.direction_departure = nil;
    currentSearchConditions.direction_return = nil;
    
    [self setupTextForFlightTypeButton];
    [self setupSwitchBoth];
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

#pragma mark CAFieldCompleteViewDelegate
- (void)fieldCompleteView:(CAFieldCompleteView*) fieldCompleteView selectedDestination:(Destination*) destination
{
    [self setupDestinationFrom:fieldCompleteView withValue:destination];
    [self reloadDates];
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

#pragma mark CACalendarViewDelegate

- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    if(_calendarView.flyToDate!=nil)
    {
        if([CACalendarView compareDate:_calendarView.flyToDate and:date]==NSOrderedSame)
        {
            NSLog(@"Была выбрана дата вылета");
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
-(void)setupDestinationFrom:(CAFieldCompleteView*) fieldCompleteView withValue:(Destination*) destination
{
    if(fieldCompleteView==_departureCompleteView)
    {
        currentSearchConditions.direction_departure = destination;
    }
    else
    {
        currentSearchConditions.direction_return = destination;
    }
    [self reloadDates];
}
- (void)setupSwitchBoth
{
    [_switchBoth setOn:currentSearchConditions.isBothWays];
    if(currentSearchConditions.isBothWays)
    {
        _switchDescription.text = @"Both";
    }
    else
    {
        _switchDescription.text = @"1 way";
    }
}
- (IBAction)changeFlightType:(id)sender
{
    currentSearchConditions.typeOfFlight = currentSearchConditions.typeOfFlight==econom?business:econom;
    [self setupTextForFlightTypeButton];
    [self reloadDates];
}
- (void)setupTextForFlightTypeButton
{
    NSString *title;
    if(currentSearchConditions.typeOfFlight==econom)
    {
        title = @"Эконом";
    }
    else
    {
        title = @"Бизнес";
    }
    
    [_flightClassButton setTitle: title forState: UIControlStateNormal];
    [_flightClassButton setTitle: title forState: UIControlStateHighlighted];
    [_flightClassButton setTitle: title forState: UIControlStateSelected];
    [self reloadDates];
}
- (IBAction)changeIsBothWays:(id)sender
{
    currentSearchConditions.isBothWays = _switchBoth.isOn;
    if(currentSearchConditions.isBothWays)
    {
        _switchDescription.text = @"Both";
    }
    else
    {
        _switchDescription.text = @"1 way";
    }
    [self reloadDates];
}

- (SearchConditions*)getSearchConditions
{
    return currentSearchConditions;
}

@end
