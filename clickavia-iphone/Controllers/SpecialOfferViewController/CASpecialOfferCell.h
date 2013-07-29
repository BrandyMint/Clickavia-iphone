//
//  CASpecialOfferCell.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 29.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpecialOffer.h"

@interface CASpecialOfferCell : UITableViewCell

@property (nonatomic, retain) UIView *backGradientView;
@property (nonatomic, assign) IBOutlet UILabel *directionLabel;
@property (nonatomic, assign) IBOutlet UILabel *dateLabel;
@property (nonatomic, assign) IBOutlet UILabel *priceLabel;

-(void) initByOfferModel:(SpecialOffer*)offer;

@end
