//
//  CAContract.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 9/19/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAContract.h"

@interface CAContract ()
@property (weak, nonatomic) IBOutlet UITextView *contractTextView;
@property (weak, nonatomic) IBOutlet UIButton *onConfirmation;
- (IBAction)onConfrmation:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation CAContract

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    self.title = @"Договор";
    
    NSString *urlAddress = @"http://www.bn.ru/oferta/";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onConfrmation:(id)sender
{
    UIViewController * back = [self.navigationController popViewControllerAnimated:YES];
}
@end
