//
//  SpecialOfferCell.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 26.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialOffer.h"
#import "drawArrowView.h"

@interface SpecialOfferCell : UITableViewCell

@property (nonatomic, retain) UIView *backGradientView;

@property (weak, nonatomic) IBOutlet UILabel *fromCity;
@property (weak, nonatomic) IBOutlet UILabel *inCity;
@property (weak, nonatomic) IBOutlet UILabel *backCity;

@property (nonatomic, assign) IBOutlet UILabel *dateLabel;
@property (nonatomic, assign) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet drawArrowView *drawArrow;
@property (weak, nonatomic) IBOutlet drawArrowView *drawArrowTwo;

-(void) initByOfferModel:(SpecialOffer*)offer;

@end
