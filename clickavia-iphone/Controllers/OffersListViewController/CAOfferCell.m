//
//  CAOfferCell.m
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAOfferCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation CAOfferCell

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += -5;
    frame.size.width -= 2 * -5;
    [super setFrame:frame];
}

-(void) initByOfferModel:(Offer*)offer
{
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.backgroundView.layer setCornerRadius:6];
    self.backgroundView.layer.shadowColor = [[UIColor colorWithRed:71.0/255.0 green:71.0/255.0 blue:71.0/255.0 alpha:1.0] CGColor];
    self.backgroundView.layer.shadowOffset = CGSizeMake(0.0, -1.0);
    self.backgroundView.layer.shadowRadius = 1;
    self.backgroundView.layer.shadowOpacity = 0.7;
    [self.backgroundView setClipsToBounds:NO];
}

@end
