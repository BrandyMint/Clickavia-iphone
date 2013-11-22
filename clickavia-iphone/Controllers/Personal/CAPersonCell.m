//
//  CAPersonCell.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 21/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPersonCell.h"
#import "CAOrderDetailsPersonal.h"

@implementation CAPersonCell
{
    NSInteger order;
}

@synthesize orderNumber, confirm, detail;

-(void) layoutSubviews
{
    orderNumber.font = confirm.font = detail.font = [UIFont systemFontOfSize:14];
    
    CGRect confirmFrame = confirm.frame;
    confirmFrame.origin.x = orderNumber.frame.origin.x + [orderNumber.text sizeWithFont:orderNumber.font].width + 10;
    confirmFrame.origin.y = orderNumber.frame.origin.y;
    confirmFrame.size.width = [confirm.text sizeWithFont:confirm.font].width;
    confirm.frame = confirmFrame;
    confirm.textColor = [UIColor greenColor];
    
    CGRect detailFrame = detail.frame;
    detailFrame.origin.x = confirm.frame.origin.x + [confirm.text sizeWithFont:confirm.font].width + 10;
    detailFrame.origin.y = confirm.frame.origin.y;
    detailFrame.size.width = [detail.text sizeWithFont:detail.font].width;
    detail.frame = detailFrame;

}

- (void) orderNumber:(NSInteger)orderNumber specialOffer:(SpecialOffer *)specialOffer passengers:(CAFlightPassengersCount *)passengers
{
    order = orderNumber;
    CAFlightPassengersCount *passenger = [CAFlightPassengersCount new];
    SpecialOffer* specialoffer = [SpecialOffer new];
    passenger = passengers;
    specialoffer = specialOffer;
    
    CAOrderDetailsPersonal* orderDetailsPersonalView = [[CAOrderDetailsPersonal alloc] initByOfferModel:specialoffer passengers:passenger];
    CGRect orderDetalsFrame = orderDetailsPersonalView.frame;
    orderDetalsFrame.origin.y = 25;
    orderDetailsPersonalView.frame = orderDetalsFrame;
    [self addSubview:orderDetailsPersonalView];
    
    UIButton* enter = [[UIButton alloc] initWithFrame:CGRectMake(5, orderDetailsPersonalView.frame.origin.y + 100, 150, 40)];
    enter.titleLabel.textAlignment = NSTextAlignmentCenter;
    [enter setTitle:@" Связаться с менеджером" forState:UIControlStateNormal];
    enter.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    enter.titleLabel.textAlignment = NSTextAlignmentCenter;
    enter.titleLabel.font = [UIFont systemFontOfSize:13];
    [enter setBackgroundImage:[UIImage imageNamed:@"bnt-primary-large-for-dark.png"] forState:UIControlStateNormal];
    [enter addTarget:self action:@selector(openChat:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:enter];
}

-(void)openChat:(id)sender
{
    [_delegate didselectTellManager:order];
}

@end
