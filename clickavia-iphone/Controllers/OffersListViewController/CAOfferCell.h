//
//  CAOfferCell.h
//  clickavia-iphone
//
//  Created by denisdbv@gmail.com on 30.07.13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"

@interface CAOfferCell : UITableViewCell

-(void) initByOfferModel:(Offer*)offer;

@end
