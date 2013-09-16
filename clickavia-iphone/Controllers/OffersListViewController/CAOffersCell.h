//
//  CAOffersCell.h
//  TableView
//
//  Created by Viktor Bespalov on 9/13/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Offer.h"
#import "CAOffersListViewController.h"

#define CELL_HEIGHT_NORMAL 150
#define CELL_HEIGHT_SPECIAL 180
#define CELL_SPECIAL_PADDING (CELL_HEIGHT_SPECIAL-CELL_HEIGHT_NORMAL)/2
#define CELL_MARGIN_LEFT 5

@interface CAOffersCell : UITableViewCell

-(void)transferView:(UIView*) customView;


@end
