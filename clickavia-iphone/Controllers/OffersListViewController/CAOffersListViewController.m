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
#define SectionHeaderHeight 170

@interface CAOffersListViewController ()
@property (retain, nonatomic) IBOutlet CAOfferGreenBar *topGreenView;

@property (weak, nonatomic) IBOutlet UILabel *topGreenLabel;

@property (nonatomic, strong) CAColumnsControlView *columnDepartureControlView;
@property (nonatomic, strong) CAColumnsControlView *columnArrivialControlView;
@end

@implementation CAOffersListViewController
{
    NSMutableArray *offerArray;
    Offer *offer1, *offer2, *offer3;
    
    BOOL isReturn;
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
@synthesize topGreenView;
@synthesize topGreenLabel;

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

    tableOffers.scrollEnabled = YES;
    topGreenLabel.text = @"Москва - Краснодар";
    
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
}

-(void) viewWillAppear:(BOOL)animated
{
    mainFrame = self.view.frame;

    viewOneWay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 140)];
    viewOnBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, 280)];
    
    columnDepartureControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, 0, mainFrame.size.width, viewOneWay.frame.size.height) title:@"туда" withTarget:nil];
    columnDepartureControlView.delegate = (id)self;
    NSArray *departureFlights = [CAColumnMockDates generateFlyToDates];
    [columnDepartureControlView importFlights: departureFlights];
    
    columnArrivialControlView = [[CAColumnsControlView alloc] initWithFrame:CGRectMake(0, viewOneWay.frame.size.height, mainFrame.size.width, viewOneWay.frame.size.height) title:@"обратно" withTarget:nil];
    
    tableOffers.bounds = mainFrame;
    tableOffers.frame = CGRectMake(mainFrame.origin.x,
                                   mainFrame.origin.y,
                                   mainFrame.size.width,
                                   mainFrame.size.height);
    [tableOffers setContentOffset:CGPointMake(0, viewOneWay.frame.size.height - topGreenView.frame.size.height) animated:NO];
}

-(void)bar
{
    [self factor];
    NSInteger factor = [self factor];
    
    counter++;
    if (counter%2 == 0) {
        [tableOffers setContentOffset:CGPointMake(0, factor*viewOneWay.frame.size.height - topGreenView.frame.size.height) animated:YES];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenLabel.alpha = topGreenView.alpha = 1;
        [UIView commitAnimations];

    }
    else {
        [tableOffers setContentOffset:CGPointMake(0, 0) animated:YES];
        counter = 1;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3f];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        topGreenLabel.alpha = topGreenView.alpha = 0;
        [UIView commitAnimations];
    }
}

-(void)switchToggled
{
    [self factor];
    [self bar];
    [tableOffers reloadData];
}

-(NSInteger )factor
{
    if ([returnFly isOn]) {
        isReturn = YES;
        topGreenLabel.text = @"летим туда/обратно 1 сентября";
        return 2;
    }
    isReturn = NO;
    topGreenLabel.text = @"летим в одну сторону 21 января";
    return 1;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [offerArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OfferCell";
    
    CAOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CAOfferCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = [offerArray objectAtIndex:indexPath.section];
    CAOfferCell *customCell = (CAOfferCell*)cell;
    
    customCell.backgroundView = [[UIView alloc] initWithFrame:customCell.frame];
    
    [customCell initByOfferModel:offer];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        
        UILabel* numberFlights = [[UILabel alloc] init];
        numberFlights.text = @" Доступно перелетов: 3";
        numberFlights.font = [UIFont fontWithName:@"Arial" size:14];
        CGSize textSize = [numberFlights.text sizeWithFont:numberFlights.font];
        numberFlights.frame = CGRectMake(mainFrame.size.width/2 - textSize.width/2, factor*viewOneWay.frame.size.height + 4, 0, 0);
        numberFlights.textColor = [UIColor blackColor];
        numberFlights.backgroundColor = [UIColor clearColor];
        [numberFlights sizeToFit];

        UIView *headerTableView = [[UIView alloc] initWithFrame:CGRectMake(mainFrame.origin.x,
                                                                mainFrame.origin.y,
                                                                mainFrame.size.width,
                                                                factor*viewOneWay.frame.size.height + 20)];
        if (isReturn) {
            [viewOneWay removeFromSuperview];
            [viewOnBack removeFromSuperview];
            [viewOnBack addSubview:columnDepartureControlView];
            [viewOnBack addSubview:columnArrivialControlView];
            [headerTableView addSubview:viewOnBack];
            
        }
        else {
            [viewOneWay removeFromSuperview];
            [viewOnBack removeFromSuperview];
            [viewOneWay addSubview:columnDepartureControlView];
            [headerTableView addSubview:viewOneWay];
        }
        [headerTableView addSubview:numberFlights];
        return headerTableView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Offer *offer = [offerArray objectAtIndex:indexPath.section];
    if(offer.isSpecial)
        return CELL_HEIGHT_SPECIAL;
    else
        return CELL_HEIGHT_NORMAL;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        NSInteger factor = [self factor];
        return factor*viewOneWay.frame.size.height + 26; }
    else
        return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"нажал на %d ячейку",indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)buttonClicked
{
    NSLog(@"click");
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    topGreenLabel.alpha = topGreenView.alpha = 0;
    [UIView commitAnimations];
    counter = 1;
}

@end
