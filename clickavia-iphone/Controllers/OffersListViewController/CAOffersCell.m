//
//  MyCell.m
//  TableView
//
//  Created by Alximik on 09.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CAOffersCell.h"

@implementation CAOffersCell
@synthesize caOffersListViewController;

-(void)transferView:(UIView*) customView{
    [self addSubview:customView];
}



@end
