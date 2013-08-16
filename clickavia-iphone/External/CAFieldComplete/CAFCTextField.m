//
//  CATextFieldComplete.m
//  cafieldcomplete
//
//  Created by macmini1 on 29.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import "CAFCTextField.h"

@implementation CAFCTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    backgroundView = [UIImageView new];
    gradientColors = [NSArray new];
    gradientLayer = [CAGradientLayer new];
    destinationNameTextField = [[UITextField alloc] init];
    cityCodeLabel = [[UILabel alloc] init];
    _delegate = nil;

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [gradientLayer removeFromSuperlayer];
    [backgroundView removeFromSuperview];
    gradientLayer.colors = [[CAFCStyle sharedStyle] gradientColorsForTextField];
    for(UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    self.layer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTextField];
    //self.backgroundColor = [UIColor greenColor];
    destinationNameTextField.backgroundColor = [UIColor clearColor];
    NSString *str = @"  WWW";
    CGSize size = [str sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
    destinationNameTextField.frame = CGRectMake(5,5, self.frame.size.width-size.width, self.frame.size.height-10);
    destinationNameTextField.borderStyle = UITextBorderStyleNone;
    destinationNameTextField.font = [[CAFCStyle sharedStyle] fontForDestinationName];
    destinationNameTextField.textColor = [[CAFCStyle sharedStyle] colorForDestinationName];
    destinationNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    destinationNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    destinationNameTextField.delegate = self;

    
    cityCodeLabel.frame = CGRectMake(self.frame.size.width-size.width, 0, 50, self.frame.size.height);
    cityCodeLabel.textAlignment = NSTextAlignmentLeft;
    cityCodeLabel.font = [[CAFCStyle sharedStyle] fontForDestinationCode];
    cityCodeLabel.text = @"";
    cityCodeLabel.backgroundColor = [UIColor clearColor];
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTextField];
    [self setupCodeLabelCenter];
    [self.layer addSublayer:gradientLayer];

    backgroundView = [[UIImageView alloc] initWithImage:[[CAFCStyle sharedStyle] imageForBackgroundForTextField]];
    backgroundView.frame = self.bounds;
    backgroundView.layer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTextField];
    [self addSubview:backgroundView];
    [self addSubview:destinationNameTextField];
    [self addSubview:cityCodeLabel];
    self.layer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTextField];
    gradientLayer.cornerRadius = [[CAFCStyle sharedStyle] cornerRadiusForTextField];

}
- (void)setDestination:(Destination *)destination
{
    cityCodeLabel.text = destination.cityCode;
    destinationNameTextField.text = destination.cityTitle;
    CGSize textSize = [destination.cityTitle sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
    NSString *str = cityCodeLabel.text;
    CGSize size = [str sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
    if(textSize.width<(self.frame.size.width-size.width))
    {
        NSString *space = @"  ";
        CGSize spaceSize = [space sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
        cityCodeLabel.frame = CGRectMake(textSize.width+spaceSize.width, 0, 50, self.frame.size.height);
    }
    else
    {
        cityCodeLabel.frame = CGRectMake(self.frame.size.width-size.width, 0, 50, self.frame.size.height);
    }
    [self setupCodeLabelCenter];



}
- (void)becomeActive:(BOOL)needFR
{
    
    if(needFR)
    {
        [destinationNameTextField becomeFirstResponder];
    }
    else
    {
        [destinationNameTextField resignFirstResponder];
    }


}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;

}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [destinationNameTextField becomeFirstResponder];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:textField.text];
    [newString replaceCharactersInRange:range withString:string];
    //

    CGSize textSize = [newString sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
   
    NSString *str = @" WWW";
    CGSize size = [str sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
    if(textSize.width<(self.frame.size.width-size.width))
    {
        NSString *space = @" ";
        CGSize spaceSize = [space sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
        cityCodeLabel.frame = CGRectMake(textSize.width+spaceSize.width, 0, 50, self.frame.size.height);
    }
    else
    {
        cityCodeLabel.frame = CGRectMake(self.frame.size.width-size.width, 0, 50, self.frame.size.height);
    }
    [_delegate textFieldComplete:self changeString:destinationNameTextField.text withString:newString];
    [self setupCodeLabelCenter];
    cityCodeLabel.text = @"";
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_delegate textFieldCompleteDidBeginEditing:self];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_delegate textFieldCompleteDidEndEditing:self];
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    [_delegate textFieldCompleteClear:self];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_delegate textFieldCompleteReturn:self];
    return YES;
}
-(NSString*)text
{
    return destinationNameTextField.text;
}
- (void)setupCodeLabelCenter
{
    cityCodeLabel.center = CGPointMake(cityCodeLabel.center.x, destinationNameTextField.center.y+[[CAFCStyle sharedStyle] codeLabelCenterOffsetForTextField]);
}
@end
