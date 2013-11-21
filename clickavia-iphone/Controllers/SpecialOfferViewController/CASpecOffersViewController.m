//
//  CASpecOffersViewController.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "CASpecOffersViewController.h"
#import "CAScrollableTabView.h"
#import "SpecialOfferCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <QuartzCore/QuartzCore.h>
#import "CAColorSpecOffers.h"
#import "CAContract.h"

@interface CASpecOffersViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (retain, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundCity;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundCountry;

@end

@implementation CASpecOffersViewController
{
    SpecialOffersManager *specOfferManager;
    
    SpecialOfferCity *selectCityOffer;
    SpecialOfferCountry *selectCountryOffer;
    
    NSArray *citiesOffers;
    NSMutableArray *cities;
    
    NSArray *countriesOffers;
    NSMutableArray *countries;
    
    NSArray *offersContainer;
    
    CGRect mainFrame;
    NSArray* firstHotSpecialOffer;
}

@synthesize offerCell;
@synthesize backgroundImage, titleText;
@synthesize backgroundCity, backgroundCountry;
@synthesize tabCities, tabCountries, tabTitle;

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
    CGRect tableOffersFrame = _tableOffers.frame;
    tableOffersFrame.size.height = mainFrame.size.height - _tableOffers.frame.origin.y;
    _tableOffers.frame = tableOffersFrame;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    backgroundImage.frame = self.view.frame;
    self.navigationController.navigationBarHidden = NO;
    [self showNavBar];
    
    titleText.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleText.textColor = [UIColor COLOR_TITLE_TEXT];
    
    titleText.layer.shadowOpacity = 0.4f;
    titleText.layer.shadowRadius = 0.0f;
    titleText.layer.shadowColor = [[UIColor COLOR_TITLE_TEXT_SHADOW] CGColor];
    titleText.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    specOfferManager = [[SpecialOffersManager alloc] init];
    cities = [[NSMutableArray alloc] init];
    countries = [[NSMutableArray alloc] init];
    
    [self reloadCities];
    
    backgroundCity.layer.shadowOpacity = 1.0f;
    backgroundCity.layer.shadowRadius = 0.0f;
    backgroundCity.layer.shadowColor = [[COLOR_SCROLLVIEW_SPECOFFERS_CITY_SHADOW] CGColor];
    backgroundCity.layer.shadowOffset = CGSizeMake(0.0f, -1.0f);
    
    backgroundCountry.layer.shadowOpacity = 1.0f;
    backgroundCountry.layer.shadowRadius = 0.0f;
    backgroundCountry.layer.shadowColor = [[COLOR_SCROLLVIEW_SPECOFFERS_COUNTRY_SHADOW] CGColor];
    backgroundCountry.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
}

-(void)showNavBar
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor COLOR_TITLE_TEXT];
    titleLabel.text = @"Спецпредложения для города";
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
}

- (NSString *)tabTitle
{
	return @"Акции";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadCities
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [specOfferManager getCitiesWithCompleteBlock:^(NSArray *array)
     {
         [cities removeAllObjects];
         
         citiesOffers = array;
         for(SpecialOfferCity *cityOffer in citiesOffers)
         {
             CATabCell *tabCell = [[CATabCell alloc] init];
             tabCell.title = cityOffer.title;
             
             [cities addObject: tabCell];
         }
         
         [self.tabCities reloadData:cities];
         
         [hud hide:YES];
     }];
}

-(void) reloadCountries:(SpecialOfferCity *)forCity
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [specOfferManager getAvailableCountries:forCity completeBlock:^(NSArray *array)
     {
         NSLog(@"reloadCountries (%i)", array.count);
         
         [countries removeAllObjects];
         
         countriesOffers = array;
         for(SpecialOfferCountry *countryOffer in countriesOffers)
         {
             CATabCell *tabCell = [[CATabCell alloc] init];
             tabCell.title = countryOffer.title;
             tabCell.subTitle = [NSString stringWithFormat:@"%i", countryOffer.countOfOffers];
             NSLog(@"%@ (%@)", tabCell.title, tabCell.subTitle);
             [countries addObject: tabCell];
         }
         
         [self.tabCountries reloadData:countries];
         
         [hud hide:YES];
     }];
}

-(void) reloadOffers:(SpecialOfferCity *)forCity :(SpecialOfferCountry *)forCountry
{
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [specOfferManager getSpecialOffers:forCity :forCountry completeBlock:^(NSArray *array)
     {
         offersContainer = array;
         
         [_tableOffers reloadData];
         
         [hud hide:YES];
     }];
}

#pragma mark - CAScrollableTabViewDataSource

- (NSArray *)titlesInScrollableTabView:(CAScrollableTabView *)tabView
{
    if(tabView == self.tabCities)
    {
        return cities;
    }
    else if(tabView == self.tabCountries)
    {
        return countries;
    }
    
    return nil;
}

- (void)scrollableTabView:(CAScrollableTabView *)tabView didSelectItemAtIndex:(NSInteger)index
{
    if(tabView == self.tabCities)
    {
        NSLog(@"citiesOffers count %d", citiesOffers.count);
#warning fix it! (suddenly zero count of array)
        if(citiesOffers.count > 0)
        {
            selectCityOffer = (SpecialOfferCity*)[citiesOffers objectAtIndex:index];
            NSLog(@"select %@", selectCityOffer.title);
            [self reloadCountries:selectCityOffer];
        }
    }
    else if(tabView == self.tabCountries)
    {
        NSLog(@"countriesOffers count %d", countriesOffers.count);
#warning fix it! (suddenly zero count of array)
        if(countriesOffers.count > 0)
        {
            selectCountryOffer = (SpecialOfferCountry*)[countriesOffers objectAtIndex:index];
            [self reloadOffers:selectCityOffer :selectCountryOffer];
        }
    }
}

-(IBAction) onRefresh:(id)sender
{
    [self.tabCities reloadData:cities];
    [self.tabCities setSelectedItemIndex:0];
}

#pragma mark
#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return offersContainer.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpecialOfferCell";
    
    SpecialOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"SpecialOfferCell" owner:self options:nil];
        cell = offerCell;
        

        cell.bounds = self.view.frame;
        
		self.offerCell = nil;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialOfferCell *customCell = (SpecialOfferCell*)cell;
    firstHotSpecialOffer = [self firstHot];
    SpecialOffer *specialOffer = [firstHotSpecialOffer objectAtIndex:indexPath.section];
    [customCell initByOfferModel:specialOffer];
    
    cell.backgroundColor = [UIColor clearColor];
}

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpecialOffer *specialOffer = [firstHotSpecialOffer objectAtIndex:indexPath.section];
    CAContract* caContract = [[CAContract alloc] initWithNibName:@"CAContract" bundle:nil specialOffer:specialOffer];
    [self.navigationController pushViewController:caContract animated:YES];
}

- (NSArray *)firstHot
{
    NSMutableArray* hotOffer = [NSMutableArray new];
    NSMutableArray* usuallyOffer = [NSMutableArray new];
    
    for (int i = 0; i < offersContainer.count; i++) {
        SpecialOffer *specialOffer = [offersContainer objectAtIndex:i];
        if (specialOffer.isHot) {
            [hotOffer addObject:specialOffer];
        }
        else{
            [usuallyOffer addObject:specialOffer];
        }
    }
    [hotOffer addObjectsFromArray:usuallyOffer];

    return hotOffer;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
