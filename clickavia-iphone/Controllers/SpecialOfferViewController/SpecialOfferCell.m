//
//  SpecialOfferCell.m
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 26.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import "SpecialOfferCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CAColorSpecOffers.h"


//Отступы в таблице слева и справа до view
#define LEFT_RIGHT_MARGIN   3
#define MARGIN_ARROW 13
#define FONT_DIRECTION_LABEL [UIFont fontWithName:@"HelveticaNeue-Bold" size:16]
#define MARGIN 6

@implementation SpecialOfferCell

@synthesize backGradientView;
@synthesize dateLabel;
@synthesize priceLabel;
@synthesize drawArrow, drawArrowTwo;
@synthesize fromCity, inCity, backCity;

+ (Class)layerClass {
    return [CAGradientLayer class];
}

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

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    float table_width = 0;
    float table_height = 0;
    
    UITableView *table = [self getTableView:self.contentView];
    if(table != nil)
    {
        table_width = table.bounds.size.width;
        table_height = table.bounds.size.height;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = LEFT_RIGHT_MARGIN;
    frame.size.width = table_width - LEFT_RIGHT_MARGIN*2;
    self.contentView.frame = frame;
    
    self.backgroundView = [[UIView alloc] initWithFrame:frame];
}

-(void) initByOfferModel:(SpecialOffer*)offer
{        
    self.contentView.backgroundColor = [[UIColor alloc] initWithCGColor:[[UIColor COLOR_STANDART_FON_CELL] CGColor] ];
    [self.contentView.layer setCornerRadius:6];
    self.contentView.layer.shadowColor = [[COLOR_CELL_SHADOW ] CGColor];
    self.contentView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.contentView.layer.shadowRadius = 1;
    self.contentView.layer.shadowOpacity = 0.7;
    [self.contentView setClipsToBounds:NO];
    
    [self formatMessage:offer];

    dateLabel.text = [self formatMessageForDate:offer];
    priceLabel.text = [[NSString alloc] initWithFormat:@"%.0f руб.", offer.price.floatValue];
    
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:17];
    priceLabel.textColor = [UIColor COLOR_PRICE_LABEL];

    fromCity.font = inCity.font = backCity.font = FONT_DIRECTION_LABEL;
    fromCity.textColor = inCity.textColor = backCity.textColor = [UIColor COLOR_DIRECTION_LABEL];
    
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    dateLabel.textColor = [UIColor COLOR_PRICE_LABEL];
    
    [drawArrow setColor:[UIColor COLOR_DIRECTION_LABEL]];
    [drawArrowTwo setColor:[UIColor COLOR_DIRECTION_LABEL]];

    
    if(offer.isHot)
    {
        self.contentView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"specials-card-red.png"]];
        
        priceLabel.textColor = [UIColor COLOR_PRICE_LABEL_HOT];
        priceLabel.layer.shadowOpacity = 0.2f;
        priceLabel.layer.shadowRadius = 0.0f;
        priceLabel.layer.shadowColor = [[UIColor COLOR_PRICE_LABEL_HOT_SHADOW] CGColor];
        priceLabel.layer.shadowOffset = CGSizeMake(0.0f, 0.5f);

        fromCity.textColor = inCity.textColor = backCity.textColor = [UIColor COLOR_PRICE_LABEL_HOT];
        drawArrow.layer.shadowOpacity = drawArrowTwo.layer.shadowOpacity = fromCity.layer.shadowOpacity = inCity.layer.shadowOpacity = backCity.layer.shadowOpacity = 0.2f;
        drawArrow.layer.shadowRadius = drawArrowTwo.layer.shadowRadius = fromCity.layer.shadowRadius = inCity.layer.shadowRadius = backCity.layer.shadowRadius = 0.0f;
        drawArrow.layer.shadowColor = drawArrowTwo.layer.shadowColor = fromCity.layer.shadowColor = inCity.layer.shadowColor = backCity.layer.shadowColor = [[UIColor COLOR_DIRECTION_LABEL_HOT_SHADOW] CGColor];
        drawArrow.layer.shadowOffset = drawArrowTwo.layer.shadowOffset = fromCity.layer.shadowOffset = inCity.layer.shadowOffset = backCity.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        
        dateLabel.textColor = [UIColor COLOR_PRICE_LABEL_HOT];
        dateLabel.layer.shadowOpacity = 0.2f;
        dateLabel.layer.shadowRadius = 0.0f;
        dateLabel.layer.shadowColor = [[UIColor COLOR_PRICE_LABEL_SHADOW] CGColor];
        dateLabel.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
        
        [drawArrow setColor:[UIColor COLOR_PRICE_LABEL_HOT]];
        [drawArrowTwo setColor:[UIColor COLOR_PRICE_LABEL_HOT]];
    }
}

