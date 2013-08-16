//
//  CAMonthSliderView.m
//  CAManagersLib
//
//  Created by macmini1 on 08.07.13.
//  Copyright (c) 2013 macmini1. All rights reserved.
//

#import "CAMonthSliderView.h"

@implementation CAMonthSliderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseSetup];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self = [super initWithCoder:aDecoder]))
    {
        [self baseSetup];
    }
    return self;
}
- (void) baseSetup
{
    gradientLayer = [CAGradientLayer new];
    gradientLayerMonth = [CAGradientLayer new];
    backgroundMonthView = [[UIImageView alloc] initWithImage:[[CACalendarStyle sharedStyle] getSliderViewMonthImage]];
    backgroundView = [[UIImageView alloc] initWithImage:[[CACalendarStyle sharedStyle] getSliderViewImage]];
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    monthLabels = [NSMutableArray new];
    selectedIndex = 0;

    for(int i = 0; i<12;i++)
    {
        components.month = i;
        NSDate *nextMonth = [calendar dateByAddingComponents:components toDate:today options:0];
        UILabel *label = [UILabel new];
        label.font = [[CACalendarStyle sharedStyle] getSliderViewMonthFont];
        label.text = [self monthString:nextMonth];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [[CACalendarStyle sharedStyle] getSliderViewMonthFontColor];
        label.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [monthLabels addObject:label];
    }
    tapRectView = [[UIView alloc] init];
    monthView = [[UIScrollView alloc] init];
    [monthView setDelegate:self];
    _delegate = nil;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

    [self addGestureRecognizer:tapGesture];
    UISwipeGestureRecognizer *swipeGestureRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    swipeGestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipeGestureRight];
    
    UISwipeGestureRecognizer *swipeGestureLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeGestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipeGestureLeft];

}


