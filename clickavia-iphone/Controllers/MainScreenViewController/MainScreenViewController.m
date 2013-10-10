//
//  MainScreenViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 22.08.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "MainScreenViewController.h"
#import "CAOffersListViewController.h"

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

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}


-(void) viewDidAppear:(BOOL)animated
{
    
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    returnDate = appDelegate.offerConditions.returnDate;
    departureDate = appDelegate.offerConditions.departureDate;
    
    if(departureDate!=nil)
    {
        [_calendarView selectDate:departureDate];
    }
    if(returnDate!=nil)
    {
        [_calendarView selectDate:returnDate];
    }
    
    if (_calendarView.flyToDate){
        _findButton_outlet.enabled = YES;
        NSLog(@"find button enabled %@", _calendarView.flyToDate);
    }
    else {
        _findButton_outlet.enabled = NO;
        NSLog(@"find button disabled");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor darkGrayColor]];
    
    cm = [CitiesManager new];
    cm.delay = 500;
    fm = [FlightsManager new];
    departureDates = [NSArray new];
    returnDates = [NSArray new];
    
    _searchForm.viewForSpawnSubviews = self.view;
    _searchForm.citiesManager = cm;
    _searchForm.delegate = self;
    [_searchForm setBothWaySwitch:YES withAnimation:NO];
    
    //указываем тип кнопки (green or gray)
    [_searchForm setTypeButton:green];
    
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.passengersCount = _searchForm.searchParameters.passengerCount; // проброс количества пассажиров
    
    currentSearchConditions = [[SearchConditions alloc] init];
    currentSearchConditions.isBothWays = YES;
    currentSearchConditions.countOfTickets = [[NSNumber alloc] initWithInt:1];
    currentSearchConditions.typeOfFlight = econom;
    currentSearchConditions.direction_departure = nil;
    currentSearchConditions.direction_return = nil;

    [_calendarView setDelegate:self];
  
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        CGRect calendarViewFrame = CGRectZero;
        calendarViewFrame.origin.x = 0;
        calendarViewFrame.origin.y = _searchForm.frame.origin.y + _searchForm.frame.size.height;
        calendarViewFrame.size.width = [[UIScreen mainScreen] bounds].size.width;
    
        CGRect findFrame = _findButton_outlet.frame;
        findFrame.size.width = 200.0f;
        findFrame.size.height = 37.0f;
        findFrame.origin.x = 59.0f;
        _findButton_outlet.enabled = NO;
        _findButton_outlet.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_findButton_outlet setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
        _findButton_outlet.titleLabel.textColor = [UIColor whiteColor];
    
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                if (screenSize.height > 480.0f) {
                        //Do iPhone 5 stuff here.
                        calendarViewFrame.size.height = 370;
                        _calendarView = [[CACalendarView alloc] initWithFrame:calendarViewFrame];
                        [self.view addSubview: _calendarView];
                    
        
                    } else {
                            //Do iPhone Classic stuff here.
                            calendarViewFrame.size.height = 280;
                            _calendarView = [[CACalendarView alloc] initWithFrame:calendarViewFrame];
                            [self.view addSubview: _calendarView];
                
                
                        }
            } else {
                    //Do iPad stuff here.
                }
    
        _calendarView.delegate = self;
        findFrame.origin.y = _calendarView.frame.origin.y + _calendarView.frame.size.height + 10;
       _findButton_outlet.frame = findFrame;

    
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
    returnDates = nil;
    departureDates = nil;
    departureDate = nil;
    returnDate = nil;
    [_calendarView resetSelections];
    [self reloadDatesDeparture];
}

- (void) searchFormView:(CASearchFormView *)CASearchFormView didSelectPassengersCount:(CAFlightPassengersCount *)passengersCount
{
    CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.passengersCount = passengersCount; // проброс количества пассажиров

    //without infants
    currentSearchConditions.countOfTickets = [[NSNumber alloc ]initWithInteger:(passengersCount.adultsCount + passengersCount.childrenCount)];
}

