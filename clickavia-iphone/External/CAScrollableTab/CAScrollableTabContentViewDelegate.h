//
//  CAScrollableTabContentViewDelegate.h
//  CASpecialOffers
//
//  Created by denisdbv@gmail.com on 25.06.13.
//  Copyright (c) 2013 denisdbv@gmail.com. All rights reserved.
//

#ifndef CASpecialOffers_CAScrollableTabContentViewDelegate_h
#define CASpecialOffers_CAScrollableTabContentViewDelegate_h

@class CAScrollableTabContentView;

@protocol CAScrollableTabContentViewDelegate <NSObject>

- (void)scrollableTabContentView:(CAScrollableTabContentView *)contentView didSelectItemAtIndex:(NSInteger)index;

@end

#endif
