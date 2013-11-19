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

@interface CAOrderInfo ()
{
    Offer* offerdata;
    Flight* flightDepartureObject;
    Flight* flightReturnObject;
}
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil passports:(NSArray *)passports offer:(Offer *)offer
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        offerdata = [Offer new];
        offerdata = offer;
        
        NSArray* passportsArray = [NSArray new];
        passportsArray = passports;
        CGRect lastPassport = CGRectZero;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(320.0f, 800.0f);
        [self.view addSubview: _scrollView];
        
        CAAssistView* assistView = [[CAAssistView alloc] initByAssistText:@"Заполняется в соответсвии с публичной офертой о заключении договора, размещенной на интернет-портале clickavia.ru" font:[UIFont fontWithName:@"HelveticaNeue" size:12] indentsBorder:5 background:NO];
        [_scrollView addSubview:assistView];
        
        [self createLineByBottom:[self getBottom:assistView.frame]];
        
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
        
        UILabel* requirements = [[UILabel alloc] initWithFrame:CGRectMake(10, [self getBottom:lastPassport], 0, 0)];
        requirements.text = @"Требования клиента к билетам";
        requirements.font = [UIFont systemFontOfSize:14];
        requirements.textAlignment = NSTextAlignmentCenter;
        requirements.backgroundColor = [UIColor  clearColor];
        [requirements sizeToFit];
        [_scrollView addSubview:requirements];
        
        CAAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        BOOL isBoothWays = appDelegate.isBothWays;
        
        SearchConditions* search = [SearchConditions new];
        search.typeOfFlight = appDelegate.typeOfFlight;
        
        NSInteger increment = 0;
        CGRect lastrequirementsView = CGRectZero;
        
        if (isBoothWays)
        {
            increment = 2;
            NSLog(@"туда обратно");
        }
        else
        {
            increment = 1;
            NSLog(@"туда");
        }
        
        for (int i = 0; i < increment; i++) {
            flightDepartureObject = [Flight new];
            flightReturnObject = [Flight new];
            
            offerdata.flightDeparture = flightDepartureObject;
            offerdata.flightReturn = flightReturnObject;
            
            UIView* view = [self requirementsView];
            [_scrollView addSubview:view];
            
            CGRect viewFrame = view.frame;
            viewFrame.origin.y = [self getBottom:viewFrame]*(i+1);
            view.frame = viewFrame;
            lastrequirementsView = viewFrame;

        }
        
        
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

@end
