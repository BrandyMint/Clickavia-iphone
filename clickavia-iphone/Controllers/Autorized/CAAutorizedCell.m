//
//  CAAutorizedCell.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 13/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAAutorizedCell.h"

#define MARGIN_LEFT 10
#define MARGIN_BETWEEN_LABELS 5
#define BUTTON_HEIGHT 30
#define BUTTON_WIDTH 80

@implementation CAAutorizedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCell:(PersonInfo* )personInfo;
{
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(0, MARGIN_BETWEEN_LABELS, self.frame.size.width, 17)];
    title.text = @"Пассажиры";
    title.font = [UIFont systemFontOfSize:14];
    title.textAlignment = NSTextAlignmentCenter;
    title.backgroundColor = [UIColor  clearColor];
    //[self addSubview:title];
    
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
    
    UILabel* person = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT, MARGIN_LEFT, 0, 0)];
    person.text = fio;
    person.font = [UIFont systemFontOfSize:14];
    [person sizeToFit];
    person.backgroundColor = [UIColor  clearColor];
    [self addSubview:person];
    
    UILabel* birthday = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                  person.frame.origin.y + [person.text sizeWithFont:person.font].height + MARGIN_BETWEEN_LABELS,
                                                                  0, 0)];
    birthday.text = @"Дата рождения";
    birthday.font = [UIFont systemFontOfSize:14];
    [birthday sizeToFit];
    birthday.backgroundColor = [UIColor  clearColor];
    [self addSubview:birthday];
    
    UILabel* birthdayInfo = [[UILabel alloc] initWithFrame:CGRectMake(birthday.frame.origin.x + [birthday.text sizeWithFont:birthday.font].width + 5,
                                                                      birthday.frame.origin.y,
                                                                      0, 0)];
    birthdayInfo.text = [datefrmatter stringFromDate:personInfo.birthDate];
    birthdayInfo.font = [UIFont systemFontOfSize:14];
    [birthdayInfo sizeToFit];
    birthdayInfo.backgroundColor = [UIColor  clearColor];
    [self addSubview:birthdayInfo];
    
    UILabel* passport = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                  birthday.frame.origin.y + [birthday.text sizeWithFont:birthday.font].height + MARGIN_BETWEEN_LABELS,
                                                                  0, 0)];
    passport.text = @"Паспорт";
    passport.font = [UIFont systemFontOfSize:14];
    [passport sizeToFit];
    passport.backgroundColor = [UIColor  clearColor];
    [self addSubview:passport];
    
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
    [self addSubview:passportInfo];
    
    UILabel* validDay = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_LEFT,
                                                                  passport.frame.origin.y + [passport.text sizeWithFont:passport.font].height + MARGIN_BETWEEN_LABELS,
                                                                  0, 0)];
    validDay.text = @"Срок действия";
    validDay.font = [UIFont systemFontOfSize:14];
    [validDay sizeToFit];
    validDay.backgroundColor = [UIColor  clearColor];
    [self addSubview:validDay];
    
    UILabel* validDayInfo = [[UILabel alloc] initWithFrame:CGRectMake(validDay.frame.origin.x + [validDay.text sizeWithFont:validDay.font].width + 5,
                                                                      validDay.frame.origin.y,
                                                                      0, 0)];
    validDayInfo.text = [datefrmatter stringFromDate:personInfo.validDate];
    validDayInfo.font = [UIFont systemFontOfSize:14];
    [validDayInfo sizeToFit];
    validDayInfo.backgroundColor = [UIColor  clearColor];
    [self addSubview:validDayInfo];
}

@end
