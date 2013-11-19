//
//  CAOrderInfoPassportView.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 19/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOrderInfoPassportView.h"
#import "CAOrderInfo.h"

@implementation CAOrderInfoPassportView

- (UIView* )initWithpersonInfo:(PersonInfo*)_personInfo;
{
    UIView* mainiew = [UIView new];
    
    PersonInfo* personInfo = [PersonInfo new];
    personInfo = _personInfo;
    
    NSString* personType = @"";
    switch (personInfo.personType) {
        case male:
            personType = @"MR. ";
            break;
        case female:
            personType = @"MRS. ";
            break;
        case children:
            personType = @"CHD. ";
            break;
        case infant:
            personType = @"INF. ";
            break;
        default:
            break;
    }
    
    NSMutableString* fio = [[NSMutableString alloc] init];
    [fio appendString:personType];
    [fio appendString:[NSString stringWithFormat:@"%@ ",personInfo.lastName]];
    [fio appendString:personInfo.name];
    
    UILabel* person = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_LEFT, 0, 0)];
    person.text = fio;
    person.font = [UIFont systemFontOfSize:14];
    [person sizeToFit];
    person.backgroundColor = [UIColor  clearColor];
    [mainiew addSubview:person];
    
    UILabel* birthday = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                  person.frame.origin.y + [person.text sizeWithFont:person.font].height + MARGIN_BETWEEN_LABELS,
                                                                  0, 0)];
    birthday.text = @"Дата рождения";
    birthday.font = [UIFont systemFontOfSize:14];
    [birthday sizeToFit];
    birthday.backgroundColor = [UIColor  clearColor];
    [mainiew addSubview:birthday];
    
    UILabel* birthdayInfo = [[UILabel alloc] initWithFrame:CGRectMake(birthday.frame.origin.x + [birthday.text sizeWithFont:birthday.font].width + 5,
                                                                      birthday.frame.origin.y,
                                                                      0, 0)];
    birthdayInfo.text = [self dateToddMMyyyy:personInfo.birthDate];
    birthdayInfo.font = [UIFont systemFontOfSize:14];
    [birthdayInfo sizeToFit];
    birthdayInfo.backgroundColor = [UIColor  clearColor];
    [mainiew addSubview:birthdayInfo];
    
    UILabel* passport = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                  birthday.frame.origin.y + [birthday.text sizeWithFont:birthday.font].height + MARGIN_BETWEEN_LABELS,
                                                                  0, 0)];
    passport.text = @"Паспорт";
    passport.font = [UIFont systemFontOfSize:14];
    [passport sizeToFit];
    passport.backgroundColor = [UIColor  clearColor];
    [mainiew addSubview:passport];
    
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
    [mainiew addSubview:passportInfo];
    
    mainiew.frame = CGRectMake(0, 0, self.frame.size.width, [self getBottom:passportInfo.frame]);
    
    return mainiew;
}

-(NSInteger) getBottom:(CGRect)rect
{
    return rect.origin.y+rect.size.height + 5;
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
