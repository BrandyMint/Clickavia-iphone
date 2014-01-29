//
//  CAPopoverError.h
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 15/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CAPopoverError;
@protocol CAPopoverErrorDelegate
-(void)touchesBeganCAPopoverError;
@end

@interface CAPopoverErrorViewController : UIViewController
@property (assign) id <CAPopoverErrorDelegate> delegate;
-(id)initWithTitle:(NSString *)title font:(UIFont *)font size:(CGSize)size;

@end