-(UITableView*)getTableView:(UIView*)theView
{
    if (!theView.superview)
        return nil;
    
    if ([theView.superview isKindOfClass:[UITableView class]])
        return (UITableView*)theView.superview;
    
    return [self getTableView:theView.superview];
}

- (void) formatMessage:(SpecialOffer*) offer
{
    drawArrowTwo.alpha = 0;
    fromCity.text = offer.departureCity;
    inCity.text = offer.flightCity;
    backCity.text = @"";
    
    CGSize widthTextFromCity = [fromCity.text sizeWithFont:FONT_DIRECTION_LABEL];
    CGSize widthTextInCity = [inCity.text sizeWithFont:FONT_DIRECTION_LABEL];
    
    float widthFromCity = widthTextFromCity.width > fromCity.frame.size.width ? fromCity.frame.size.width : widthTextFromCity.width ;
    float widthInCity = widthTextInCity.width > fromCity.frame.size.width ? fromCity.frame.size.width : widthTextInCity.width;
    
    fromCity.frame = CGRectMake(MARGIN,
                                MARGIN,
                                widthFromCity,
                                fromCity.frame.size.height);
    
    drawArrow.frame = CGRectMake(widthFromCity + 2*MARGIN,
                                   fromCity.frame.origin.y + MARGIN,
                                   drawArrow.frame.size.width,
                                   drawArrow.frame.size.height);
    
    inCity.frame = CGRectMake(widthFromCity + drawArrow.frame.size.width + 3*MARGIN,
                              fromCity.frame.origin.y,
                              widthInCity,
                              fromCity.frame.size.height);

    if(offer.isReturn)
    {
        drawArrowTwo.alpha = 1;
        backCity.text = fromCity.text;
        
        drawArrowTwo.frame = CGRectMake(widthFromCity + drawArrow.frame.size.width + 4*MARGIN + widthInCity,
                                    drawArrow.frame.origin.y,
                                    drawArrow.frame.size.width,
                                    drawArrow.frame.size.height);
        backCity.frame = CGRectMake(widthFromCity + 2*drawArrow.frame.size.width + 5*MARGIN + widthInCity,
                                    fromCity.frame.origin.y,
                                    widthFromCity,
                                    fromCity.frame.size.height);
    }
}

- (NSString*) formatMessageForDate:(SpecialOffer*) offer
{
    //return [dateFormat stringFromDate:now];
    
    NSMutableString *message = [NSMutableString new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"]];
    [formatter setDateFormat:@"d MMMM, EEE"];
    NSString *stringFromDate = [formatter stringFromDate:(NSDate*)[offer.dates objectAtIndex:0]];
    [message appendString:stringFromDate];
    if(offer.isReturn)
    {
        stringFromDate = [formatter stringFromDate:(NSDate*)[offer.dates objectAtIndex:1]];
        [message appendString:[[NSString alloc] initWithFormat:@" - %@",stringFromDate]];
    }
    return (NSString*)message;
}

@end
