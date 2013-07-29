//
//  CASpecialOfferCell.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CASpecialOfferCell.h"
#import <QuartzCore/QuartzCore.h>

//Отступы в таблице слева и справа до view
#define LEFT_RIGHT_MARGIN   2

@implementation CASpecialOfferCell

@synthesize backGradientView;
@synthesize directionLabel;
@synthesize dateLabel;
@synthesize priceLabel;

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
    
    /*float table_width = 0;
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
     
     //self.backgroundView = [[UIView alloc] initWithFrame:frame];*/
}

-(void) initByOfferModel:(SpecialOffer*)offer
{
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView.layer setCornerRadius:6];
    self.backgroundView.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    self.backgroundView.layer.shadowRadius = 1;
    self.backgroundView.layer.shadowOpacity = 0.7;
    [self.backgroundView setClipsToBounds:NO];
    
    directionLabel.text = [self formatMessageForDirection:offer];
    dateLabel.text = [self formatMessageForDate:offer];
    priceLabel.text = [[NSString alloc] initWithFormat:@"%.0f руб.", offer.price.floatValue];
    
    if(offer.isHot)
    {
        self.backgroundView.backgroundColor = [UIColor redColor];
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

- (NSString*) formatMessageForDirection:(SpecialOffer*) offer
{
    NSMutableString *message = [NSMutableString new];
    [message appendString:[[NSString alloc] initWithFormat:@"%@ > %@",offer.departureCity,offer.flightCity]];
    if(offer.isReturn)
    {
        [message appendString:[[NSString alloc] initWithFormat:@" > %@",offer.departureCity]];
    }
    return (NSString*)message;
}

- (NSString*) formatMessageForDate:(SpecialOffer*) offer
{
    NSMutableString *message = [NSMutableString new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-mm-dd"];
    NSString *stringFromDate = [formatter stringFromDate:(NSDate*)[offer.dates objectAtIndex:0]];
    [message appendString:stringFromDate];
    if(offer.isReturn)
    {
        stringFromDate = [formatter stringFromDate:(NSDate*)[offer.dates objectAtIndex:1]];
        [message appendString:[[NSString alloc] initWithFormat:@" > %@",stringFromDate]];
    }
    return (NSString*)message;
}

@end