- (void) searchFormView:(CASearchFormView*)searchFormView didSelectBothWays:(BOOL)isBothWays
{
    if(isBothWays)
    {
                NSLog(@"both way");
        if(returnDate==nil && departureDate != nil)
        {
            NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
            dayComponent.day = 7;
            NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dayComponent toDate:departureDate options:0];
//            [_calendarView selectDate:date];
            returnDate = date;
        }
        else
        {
            /*if(_calendarView.flyReturnDate!=nil)
            {
                returnDate = _calendarView.flyReturnDate;
            }*/
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
    if(currentSearchConditions.direction_departure!=nil&&currentSearchConditions.direction_return!=nil)
    {
        //если все направления выбраны - грузим даты туда
        //и не забудем сбросить условия поиска
        returnDates = nil;
        departureDates = nil;
        departureDate = nil;
        returnDate = nil;
        [self reloadDatesDeparture];
    }
    else
    {
        //скорее всего какой-то пункт назначения был сброшен
        returnDates = nil;
        departureDates = nil;
        departureDate = nil;
        returnDate = nil;
        [self updateCalendarDates];
    }
    
}

-(void) searchFormView:(CASearchFormView *)searchFormView selectedArrivalDestination:(Destination *)destination
{
    currentSearchConditions.direction_return = destination;
    if(currentSearchConditions.direction_departure!=nil&&currentSearchConditions.direction_return!=nil)
    {
        //если все направления выбраны - грузим даты туда
        returnDates = nil;
        departureDates = nil;
        departureDate = nil;
        returnDate = nil;
        [self reloadDatesDeparture];
    }
    else
    {
        //скорее всего какой-то пункт назначения был сброшен
        returnDates = nil;
        departureDates = nil;
        departureDate = nil;
        returnDate = nil;
        [_calendarView resetSelections];
        [self updateCalendarDates];
    }
}

#pragma mark CACalendarViewDelegate

- (void) whatHappeningWithDates:(NSDate*)date
{

}
- (void) calendarView:(CACalendarView*)calendarView didSelectDate:(NSDate*)date
{
    NSLog(@"%@",date);
    
    if(departureDate==nil)
    {
        //была выбрана дата туда
        departureDate = _calendarView.flyToDate;
        if(departureDate==nil)
        {
            //но все-таки ее сбросили
            [_calendarView resetSelections];
            [self reloadDatesDeparture];
            return;
        }
        else
        {
            //дату туда выбрали
            [_calendarView resetSelections];
            [self reloadDatesReturn];
            [_searchForm setBothWaySwitch:YES withAnimation:YES];
            return;
        }
    }
    else
    {
        if(_calendarView.flyToDate==nil)
        {
            //была сброшена туда 100%
            departureDate = nil;
            returnDate = nil;
            [_calendarView resetSelections];
            [self reloadDatesDeparture];
            [_searchForm setBothWaySwitch:NO withAnimation:YES];
            return;
        }
        else
        {
            if([CACalendarView compareDate:date and:_calendarView.flyToDate]==NSOrderedSame)
            {
                departureDate = _calendarView.flyToDate;
                [_calendarView resetSelections];
                [self reloadDatesReturn];
                return;
                //была изменена дата туда
            }
        }
    }
    if(returnDate==nil)
    {
        //была выбрана дата оттуда
        returnDate = _calendarView.flyReturnDate;
        [_searchForm setBothWaySwitch:YES withAnimation:YES];
    }
    else
    {
        if(_calendarView.flyReturnDate==nil)
        {
            //дата оттуда была сброшена
            returnDate = nil;
            [_searchForm setBothWaySwitch:NO withAnimation:YES];
        }
        else
        {
            //дата оттуда была изменена
            returnDate = _calendarView.flyReturnDate;
        }
    }
}

- (void) calendarView:(CACalendarView *)calendarView didSelectMonth:(NSDate *)date
{
    NSLog([date description]);
}
- (void) reloadDatesDeparture
{
//    [_calendarView resetSelections];
    [fm getAvailableDepartureDates:currentSearchConditions departureDate:nil completeBlock:^(NSArray *dates)
     {
         departureDates = dates;
         NSLog(@"departureDates: %@", departureDates);
         [self updateCalendarDates];
     }];
}

- (void) reloadDatesReturn
{
//    [_calendarView resetSelections];
    [fm getAvailableReturnDates:currentSearchConditions withDepartureDate:departureDate completeBlock:^(NSArray *array)
     {
         returnDates = array;
         NSLog(@"returnDates: %@", returnDates);
         [self updateCalendarDates];
     }];
}


-(void)updateCalendarDates
{

    [_calendarView selectFlyToDaysByDateArray:departureDates];
    [_calendarView selectFlyReturnDaysByDateArray:returnDates];
    if(departureDate!=nil)
    {
         if(![CACalendarView compareDate:_calendarView.flyToDate and:departureDate])
         {
             [_calendarView selectDate:departureDate];
         }

    }
    if(returnDate!=nil)
    {
        if(![CACalendarView compareDate:_calendarView.flyReturnDate and:returnDate])
        {
            [_calendarView selectDate:returnDate];
            currentSearchConditions.isBothWays = YES;
        }
    }
    
    if(_calendarView.flyToDate!=nil)
    {
        _findButton_outlet.enabled = YES;
    }
    else
    {
        _findButton_outlet.enabled = NO;
    }
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
        OfferConditions *fc = [[OfferConditions alloc] initWithSearchConditions:currentSearchConditions withDepartureDate:_calendarView.flyToDate andReturnDate:_calendarView.flyReturnDate];
        appDelegate.offerConditions = fc;
        return fc;
    }
}

- (IBAction)find:(id)sender
{
    [self getOfferConditions];
    CAOffersListViewController* caOffersListViewController = [[CAOffersListViewController alloc] initWithNibName:@"CAOffersListViewController" bundle:Nil isBothWays:currentSearchConditions.isBothWays];
    [self.navigationController pushViewController:caOffersListViewController animated:YES];
}
    
@end