- (void) layoutSubviews
{
    [super layoutSubviews];
    [gradientLayer removeFromSuperlayer];
    [gradientLayerMonth removeFromSuperlayer];
    [backgroundMonthView removeFromSuperview];
    [backgroundView removeFromSuperview];
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }

    for (int i = 0; i < monthLabels.count; i++)
    {
        UILabel *monthLabel = [monthLabels objectAtIndex:i];
        CGSize stringBoundingBox = [monthLabel.text sizeWithFont:[[CACalendarStyle sharedStyle] getSliderViewMonthFont]];
        NSUInteger x = 0;
        if(i!=0)
        {
            UILabel *previousMonth = [monthLabels objectAtIndex:i-1];
            x = previousMonth.frame.origin.x + previousMonth.frame.size.width;
        }
        if(_testIPhone==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                monthLabel.frame = CGRectMake(x+[[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad],
                                              [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPad],
                                              stringBoundingBox.width,
                                              stringBoundingBox.height+[[CACalendarStyle sharedStyle] getSliderViewMarginTopIPad]);
            }
            else
            {
                monthLabel.frame = CGRectMake(x+[[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone],
                                              [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone],
                                              self.frame.size.width/[[CACalendarStyle sharedStyle] getSliderViewKWidthIPhone],
                                              stringBoundingBox.height+[[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone]);
            }
            
        }
        else
        {
            monthLabel.frame = CGRectMake(x+[[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone],
                                          [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone],
                                          self.frame.size.width/[[CACalendarStyle sharedStyle] getSliderViewKWidthIPhone],
                                          stringBoundingBox.height+[[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone]);
        }
    }
    [self resizeThis];
    gradientLayer.colors = [[CACalendarStyle sharedStyle] getSliderViewGradientColors];
    gradientLayer.frame = self.bounds;
    [self.layer addSublayer:gradientLayer];
    [self addSubview:backgroundView];
    [self addSubviews];
    backgroundView.frame = self.bounds;

    
    gradientLayerMonth.colors = [[CACalendarStyle sharedStyle] getSliderViewMonthGradientColors];
    gradientLayerMonth.frame = tapRectView.bounds;
    [tapRectView.layer addSublayer:gradientLayerMonth];
    backgroundMonthView.frame = tapRectView.bounds;
    [tapRectView addSubview:backgroundMonthView];
    gradientLayerMonth.cornerRadius = [[CACalendarStyle sharedStyle] getSliderViewMonthCornerRadius];
}
- (void) resizeThis
{
    CGRect frame = self.frame;
    CGFloat marginLeft;
    CGFloat marginTop;
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
            marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPad];
        }
        else
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
            marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone];
        }
        
    }
    else
    {
        marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
        marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone];
    }
    frame.size.width = ((UIView*)[monthLabels objectAtIndex:11]).frame.origin.x+((UIView*)[monthLabels objectAtIndex:11]).frame.size.width+marginLeft;
    frame.size.height = ((UIView*)[monthLabels objectAtIndex:11]).frame.size.height+marginTop;

    frame.size.width = self.frame.size.width;
    frame.size.height = frame.size.height>self.frame.size.height?frame.size.height:self.frame.size.height;
    self.frame = frame;
    [self.superview layoutSubviews];
}
- (void) addSubviews
{
    CGFloat marginLeft;
    CGFloat marginTop;
    if(_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
            marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPad];
            tapRectView.frame = [self getRectForMonthIndexIPad:0];
            
        }
        else
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
            marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone];
            tapRectView.frame = [self getRectForMonthIndexIPhone:0];
        }
        
    }
    else
    {
        marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
        marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone];
        tapRectView.frame = [self getRectForMonthIndexIPhone:0];
    }
    
    [monthView addSubview:tapRectView];
    monthView.frame = self.frame;
    for (UIView *view in monthLabels)
    {
        [monthView addSubview:view];
    }
    monthView.scrollEnabled = NO;
    monthView.contentSize = CGSizeMake(((UIView*)[monthLabels objectAtIndex:11]).frame.origin.x+((UIView*)[monthLabels objectAtIndex:11]).frame.size.width, self.frame.size.height);
    [self addSubview:monthView];
}
- (void)tap:(UITapGestureRecognizer*) gestureRecognizer
{
    if (_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            [self tapHandlerIPad:gestureRecognizer];
        }
        else
        {
            [self tapHandlerIPhone:gestureRecognizer];
        }
    }
    else
    {
        [self tapHandlerIPhone:gestureRecognizer];
    }
    

}

- (void)tapHandlerIPhone:(UITapGestureRecognizer*) gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded)
    {
        selectedIndex = 0;
        for(int i = 0; i <12; i++)
        {
            UIView *view = [monthLabels objectAtIndex:i];
            CGPoint point = [gestureRecognizer locationInView:view];
            if(point.x>(0-marginLeft/2.0) && point.x < (view.frame.size.width+marginLeft))
            {
                selectedIndex = i;
                i = 12;
            }
        }
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
         {
             CGRect newFrame = [self getRectForMonthIndexIPhone:selectedIndex];

             tapRectView.frame = newFrame;
             gradientLayerMonth.frame = tapRectView.bounds;
             backgroundMonthView.frame = tapRectView.bounds;
             
         } completion:nil];
        [self sendMessageToDelegate];
    }
}
- (void)tapHandlerIPad:(UITapGestureRecognizer*) gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
    if(gestureRecognizer.state==UIGestureRecognizerStateEnded)
    {
        selectedIndex = 0;
        for(int i = 0; i <12; i++)
        {
            UIView *view = [monthLabels objectAtIndex:i];
            CGPoint point = [gestureRecognizer locationInView:view];
            if(point.x>(0-marginLeft/2.0) && point.x < (view.frame.size.width+marginLeft))
            {
                selectedIndex = i;
                if(point.x< (view.frame.size.width/2.0))
                {
                    if(selectedIndex!=0)
                    {
                        selectedIndex = selectedIndex - 1;
                    }
                }
                else
                {
                    selectedIndex = i==11?10:i;
                }
                i = 12;
            }
        }
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
         {
             CGRect newFrame = [self getRectForMonthIndexIPad:selectedIndex];
             
             tapRectView.frame = newFrame;
             gradientLayerMonth.frame = tapRectView.bounds;
             backgroundMonthView.frame = tapRectView.bounds;
         } completion:nil];
        [self sendMessageToDelegate];
    }
}

