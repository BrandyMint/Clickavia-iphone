//
//  CAOrderInfo.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 19/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderInfo.h"
#import "CAColorSpecOffers.h"
#import "CAAssistView.h"
#import "CAOrderInfoPassportView.h"
#import "CAAppDelegate.h"
#import "SearchConditions.h"
#import "Destination.h"
#import "CAOrderRequirements.h"
#import "OfferConditions.h"
#import "NumberToString.h"

#define BUTTON_WIDTH 280
#define BUTTON_HEIGHT 50

@interface CAOrderInfo ()

@property (nonatomic, retain) UIScrollView* scrollView;

@end

@implementation CAOrderInfo

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showNavBar
{
    UIImage *navBackImage = [UIImage imageNamed:@"toolbar-back-icon.png"];
    UIButton *navBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [navBack setImage:navBackImage forState:UIControlStateNormal];
    navBack.frame = CGRectMake(0, 0, navBackImage.size.width, navBackImage.size.height);
    [navBack addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor COLOR_TITLE_TEXT];
    titleLabel.text = @"Данные перелета";
    titleLabel.layer.shadowOpacity = 0.4f;
    titleLabel.layer.shadowRadius = 0.0f;
    titleLabel.layer.shadowColor = [[UIColor COLOR_TITLE_TEXT_SHADOW] CGColor];
    titleLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [titleLabel sizeToFit];
    
    UIView* titleBarItemView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        titleLabel.frame.origin.x + titleLabel.frame.size.width,
                                                                        self.navigationController.navigationBar.frame.size.height/2)];
    [titleBarItemView addSubview:titleLabel];
    self.navigationItem.titleView = titleBarItemView;
    
    UIBarButtonItem *addCell =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTappedOnCell:)];
	self.navigationItem.rightBarButtonItem = addCell;
    
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil passports:(NSArray *)passports offer:(Offer *)offer specialOffer:(SpecialOffer *)specialOffer
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        Offer* offerdata = [Offer new];
        offerdata = offer;
        
        SpecialOffer* specialOfferdata = [SpecialOffer new];
        specialOfferdata = specialOffer;
        
        OfferConditions* offerConditions = [OfferConditions new];
        offerConditions = offerdata.offerConditions;
        
        SearchConditions* searchConditions = [SearchConditions new];
        searchConditions = offerConditions.searchConditions;
        
        Flight* flightDeparture = [Flight new];;
        Flight* flightReturn = [Flight new];
        flightDeparture = offerdata.flightDeparture;
        flightReturn = offerdata.flightReturn;
        
        NSArray* passportsArray = [NSArray new];
        passportsArray = passports;
        CGRect lastPassport = CGRectZero;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 180)];
        [self.view addSubview: _scrollView];
        
        CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:@"Заполняется в соответсвии с публичной офертой о заключении договора, размещенной на интернет-портале clickavia.ru" font:[UIFont fontWithName:@"HelveticaNeue" size:12] indentsBorder:5 background:NO];
        [_scrollView addSubview:assistView];
        
        [self createLineByBottom:[self getBottom:assistView.frame]];
        
    //блок паспортов пассажиров
        UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(10, [self getBottom:assistView.frame], 0, 0)];
        title.text = @"Пассажиры";
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        title.backgroundColor = [UIColor  clearColor];
        [title sizeToFit];
        [_scrollView addSubview:title];

        for (int i=0; i<passportsArray.count; i++) {
            PersonInfo* personInfo = [PersonInfo new];
            personInfo = [passportsArray objectAtIndex:i];
            
            CAOrderInfoPassportView* orderInfoPassportView = [[CAOrderInfoPassportView alloc] initWithpersonInfo:personInfo];
            CGRect orderInfoPassportFrame = orderInfoPassportView.frame;
            orderInfoPassportFrame.origin.y = [self getBottom:orderInfoPassportFrame]*(i+1);
            orderInfoPassportView.frame = orderInfoPassportFrame;
            lastPassport = orderInfoPassportFrame;
            [_scrollView addSubview:orderInfoPassportView];
        }
        
        [self createLineByBottom:[self getBottom:lastPassport]];
        
    //блок требований к билетам
        UILabel* requirements = [[UILabel alloc] initWithFrame:CGRectMake(10, [self getBottom:lastPassport], 0, 0)];
        requirements.text = @"Требования клиента к билетам";
        requirements.font = [UIFont systemFontOfSize:14];
        requirements.textAlignment = NSTextAlignmentCenter;
        requirements.backgroundColor = [UIColor  clearColor];
        [requirements sizeToFit];
        [_scrollView addSubview:requirements];
        
        Destination* destinationDeparture = [Destination new];
        destinationDeparture = searchConditions.direction_departure;
        Destination* destinationReturn = [Destination new];
        destinationReturn = searchConditions.direction_return;
        NSString* destination = [NSString stringWithFormat:@"%@ > %@", destinationDeparture.code, destinationReturn.code];
        NSString* dateDeparture = [self dateToddMMyyyy:flightDeparture.dateAndTimeDeparture];
        NSString* dateArrival = [self dateToddMMyyyy:flightDeparture.dateAndTimeArrival];
        
        if (specialOfferdata != nil) {
            if (specialOfferdata.isReturn) {
                destination = [NSString stringWithFormat:@"%@ > %@", [specialOfferdata.flightIds objectAtIndex:0], [specialOfferdata.flightIds objectAtIndex:1]];
                dateDeparture = [self dateToddMMyyyy:[specialOfferdata.dates objectAtIndex:0]];
                dateArrival = [self dateToddMMyyyy:[specialOfferdata.dates objectAtIndex:1]];
            }
            else
            {
                destination = [NSString stringWithFormat:@"%@", [specialOfferdata.flightIds objectAtIndex:0]];
                dateDeparture = [self dateToddMMyyyy:[specialOfferdata.dates objectAtIndex:0]];
            }
        }
        
        CAOrderRequirements* orderRequirements = [[CAOrderRequirements alloc] initWithRequirements:searchConditions.typeOfFlight
                                                                                     dateDeparture:dateDeparture
                                                                                       dateArrival:dateArrival
                                                                                        code:destination];
        CGRect orderRequirementsFrame = orderRequirements.frame;
        orderRequirementsFrame.origin.y = [self getBottom:requirements.frame];
        orderRequirements.frame = orderRequirementsFrame;
        [_scrollView addSubview:orderRequirements];
        
        NSInteger bottomY = [self getBottom:orderRequirements.frame];
        
        if (searchConditions.isBothWays) {
            CAOrderRequirements* orderRequirementsReturn = [[CAOrderRequirements alloc] initWithRequirements:searchConditions.typeOfFlight
                                                                                         dateDeparture:[self dateToddMMyyyy:flightReturn.dateAndTimeDeparture]
                                                                                           dateArrival:[self dateToddMMyyyy:flightReturn.dateAndTimeArrival]
                                                                                            code:destination];
            CGRect orderRequirementsReturnFrame = orderRequirementsReturn.frame;
            orderRequirementsReturnFrame.origin.y = [self getBottom:orderRequirements.frame];
            orderRequirementsReturn.frame = orderRequirementsReturnFrame;
            [_scrollView addSubview:orderRequirementsReturn];
            bottomY = [self getBottom:orderRequirementsReturnFrame];
        }
        
        [self createLineByBottom:bottomY];
        
    //Сумма и сведеия о перевозчике
        
        UILabel* info = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, bottomY + 10, 0, 0)];
        info.text = @"Сведения о перевозчике";
        info.font = [UIFont systemFontOfSize:12];
        [info sizeToFit];
        [_scrollView addSubview: info];
        
        UILabel* airlineTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, [self getBottom:info.frame], 0, 0)];
        airlineTitle.text = flightDeparture.airlineTitle;
        airlineTitle.font = [UIFont systemFontOfSize:12];
        [airlineTitle sizeToFit];
        [_scrollView addSubview: airlineTitle];
        
        UILabel* airlineSite = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, [self getBottom:airlineTitle.frame], 0, 0)];
        airlineSite.text = flightDeparture.airlineSite;
        airlineSite.font = [UIFont systemFontOfSize:12];
        [airlineSite sizeToFit];
        [_scrollView addSubview: airlineSite];
        
        if (searchConditions.isBothWays) {
            UILabel* airlineTitleReturn = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, [self getBottom:airlineSite.frame], 0, 0)];
            airlineTitleReturn.text = flightReturn.airlineTitle;
            airlineTitleReturn.font = [UIFont systemFontOfSize:12];
            [airlineTitleReturn sizeToFit];
            [_scrollView addSubview: airlineTitleReturn];
            
            UILabel* airlineSiteReturn = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, [self getBottom:airlineTitleReturn.frame], 0, 0)];
            airlineSiteReturn.text = flightReturn.airlineSite;
            airlineSiteReturn.font = [UIFont systemFontOfSize:12];
            [airlineSiteReturn sizeToFit];
            [_scrollView addSubview: airlineSiteReturn];
        }
        
        UILabel* sum = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, bottomY + 10, 0, 0)];
        sum.text = @"Общая сумма";
        sum.font = [UIFont systemFontOfSize:12];
        [sum sizeToFit];
        [_scrollView addSubview: sum];
        
        NSString* summ = [NSString stringWithFormat:@"%.0f р.", offerdata.bothPrice.floatValue];
        
        if (specialOfferdata != nil) {
            summ = [NSString stringWithFormat:@"%.0f р.", specialOfferdata.price.floatValue];
            info.text = nil;
        }
        
        UILabel* sumInfo = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, [self getBottom:sum.frame], 0, 0)];
            //pricelabel.text = [[NSString alloc] initWithFormat:@"%.0f р.", specialOfferData.price.floatValue];
        sumInfo.text = summ;
        sumInfo.font = [UIFont systemFontOfSize:12];
        [sumInfo sizeToFit];
        [_scrollView addSubview: sumInfo];
        
        
        NumberToString* nts = [[NumberToString alloc] init];
        NSString* numberToString = [nts numberToString:[summ integerValue]];
        
        UILabel* sumString = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, [self getBottom:sumInfo.frame], 140, 60)];
        sumString.text = numberToString;
        sumString.numberOfLines = 0;
        sumString.font = [UIFont systemFontOfSize:12];
        [_scrollView addSubview: sumString];
        
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self getBottom:sumString.frame]);

        UIButton* enter = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2,
                                                                     _scrollView.frame.origin.y + _scrollView.frame.size.height + 10,
                                                                     BUTTON_WIDTH,
                                                                     BUTTON_HEIGHT)];
        enter.titleLabel.textAlignment = NSTextAlignmentCenter;
        [enter setTitle:@"Да, заказ составлен верно, и все данные указаны правильно" forState:UIControlStateNormal];
        enter.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        enter.titleLabel.textAlignment = NSTextAlignmentCenter;
        enter.titleLabel.font = [UIFont systemFontOfSize:13];
        [enter setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
        [enter addTarget:self action:@selector(onNext:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:enter];
    }
    return self;
}

-(UIView*)requirementsView
{
    UIView* mainView = [UIView new];
    mainView.frame = CGRectMake(0, 0, 320, 10);
    mainView.backgroundColor = [UIColor orangeColor];
    return mainView;
}

-(NSInteger) getBottom:(CGRect)rect
{
    return rect.origin.y+rect.size.height + 1;
}

-(void) createLineByBottom:(NSInteger)yBottom
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, yBottom, self.view.frame.size.width, 1)];
    line.backgroundColor = [UIColor blackColor];
    [_scrollView addSubview:line];
}

-(NSString* )dateToddMMyyyy:(NSDate*)date
{
    NSDate * today = date;
    NSDateFormatter * date_format = [[NSDateFormatter alloc] init];
    [date_format setDateFormat: @"dd.MM.YYYY"];
    NSString * date_string = [date_format stringFromDate: today];
    return date_string;
}

-(void)onNext:(id)sender
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toRootNavigationView)
                                                 name:@"didSelectTab"
                                               object:nil];
}

- (void)toRootNavigationView {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
