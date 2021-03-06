//
//  CAContract.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/19/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAContract.h"
#import <QuartzCore/QuartzCore.h>
#import "CAColorSpecOffers.h"

@interface CAContract ()

@property (weak, nonatomic) IBOutlet UITextView *contractTextView;
@property (weak, nonatomic) IBOutlet UIButton *onConfirmation;
- (IBAction)onConfrmation:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CAContract
{
    Offer* offerdata;
    CAFlightPassengersCount* passengersCount;
    SpecialOffer *specialOffer;
    BOOL isSpecialOffer;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil offer:(Offer*)offer passengerCount:(CAFlightPassengersCount*)passengerCount
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isSpecialOffer = NO;
        offerdata = [[Offer alloc] init];
        offerdata = offer;
        passengersCount = [[CAFlightPassengersCount alloc] init];
        passengersCount = passengerCount;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil specialOffer:(SpecialOffer*)_specialOffer;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isSpecialOffer = YES;
        specialOffer = [[SpecialOffer alloc] init];
        specialOffer = _specialOffer;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    [self showNavBar];

    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"Contract" ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
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
    titleLabel.text = @"Договор";
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

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

- (IBAction)onConfrmation:(id)sender
{
    CAFlightDataView *flightDataView;
    
    if (isSpecialOffer) {
        flightDataView = [[CAFlightDataView alloc] initWithNibName:@"CAFlightDataView" bundle:nil specialOffer:specialOffer];
    }
    else
        flightDataView = [[CAFlightDataView alloc] initWithNibName:@"CAFlightDataView" bundle:nil offer:offerdata passengerCount:passengersCount];
    
    [self.navigationController pushViewController:flightDataView animated:YES];
}
@end
