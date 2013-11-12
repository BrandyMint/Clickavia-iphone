//
//  CAAutorizedController.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 12/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAutorizedController.h"
#import "CAColorSpecOffers.h"
#import "PersonInfo.h"

#define MARGIN_LEFT 10
#define MARGIN_BETWEEN_LABELS 5
#define BUTTON_HEIGHT 30
#define BUTTON_WIDTH 80
#define HEIGHT_CELL_PASSENGER 130

@interface CAAutorizedController ()
{
    UIView* userView;
}
@end

@implementation CAAutorizedController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil user:(User* )user
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationItem setHidesBackButton:YES];
        float heightPassengersCards = 0;
        
        NSData *usersPassportsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UsersPassports"];
        NSArray *usersPassportsArray = [NSKeyedUnarchiver unarchiveObjectWithData:usersPassportsData];
        
        UIScrollView* scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,480)];
        scrollview.showsVerticalScrollIndicator=YES;
        scrollview.scrollEnabled=YES;
        scrollview.userInteractionEnabled=YES;
        [self.view addSubview:scrollview];
        
        for (int i= 0; i<usersPassportsArray.count; i++) {
            heightPassengersCards = (HEIGHT_CELL_PASSENGER+10)*i;
            
            PersonInfo* personInfo = [PersonInfo new];
            personInfo = [usersPassportsArray objectAtIndex:i];
            
            UIView* passengerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                             10 + heightPassengersCards,
                                                                             scrollview.frame.size.width,
                                                                             HEIGHT_CELL_PASSENGER)];
            passengerView.backgroundColor = [UIColor lightGrayColor];
            [scrollview addSubview:passengerView];
            
            UIButton *change = [UIButton buttonWithType: UIButtonTypeRoundedRect];
            change.frame = CGRectMake(passengerView.frame.size.width - BUTTON_WIDTH - 10,
                                      MARGIN_BETWEEN_LABELS,
                                      BUTTON_WIDTH,
                                      BUTTON_HEIGHT);
            //[change addTarget:nil action:@selector(replaceUser:) forControlEvents:UIControlEventTouchUpInside];
            [change setTitle:@"Изменить" forState:UIControlStateNormal];
            [change setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [passengerView addSubview: change];
            
            UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN_BETWEEN_LABELS, passengerView.frame.size.width, 17)];
            title.text = @"Пассажиры";
            title.font = [UIFont systemFontOfSize:14];
            title.textAlignment = NSTextAlignmentCenter;
            //[title sizeToFit];
            title.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:title];


            NSString* personType = @"";
            switch (personInfo.personType) {
                case male:
                    personType = @"MR.";
                    break;
                case female:
                    personType = @"MRS.";
                    break;
                case children:
                    personType = @"CHD.";
                    break;
                case infant:
                    personType = @"INF.";
                    break;
                default:
                    break;
            }
            
            NSDateFormatter* datefrmatter = [NSDateFormatter new];
            [datefrmatter setDateFormat:@"dd.MM.yyyy"];
            
            NSMutableString* fio = [[NSMutableString alloc] init];
            [fio appendString:[NSString stringWithFormat:@"%@ ",personType]];
            [fio appendString:[NSString stringWithFormat:@"%@ ",personInfo.lastName]];
            [fio appendString:personInfo.name];
            
            UILabel* person = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, change.frame.origin.y + change.frame.size.height, 0, 0)];
            person.text = fio;
            person.font = [UIFont systemFontOfSize:14];
            [person sizeToFit];
            person.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:person];
            
            UILabel* birthday = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                          person.frame.origin.y + [person.text sizeWithFont:person.font].height + MARGIN_BETWEEN_LABELS,
                                                                          0, 0)];
            birthday.text = @"Дата рождения";
            birthday.font = [UIFont systemFontOfSize:14];
            [birthday sizeToFit];
            birthday.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:birthday];
            
            UILabel* birthdayInfo = [[UILabel alloc] initWithFrame:CGRectMake(birthday.frame.origin.x + [birthday.text sizeWithFont:birthday.font].width + 5,
                                                                              birthday.frame.origin.y,
                                                                              0, 0)];
            birthdayInfo.text = [datefrmatter stringFromDate:personInfo.birthDate];
            birthdayInfo.font = [UIFont systemFontOfSize:14];
            [birthdayInfo sizeToFit];
            birthdayInfo.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:birthdayInfo];
            
            UILabel* passport = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                          birthday.frame.origin.y + [birthday.text sizeWithFont:birthday.font].height + MARGIN_BETWEEN_LABELS,
                                                                          0, 0)];
            passport.text = @"Паспорт";
            passport.font = [UIFont systemFontOfSize:14];
            [passport sizeToFit];
            passport.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:passport];
            
            NSMutableString* passportFull = [NSMutableString new];
            [passportFull appendString:[NSString stringWithFormat:@"%@ ",personInfo.passportSeries]];
            [passportFull appendString:personInfo.passportNumber];
            UILabel* passportInfo = [[UILabel alloc] initWithFrame:CGRectMake(passport.frame.origin.x + [passport.text sizeWithFont:passport.font].width + 5,
                                                                          passport.frame.origin.y,
                                                                          0, 0)];
            passportInfo.text = passportFull;
            passportInfo.font = [UIFont systemFontOfSize:14];
            [passportInfo sizeToFit];
            passportInfo.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:passportInfo];
            
            UILabel* validDay = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                          passport.frame.origin.y + [passport.text sizeWithFont:passport.font].height + MARGIN_BETWEEN_LABELS,
                                                                          0, 0)];
            validDay.text = @"Срок действия";
            validDay.font = [UIFont systemFontOfSize:14];
            [validDay sizeToFit];
            validDay.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:validDay];
            
            UILabel* validDayInfo = [[UILabel alloc] initWithFrame:CGRectMake(validDay.frame.origin.x + [validDay.text sizeWithFont:validDay.font].width + 5,
                                                                              validDay.frame.origin.y,
                                                                              0, 0)];
            validDayInfo.text = [datefrmatter stringFromDate:personInfo.validDate];
            validDayInfo.font = [UIFont systemFontOfSize:14];
            [validDayInfo sizeToFit];
            validDayInfo.backgroundColor = [UIColor  clearColor];
            [passengerView addSubview:validDayInfo];

        }
        
        UILabel* userLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_BETWEEN_LABELS, 0, 0)];
        userLabel.text = @"Пользователь";
        userLabel.font = [UIFont systemFontOfSize:14];
        [userLabel sizeToFit];
        userLabel.backgroundColor = [UIColor clearColor];
        
        UILabel* userName = [[UILabel alloc] initWithFrame:CGRectMake(userLabel.frame.origin.x,
                                                                      userLabel.frame.origin.y + [userLabel.text sizeWithFont:userLabel.font].height + MARGIN_BETWEEN_LABELS,
                                                                      0,
                                                                      0)];
        userName.text = user.name;
        userName.font = [UIFont systemFontOfSize:14];
        [userName sizeToFit];
        userName.backgroundColor = [UIColor clearColor];
        
        userView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                            heightPassengersCards + 20 + HEIGHT_CELL_PASSENGER,
                                                            self.view.frame.size.width,
                                                            userName.frame.origin.y + [userName.text sizeWithFont:userName.font].height + MARGIN_BETWEEN_LABELS)];
        userView.backgroundColor = [UIColor lightGrayColor];
        [scrollview addSubview:userView];
        
        UIButton *replaceUser = [UIButton buttonWithType: UIButtonTypeRoundedRect];
        replaceUser.frame = CGRectMake(userView.frame.size.width - BUTTON_WIDTH - 10, userView.frame.size.height/2 - BUTTON_HEIGHT/2, BUTTON_WIDTH, BUTTON_HEIGHT);
        [replaceUser addTarget:self action:@selector(replaceUser:) forControlEvents:UIControlEventTouchUpInside];
        [replaceUser setTitle:@"Сменить" forState:UIControlStateNormal];
        [replaceUser setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [userView addSubview: replaceUser];
        
        [userView addSubview:userLabel];
        [userView addSubview:userName];
        
        UIButton* toPayment = [[UIButton alloc] initWithFrame:CGRectMake(scrollview.frame.size.width/2 - 250/2,
                                                                         userView.frame.origin.y + userView.frame.size.height + 20,
                                                                         250,
                                                                         40)];
        toPayment.titleLabel.textAlignment = NSTextAlignmentCenter;
        [toPayment setTitle:@"Перейти к оплате" forState:UIControlStateNormal];
        [toPayment setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
        [toPayment addTarget:nil action:@selector(onButton) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:toPayment];
        
        scrollview.contentSize = CGSizeMake(320,heightPassengersCards + userView.frame.size.height + HEIGHT_CELL_PASSENGER + 40 + 100);
    }
    return self;
}

-(void) replaceUser:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view removeFromSuperview];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showNavBar];
}

-(void)showNavBar
{
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
