//
//  CASpecialOffersViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CASpecialOffersViewController.h"
#import "CAScrollableTabView.h"

@interface CASpecialOffersViewController ()

@end

@implementation CASpecialOffersViewController
{
    SpecialOffersManager *specOfferManager;
    
    SpecialOfferCity *selectCityOffer;
    SpecialOfferCountry *selectCountryOffer;
    
    NSArray *citiesOffers;
    NSMutableArray *cities;
    
    NSArray *countriesOffers;
    NSMutableArray *countries;
    
    NSArray *offersContainer;
}
@synthesize offerCell;

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
    
    specOfferManager = [[SpecialOffersManager alloc] init];
    cities = [[NSMutableArray alloc] init];
    countries = [[NSMutableArray alloc] init];
    
    self.tabCities.dataSource = (id)self;
    self.tabCities.delegate = (id)self;
    self.tabCountries.dataSource = (id)self;
    self.tabCountries.delegate = (id)self;
    
    [self reloadCities];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadCities
{
    //__block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
         
         [self.tabCities reloadData];
         [self.tabCities setSelectedItemIndex:0];
         
         //[hud hide:YES];
     }];
}

-(void) reloadCountries:(SpecialOfferCity *)forCity
{
   // __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
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
         
         [self.tabCountries reloadData];
         [self.tabCountries setSelectedItemIndex:0];
         
         //[hud hide:YES];
     }];
}

-(void) reloadOffers:(SpecialOfferCity *)forCity :(SpecialOfferCountry *)forCountry
{
    //__block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [specOfferManager getSpecialOffers:forCity :forCountry completeBlock:^(NSArray *array)
     {
         offersContainer = array;
         
         [_tableOffers reloadData];
         
        // [hud hide:YES];
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

- (UIColor *)lightColorInScrollableView:(CAScrollableTabView *)tabView
{
    return [UIColor colorWithRed:0.0706f green:0.1529f blue:0.4235f alpha:1.0f];
}

- (UIColor *)darkColorInScrollableView:(CAScrollableTabView *)tabView
{
    return [UIColor colorWithRed:0.258f green:0.639f blue:0.890f alpha:1.0f];
}

- (void)scrollableTabView:(CAScrollableTabView *)tabView didSelectItemAtIndex:(NSInteger)index
{
    if(tabView == self.tabCities)
    {
        selectCityOffer = (SpecialOfferCity*)[citiesOffers objectAtIndex:index];
        NSLog(@"select %@", selectCityOffer.title);
        [self reloadCountries:selectCityOffer];
    }
    else if(tabView == self.tabCountries)
    {
        selectCountryOffer = (SpecialOfferCountry*)[countriesOffers objectAtIndex:index];
        [self reloadOffers:selectCityOffer :selectCountryOffer];
    }
}

-(IBAction) onRefresh:(id)sender
{
    [self.tabCities reloadData];
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
    return 68;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
        return 6;
    else
        return 3;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SpecialOfferCell";
    
    CASpecialOfferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"CASpecialOfferCell" owner:self options:nil];
        cell = offerCell;
		self.offerCell = nil;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CASpecialOfferCell *customCell = (CASpecialOfferCell*)cell;
    
    customCell.backgroundView = [[UIView alloc] initWithFrame:customCell.frame];
    customCell.backgroundView.backgroundColor = [UIColor whiteColor];
    
    SpecialOffer *specialOffer = [offersContainer objectAtIndex:indexPath.row];
    [customCell initByOfferModel:specialOffer];
}

-(void) tableView:(UITableView*) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
}

-(IBAction) onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
