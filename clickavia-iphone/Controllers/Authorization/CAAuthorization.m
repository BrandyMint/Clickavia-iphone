//
//  CAAuthorization.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 11/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAuthorization.h"
#import "CAAutorizedController.h"
#import "CAColorSpecOffers.h"
#import "LoginForm.h"
#import "AuthManager.h"
#import "User.h"
#import "CountryCodes.h"
#import "RegistrationForm.h"
#import "UserManager.h"
#import "MBProgressHUD.h"
#import "WTReTextField.h"
#import "DMRegistrationResponse.h"
#import "DMRegistrationError.h"

#define BUTTON_WIDTH 220
#define BUTTON_HEIGHT 40
#define MARGIN_BETWEEN_TEXTFIELDS 10

@interface CAAuthorization ()
{
    UIView* mainView;
    UIView* autorizationView;
    UIView* registrationView;
    UISegmentedControl* segmentedControl;
    BOOL isEnter;
    BOOL isTextFieldsFilled;
    UIButton* enter;
    
    UITextField* emailAutorization;
    UITextField* passwordAutorization;
    
    UITextField* nameRegistration;
    UITextField* emailRegistration;
    UITextField* countryCodeRegistration;
    WTReTextField* phoneNumberRegistration;
    UITextField* passwordRegistration;
    
    FPPopoverController* popover;
    NSString* errorString;
    CGPoint textFieldPosition;
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
    isTextFieldsFilled = NO;
    
