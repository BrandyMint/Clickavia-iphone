//
//  CAAuthorization.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 11/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAuthorization.h"
#import "CAColorSpecOffers.h"
#import "User.h"
#import "CountryCodes.h"
#import "LoginForm.h"
#import "RegistrationForm.h"
#import "AFNetworking.h"

#define BUTTON_WIDTH 20
#define BUTTON_HEIGHT 40
#define MARGIN_BETWEEN_TEXTFIELDS 10

@interface CAAuthorization ()
{
    UIView* mainView;
    UIView* autorizationView;
    UIView* registrationView;
    UISegmentedControl* segmentedControl;
    UIButton* enter;
}
@end

@implementation CAAuthorization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)tabTitle
{
	return @"Авторизация";
}

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
    [navBack addTarget:nil action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:navBack];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    titleLabel.textColor = [UIColor COLOR_TITLE_TEXT];
    titleLabel.text = @"Авторизация";
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

-(void)viewDidAppear:(BOOL)animated
{
    mainView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.view.frame.size.width - 4, 250)];
    mainView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainView];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"войти", @"зарегистрироваться", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(10, 10, mainView.frame.size.width - 20, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:segmentedControl];
    
    autorizationView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20,
                                                                segmentedControl.frame.size.width, 120)];
    [mainView addSubview:autorizationView];
    
    UITextField* emailAutorization = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, autorizationView.frame.size.width, 30)];
    emailAutorization.borderStyle = UITextBorderStyleRoundedRect;
    emailAutorization.font = [UIFont systemFontOfSize:15];
    emailAutorization.placeholder = @"АДРЕС ЭЛЕКТРОННОЙ ПОЧТЫ";
    emailAutorization.autocorrectionType = UITextAutocorrectionTypeYes;
    emailAutorization.keyboardType = UIKeyboardTypeEmailAddress;
    emailAutorization.returnKeyType = UIReturnKeyDone;
    emailAutorization.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailAutorization.textAlignment = UITextAlignmentLeft;
    emailAutorization.backgroundColor = [UIColor whiteColor];
    emailAutorization.delegate = self;
    emailAutorization.clearButtonMode = UITextFieldViewModeWhileEditing;
    [autorizationView addSubview:emailAutorization];

    UITextField* passwordAutorization = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                                      emailAutorization.frame.origin.y + emailAutorization.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                                      emailAutorization.frame.size.width, 30)];
    passwordAutorization.borderStyle = UITextBorderStyleRoundedRect;
    passwordAutorization.font = [UIFont systemFontOfSize:15];
    passwordAutorization.secureTextEntry = YES;
    passwordAutorization.placeholder = @"ПАРОЛЬ";
    passwordAutorization.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordAutorization.keyboardType = UIKeyboardTypeDefault;
    passwordAutorization.returnKeyType = UIReturnKeyDone;
    passwordAutorization.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordAutorization.textAlignment = UITextAlignmentLeft;
    passwordAutorization.backgroundColor = [UIColor whiteColor];
    passwordAutorization.delegate = self;
    passwordAutorization.clearButtonMode = UITextFieldViewModeWhileEditing;
    [autorizationView addSubview:passwordAutorization];
    
    UILabel* forgotPassword = [[UILabel alloc] initWithFrame:CGRectMake(0, passwordAutorization.frame.origin.y + passwordAutorization.frame.size.height + 20, 0, 0)];
    forgotPassword.text = @"Забыли пароль?";
    [forgotPassword sizeToFit];
    forgotPassword.backgroundColor = [UIColor clearColor];
    [autorizationView addSubview:forgotPassword];
    
    registrationView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20,
                                                                segmentedControl.frame.size.width, 200)];
    
    UITextField* nameRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, registrationView.frame.size.width, 30)];
    nameRegistration.borderStyle = UITextBorderStyleRoundedRect;
    nameRegistration.font = [UIFont systemFontOfSize:15];
    nameRegistration.placeholder = @"ИМЯ ПОЛЬЗОВАТЕЛЯ";
    nameRegistration.autocorrectionType = UITextAutocorrectionTypeYes;
    nameRegistration.keyboardType = UIKeyboardTypeDefault;
    nameRegistration.returnKeyType = UIReturnKeyDone;
    nameRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameRegistration.textAlignment = UITextAlignmentLeft;
    nameRegistration.backgroundColor = [UIColor whiteColor];
    nameRegistration.delegate = self;
    nameRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:nameRegistration];
    
    UITextField* emailRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                                   nameRegistration.frame.origin.y + nameRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                                   registrationView.frame.size.width, 30)];
    emailRegistration.borderStyle = UITextBorderStyleRoundedRect;
    emailRegistration.font = [UIFont systemFontOfSize:15];
    emailRegistration.placeholder = @"АДРЕС ЭЛЕКТРОННОЙ ПОЧТЫ";
    emailRegistration.autocorrectionType = UITextAutocorrectionTypeYes;
    emailRegistration.keyboardType = UIKeyboardTypeEmailAddress;
    emailRegistration.returnKeyType = UIReturnKeyDone;
    emailRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailRegistration.textAlignment = UITextAlignmentLeft;
    emailRegistration.backgroundColor = [UIColor whiteColor];
    emailRegistration.delegate = self;
    emailRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:emailRegistration];
    
    UITextField* phoneNumberRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                                         emailRegistration.frame.origin.y + emailRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                                         registrationView.frame.size.width, 30)];
    phoneNumberRegistration.borderStyle = UITextBorderStyleRoundedRect;
    phoneNumberRegistration.font = [UIFont systemFontOfSize:15];
    phoneNumberRegistration.placeholder = @"НОМЕР ТЕЛЕФОНА";
    phoneNumberRegistration.autocorrectionType = UITextAutocorrectionTypeYes;
    phoneNumberRegistration.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    phoneNumberRegistration.returnKeyType = UIReturnKeyDone;
    phoneNumberRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    phoneNumberRegistration.textAlignment = UITextAlignmentLeft;
    phoneNumberRegistration.backgroundColor = [UIColor whiteColor];
    phoneNumberRegistration.delegate = self;
    phoneNumberRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:phoneNumberRegistration];
    
    UITextField* countryCodeRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                                         phoneNumberRegistration.frame.origin.y + phoneNumberRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                                         registrationView.frame.size.width, 30)];
    countryCodeRegistration.borderStyle = UITextBorderStyleRoundedRect;
    countryCodeRegistration.font = [UIFont systemFontOfSize:15];
    countryCodeRegistration.placeholder = @"id СТРАНЫ";
    countryCodeRegistration.autocorrectionType = UITextAutocorrectionTypeYes;
    countryCodeRegistration.keyboardType = UIKeyboardTypeEmailAddress;
    countryCodeRegistration.returnKeyType = UIReturnKeyDone;
    countryCodeRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    countryCodeRegistration.textAlignment = UITextAlignmentLeft;
    countryCodeRegistration.backgroundColor = [UIColor whiteColor];
    countryCodeRegistration.delegate = self;
    countryCodeRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:countryCodeRegistration];

    UITextField* passwordRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                                      countryCodeRegistration.frame.origin.y + countryCodeRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                                      registrationView.frame.size.width, 30)];
    passwordRegistration.borderStyle = UITextBorderStyleRoundedRect;
    passwordRegistration.placeholder = @"ПАРОЛЬ";
    passwordRegistration.secureTextEntry = YES;
    passwordRegistration.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordRegistration.font = [UIFont systemFontOfSize:15];
    passwordRegistration.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordRegistration.keyboardType = UIKeyboardTypeEmailAddress;
    passwordRegistration.returnKeyType = UIReturnKeyDone;
    passwordRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordRegistration.textAlignment = UITextAlignmentLeft;
    passwordRegistration.backgroundColor = [UIColor whiteColor];
    passwordRegistration.delegate = self;
    passwordRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:passwordRegistration];
    
    enter = [[UIButton alloc] initWithFrame:CGRectMake(BUTTON_WIDTH, mainView.frame.size.height - 10 - BUTTON_HEIGHT, mainView.frame.size.width - 2*BUTTON_WIDTH, BUTTON_HEIGHT)];
    enter.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enter setTitle:@"Войти" forState:UIControlStateNormal];
    [enter setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:enter];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)segmentedControl:(id)sender
{
    CGRect mainViewFrame = mainView.frame;
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            mainViewFrame.size.height = 250;
            [registrationView removeFromSuperview];
            [mainView addSubview:autorizationView];
            [enter setTitle:@"Войти" forState:UIControlStateNormal];
            break;
        case 1:
            mainViewFrame.size.height = 320;
            [autorizationView removeFromSuperview];
            [mainView addSubview:registrationView];
            [enter setTitle:@"Регистрация" forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
    mainView.frame = mainViewFrame;
    enter.frame = CGRectMake(BUTTON_WIDTH, mainView.frame.size.height - 10 - BUTTON_HEIGHT, mainView.frame.size.width - 2*BUTTON_WIDTH, BUTTON_HEIGHT);
}

-(void)onButton
{
    NSURL *url = [NSURL URLWithString:@"http://avia.icfdev.ru"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:url];
    //[httpClient setParameterEncoding:AFJSONParameterEncoding];
    //[httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"Ans", @"name",
                            @"29",  @"age", nil];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"api/mobile/v1/auth.json"
                                                      parameters:params];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"DATA: %@", [JSON valueForKeyPath:@"data"]);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failure Because %@",[error userInfo]);
    }];
    
    [operation start];
}

@end