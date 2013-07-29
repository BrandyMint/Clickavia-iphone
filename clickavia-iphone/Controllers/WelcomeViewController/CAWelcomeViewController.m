//
//  CAWelcomeViewController.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAWelcomeViewController.h"

#import "CASpecialOffersViewController.h"

@interface CAWelcomeViewController ()

@end

@implementation CAWelcomeViewController

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
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) onSpecialOfferController:(id)sender
{
    CASpecialOffersViewController *specialOfferViewController = [[CASpecialOffersViewController alloc] init];
    [self.navigationController pushViewController:specialOfferViewController animated:YES];
}

@end