    mainView = [[UIView alloc] initWithFrame:CGRectMake(2, 2, self.view.frame.size.width - 4, 170)];
    mainView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainView];
    
    NSArray *itemArray = [NSArray arrayWithObjects: @"войти", @"регистрация", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(10, 10, mainView.frame.size.width - 20, 30);
    segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    segmentedControl.selectedSegmentIndex = 0;
    isEnter = YES;
    [segmentedControl addTarget:self action:@selector(segmentedControl:) forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:segmentedControl];
    
    autorizationView = [[UIView alloc] initWithFrame:CGRectMake(10,
                                                                segmentedControl.frame.origin.y + segmentedControl.frame.size.height + 20,
                                                                segmentedControl.frame.size.width, 120)];
    [mainView addSubview:autorizationView];
    
    emailAutorization = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, autorizationView.frame.size.width, 30)];
    emailAutorization.borderStyle = UITextBorderStyleRoundedRect;
    emailAutorization.font = [UIFont systemFontOfSize:15];
    emailAutorization.placeholder = @"АДРЕС ЭЛЕКТРОННОЙ ПОЧТЫ";
    emailAutorization.autocorrectionType = UITextAutocorrectionTypeNo;
    emailAutorization.keyboardType = UIKeyboardTypeEmailAddress;
    emailAutorization.returnKeyType = UIReturnKeyDone;
    emailAutorization.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailAutorization.textAlignment = UITextAlignmentLeft;
    emailAutorization.backgroundColor = [UIColor whiteColor];
    emailAutorization.delegate = self;
    emailAutorization.clearButtonMode = UITextFieldViewModeWhileEditing;
    [autorizationView addSubview:emailAutorization];
    
    passwordAutorization = [[UITextField alloc] initWithFrame:CGRectMake(0,
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
    
    nameRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, registrationView.frame.size.width, 30)];
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
    
    emailRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                      nameRegistration.frame.origin.y + nameRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                      registrationView.frame.size.width, 30)];
    emailRegistration.borderStyle = UITextBorderStyleRoundedRect;
    emailRegistration.font = [UIFont systemFontOfSize:15];
    emailRegistration.placeholder = @"АДРЕС ЭЛЕКТРОННОЙ ПОЧТЫ";
    emailRegistration.autocorrectionType = UITextAutocorrectionTypeNo;
    emailRegistration.keyboardType = UIKeyboardTypeEmailAddress;
    emailRegistration.returnKeyType = UIReturnKeyDone;
    emailRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    emailRegistration.textAlignment = UITextAlignmentLeft;
    emailRegistration.backgroundColor = [UIColor whiteColor];
    emailRegistration.delegate = self;
    emailRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:emailRegistration];
    
    countryCodeRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                            emailRegistration.frame.origin.y + emailRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                            95, 30)];
    countryCodeRegistration.borderStyle = UITextBorderStyleRoundedRect;
    countryCodeRegistration.font = [UIFont systemFontOfSize:15];
    countryCodeRegistration.placeholder = @"КОД";
    countryCodeRegistration.text = @"+";
    countryCodeRegistration.autocorrectionType = UITextAutocorrectionTypeYes;
    countryCodeRegistration.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    countryCodeRegistration.returnKeyType = UIReturnKeyDone;
    countryCodeRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    countryCodeRegistration.textAlignment = UITextAlignmentRight;
    countryCodeRegistration.backgroundColor = [UIColor whiteColor];
    countryCodeRegistration.delegate = self;
    countryCodeRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:countryCodeRegistration];
    
    
    phoneNumberRegistration = [[WTReTextField alloc] initWithFrame:CGRectMake(countryCodeRegistration.frame.origin.x + countryCodeRegistration.frame.size.width + 5,
                                                                            emailRegistration.frame.origin.y + emailRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                            registrationView.frame.size.width - (countryCodeRegistration.frame.origin.x + countryCodeRegistration.frame.size.width + 5),
                                                                            30)];
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
    phoneNumberRegistration.pattern = @"^[0-9]{1,}$";
    [registrationView addSubview:phoneNumberRegistration];
    
    passwordRegistration = [[UITextField alloc] initWithFrame:CGRectMake(0,
                                                                         phoneNumberRegistration.frame.origin.y + phoneNumberRegistration.frame.size.height + MARGIN_BETWEEN_TEXTFIELDS,
                                                                         nameRegistration.frame.size.width, 30)];
    passwordRegistration.borderStyle = UITextBorderStyleRoundedRect;
    passwordRegistration.placeholder = @"ПАРОЛЬ";
    passwordRegistration.secureTextEntry = YES;
    passwordRegistration.autocorrectionType = UITextAutocorrectionTypeNo;
    passwordRegistration.font = [UIFont systemFontOfSize:15];
    passwordRegistration.keyboardType = UIKeyboardTypeEmailAddress;
    passwordRegistration.returnKeyType = UIReturnKeyDone;
    passwordRegistration.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passwordRegistration.textAlignment = UITextAlignmentLeft;
    passwordRegistration.backgroundColor = [UIColor whiteColor];
    passwordRegistration.delegate = self;
    passwordRegistration.clearButtonMode = UITextFieldViewModeWhileEditing;
    [registrationView addSubview:passwordRegistration];
    
    emailAutorization.text = @"bespalown@gmail.co";
    passwordAutorization.text = @"123";
    
    enter = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - BUTTON_WIDTH/2,
                                                       mainView.frame.origin.y + mainView.frame.size.height + BUTTON_HEIGHT,
                                                       BUTTON_WIDTH,
                                                       BUTTON_HEIGHT)];
    enter.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enter setTitle:@"Войти" forState:UIControlStateNormal];
    [enter setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enter];
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)segmentedControl:(id)sender
{
    CGRect mainViewFrame = mainView.frame;
    CGRect enterFrame = enter.frame;
    
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            isEnter = YES;
            mainViewFrame.size.height = 170;
            enterFrame.origin.y -= 50;
            [registrationView removeFromSuperview];
            [mainView addSubview:autorizationView];
            [enter setTitle:@"Войти" forState:UIControlStateNormal];
            break;
        case 1:
            isEnter = NO;
            mainViewFrame.size.height = 230;
            enterFrame.origin.y += 50;
            [autorizationView removeFromSuperview];
            [mainView addSubview:registrationView];
            [enter setTitle:@"Регистрация" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    mainView.frame = mainViewFrame;
    enter.frame = enterFrame;
}

-(void)onButton
{
    [self.view endEditing:YES];
    if (isEnter) {
        [self autorization];
    }
    else //if (isTextFieldsFilled)
    {
        [self registration];
    }
   /* else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Заполните поля" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }*/
}

-(void)autorization
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    LoginForm* loginForm = [LoginForm new];
    loginForm.email = emailAutorization.text;
    loginForm.password = passwordAutorization.text;
    
    AuthManager* authManager = [AuthManager new];
    [authManager getUser:loginForm completeBlock:^(User* user)
     {
         loginForm.accessToken = user.authKey;
         NSString* autorization = [NSString stringWithFormat:@"Имя: %@\n email: %@\n Номер телефона: %@\n token: %@",user.name, user.email, user.phoneNumber, user.authKey];
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Авторизиция прошла успешно" message:autorization delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [alert show];
         [[NSUserDefaults standardUserDefaults] setObject:loginForm.accessToken forKey:@"accessToken"];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
         CAAutorizedController* autorizedController = [[CAAutorizedController alloc] initWithNibName:@"CAAutorizedController" bundle:nil user:user];
         [self.navigationController pushViewController:autorizedController animated:YES];
         
     }
               failBlock:^(NSException* exception)
     {
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Проверьте ваш пароль или email" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
         [alert show];
         [MBProgressHUD hideHUDForView:self.view animated:YES];
     }
     ];
}