- (void)swipeRight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (_testIPhone==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                [self swipeRightHandlerIPad:gestureRecognizer];
            }
            else
            {
                [self swipeRightHandlerIPhone:gestureRecognizer];
            }
        }
        else
        {
            [self swipeRightHandlerIPhone:gestureRecognizer];
        }
    }
}
-(void)swipeLeft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        if (_testIPhone==0)
        {
            if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                [self swipeLeftHandlerIPad:gestureRecognizer];
            }
            else
            {
                [self swipeLeftHandlerIPhone:gestureRecognizer];
            }
        }
        else
        {
            [self swipeLeftHandlerIPhone:gestureRecognizer];
        }
    }
}

-(void)swipeRightHandlerIPad:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
    selectedIndex--;
    if(selectedIndex<0)selectedIndex = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
     {
         CGRect newFrame = [self getRectForMonthIndexIPad:selectedIndex];
         
         tapRectView.frame = newFrame;
         gradientLayerMonth.frame = tapRectView.bounds;
         backgroundMonthView.frame = tapRectView.bounds;         
         [monthView scrollRectToVisible:CGRectMake(newFrame.origin.x-marginLeft, newFrame.origin.y, newFrame.size.width+marginLeft, newFrame.size.height) animated:YES];
     } completion:nil];

    [self sendMessageToDelegate];
}
-(void)swipeRightHandlerIPhone:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
    selectedIndex--;
    if(selectedIndex<0)selectedIndex = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
     {
         CGRect newFrame = [self getRectForMonthIndexIPhone:selectedIndex];
         
         tapRectView.frame = newFrame;
         gradientLayerMonth.frame = tapRectView.bounds;
         backgroundMonthView.frame = tapRectView.bounds;         
         [monthView scrollRectToVisible:CGRectMake(newFrame.origin.x-marginLeft, newFrame.origin.y, newFrame.size.width+marginLeft, newFrame.size.height) animated:YES];
     } completion:nil];

    [self sendMessageToDelegate];
}
-(void)swipeLeftHandlerIPad:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
    selectedIndex++;
    if(selectedIndex>=11)selectedIndex = 10;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
     {
         CGRect newFrame = [self getRectForMonthIndexIPad:selectedIndex];
         
         tapRectView.frame = newFrame;
         gradientLayerMonth.frame = tapRectView.bounds;
         backgroundMonthView.frame = tapRectView.bounds;         
         [monthView scrollRectToVisible:CGRectMake(newFrame.origin.x-marginLeft, newFrame.origin.y, newFrame.size.width+marginLeft, newFrame.size.height) animated:YES];
     } completion:nil];
    [self sendMessageToDelegate];
}
-(void)swipeLeftHandlerIPhone:(UISwipeGestureRecognizer*)gestureRecognizer
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
    selectedIndex++;
    if(selectedIndex>11)selectedIndex = 11;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
     {
         CGRect newFrame = [self getRectForMonthIndexIPhone:selectedIndex];
         
         tapRectView.frame = newFrame;
         gradientLayerMonth.frame = tapRectView.bounds;
         backgroundMonthView.frame = tapRectView.bounds;         
         [monthView scrollRectToVisible:CGRectMake(newFrame.origin.x-marginLeft, newFrame.origin.y, newFrame.size.width+marginLeft, newFrame.size.height) animated:YES];
     } completion:nil];

    [self sendMessageToDelegate];
}
- (void)sendMessageToDelegate
{
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:selectedIndex];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    [_delegate monthSliderView:self selectedMonthChanged:newDate];
}