-(void)registration
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableString* code = [NSMutableString new];
    [code appendString:countryCodeRegistration.text];
    [code deleteCharactersInRange:NSMakeRange(0, 1)];
    
    RegistrationForm *regForm = [[RegistrationForm alloc] init];
    regForm.name = nameRegistration.text;
    regForm.email = emailRegistration.text;
    regForm.phoneNumber = phoneNumberRegistration.text;
    regForm.countryCode = code;
    regForm.password = passwordRegistration.text;
    
    UserManager* userManager = [UserManager new];
    [userManager registrateUser:regForm completeBlock:^(User* user)
    {
        NSString *message = [[NSString alloc] initWithFormat:@"Имя: %@,\n email: %@,\n Номер телефона: %@",user.name,user.email,user.phoneNumber];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Регистрация прошла успешно" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        isTextFieldsFilled = NO;
    }
                      failBlock:^(NSException* exception)
    {
        NSDictionary *jsonArray = [NSDictionary new];
        jsonArray = exception.userInfo;
        DMRegistrationResponse* registrationResponse = [DMRegistrationResponse new];
        registrationResponse = [EKMapper objectFromExternalRepresentation:jsonArray withMapping:[DMUMMappingProvider registrationResponseMapping]];
        
        DMRegistrationError* registrationError = [DMRegistrationError new];
        registrationError = registrationResponse.errors;
        
        NSArray *email = [NSArray arrayWithArray:registrationError.email];
        NSArray *password = [NSArray arrayWithArray:registrationError.password];
        NSArray *name = [NSArray arrayWithArray:registrationError.name];
        NSArray *country_code = [NSArray arrayWithArray:registrationError.country_code];
        NSArray *phone_number = [NSArray arrayWithArray:registrationError.phone_number];
        
        NSString* nameField = @"";
        NSString* errorFromField = @"";
        
        if (name.count != 0)
        {
            nameField = @"имя пользователя";
            errorFromField = [self errorMessage:name];
        }
        else if (email.count != 0) {
            nameField = @"email";
            errorFromField = [self errorMessage:email];
        }
        else if (country_code.count != 0)
        {
            nameField = @"код страны";
            errorFromField = [self errorMessage:country_code];
        }
        else if (phone_number.count != 0)
        {
            nameField = @"номер телефона";
            errorFromField = [self errorMessage:phone_number];
        }
        else if (password.count != 0)
        {
            nameField = @"пароль";
            errorFromField = [self errorMessage:password];
        }
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Поле %@", nameField] message:errorFromField delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertView show];
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }
    ];
}

- (NSString*) errorMessage:(NSArray *)array
{
    NSMutableString *message = [NSMutableString new];
    for (NSString *str in array)
    {
        [message appendFormat:@"%@\n",str];
    }
    return message;
}

#pragma mark CAPopoverErrorDelegate
-(void)touchesBeganCAPopoverError
{
    [popover dismissPopoverAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    errorString = @"";
    if (textField == nameRegistration) {
        errorString = @"Имя не может быть меньше 1 символа";
    }
    if (textField == emailRegistration) {
        errorString = @"некорректный email";
    }
    if (textField == countryCodeRegistration) {
        errorString = @"код страны не может быть пустым";
    }
    if (textField == phoneNumberRegistration) {
        errorString = @"номер телефона не корректный";
    }
    if (textField == passwordRegistration) {
        errorString = @"пароль не может быть меньше 3 символов";
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [popover dismissPopoverAnimated:YES];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textFieldPosition = [textField convertPoint:CGPointZero toView:self.view];
    textFieldPosition.x += textField.frame.size.width/2;
    textFieldPosition.y += 70;
    
    if (textField == nameRegistration) {
        if (textField.text.length < 1)
        {
            [self showPopover];
        }
    }
    if (textField == emailRegistration) {
        if (![self validateEmailWithString:emailRegistration.text] || textField.text.length < 6)
        {
          [self showPopover];
        }
    }
    if (textField == countryCodeRegistration) {
        if (textField.text.length <= 1)
        {
            [self showPopover];
        }
    }
    if (textField == phoneNumberRegistration) {
        if (textField.text.length <= 9)
        {
            [self showPopover];
        }
    }
    if (textField == passwordRegistration) {
        if (textField.text.length < 3)
        {
            [self showPopover];
        }
    }
    
    if (nameRegistration.text.length != 0 && emailAutorization.text.length != 0 && countryCodeRegistration.text.length > 1 && phoneNumberRegistration.text.length != 0 && passwordRegistration.text.length !=0) {
        isTextFieldsFilled = YES;
    }
}

-(void)showPopover
{
    UIFont* font = [UIFont systemFontOfSize:14];
    CGSize textSize = [self sizeText:errorString width:300 font:font];
    
    CAPopoverErrorViewController *controller = [[CAPopoverErrorViewController alloc] initWithTitle:errorString font:font size:textSize];
    controller.delegate = self;
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    popover.delegate = self;
    popover.tint = FPPopoverDefaultTint;
    popover.contentSize = CGSizeMake(self.view.frame.size.width, 43 + textSize.height);
    popover.arrowDirection = FPPopoverArrowDirectionDown;
    [popover presentPopoverFromPoint: textFieldPosition];
}

-(CGSize)sizeText:(NSString*)text width:(CGFloat)width font:(UIFont*)font
{
    CGSize boundingSize = CGSizeMake(width, CGFLOAT_MAX);
    CGSize requiredSize = [text sizeWithFont:font
                           constrainedToSize:boundingSize
                               lineBreakMode:UILineBreakModeWordWrap];
    return requiredSize;
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