- (CGRect)getRectForMonthIndexIPad:(NSInteger)index
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
    CGFloat marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPad];
    if(index==11)
    {
        index = 10;
    }

    CGRect firstFrame = ((UIView*)[monthLabels objectAtIndex:index]).frame;
    CGRect secondFrame = ((UIView*)[monthLabels objectAtIndex:index+1]).frame;
    CGRect resultFrame = CGRectMake(0, 0, 0, 0);
    resultFrame.origin.x = firstFrame.origin.x-marginLeft/2.0;
    resultFrame.origin.y = firstFrame.origin.y-marginTop/2.0;
    resultFrame.size.height = firstFrame.size.height+marginTop*2.0;
    resultFrame.size.width = firstFrame.size.width+secondFrame.size.width+marginLeft*2;
    return resultFrame;
}
- (CGRect)getRectForMonthIndexIPhone:(NSInteger)index
{
    CGFloat marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
    CGFloat marginTop = [[CACalendarStyle sharedStyle] getSliderViewMarginTopIPhone];
    CGRect firstFrame = ((UIView*)[monthLabels objectAtIndex:index]).frame;
    firstFrame.size.width+=marginLeft;
    firstFrame.origin.x -= marginLeft/2.0;
    firstFrame.origin.y -= marginTop/2.0;
    firstFrame.size.height = firstFrame.size.height+marginTop*2.0;
    return firstFrame;
}
- (void)updateWithSelectedMonth:(NSDate *)selectedMonth
{
    CGFloat marginLeft;
    if (_testIPhone==0)
    {
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPad];
        }
        else
        {
            marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
        }
    }
    else
    {
        marginLeft = [[CACalendarStyle sharedStyle] getSliderViewMarginLeftIPhone];
    }
    
    
    
    selectedIndex = -1;
    NSDate *today = [NSDate date];
    
    NSInteger todayMonth = [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:today] month];
    NSInteger selected = [[[NSCalendar currentCalendar] components:NSMonthCalendarUnit fromDate:selectedMonth] month];
    
    NSInteger difference = todayMonth>selected?selected+12-todayMonth:selected-todayMonth;
    selectedIndex = difference;

    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^(void)
     {
         
         
         
         CGRect newFrame;
         if (_testIPhone==0)
         {
             if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
             {
                 newFrame = [self getRectForMonthIndexIPad:selectedIndex];
             }
             else
             {
                 newFrame = [self getRectForMonthIndexIPhone:selectedIndex];
                 selectedIndex = difference;
             }
         }
         else
         {
             selectedIndex = difference;
             newFrame = [self getRectForMonthIndexIPhone:selectedIndex];
         }
         tapRectView.frame = newFrame;
         gradientLayerMonth.frame = tapRectView.bounds;
         backgroundMonthView.frame = tapRectView.bounds;         
         [monthView scrollRectToVisible:CGRectMake(newFrame.origin.x-marginLeft, newFrame.origin.y, newFrame.size.width+marginLeft, newFrame.size.height) animated:YES];

         
         
     } completion:nil];
}

- (NSString*) monthString:(NSDate *) month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSMonthCalendarUnit fromDate:month];
    NSString *monthString;
    switch (dateComponents.month)
    {
        case 1:
            monthString = @"Январь";
            break;
        case 2:
            monthString = @"Февраль";
            break;
        case 3:
            monthString = @"Март";
            break;
        case 4:
            monthString = @"Апрель";
            break;
        case 5:
            monthString = @"Май";
            break;
        case 6:
            monthString = @"Июнь";
            break;
        case 7:
            monthString = @"Июль";
            break;
        case 8:
            monthString = @"Август";
            break;
        case 9:
            monthString = @"Сентябрь";
            break;
        case 10:
            monthString = @"Октябрь";
            break;
        case 11:
            monthString = @"Ноябрь";
            break;
        case 12:
            monthString = @"Декабрь";
            break;
        default:
            break;
    }
    return monthString;
}

@end
