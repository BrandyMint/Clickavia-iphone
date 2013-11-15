//
//  CAPopoverError.m
//  clickavia-iphone
//
//  Created by Viktor Bespalov on 15/11/13.
//  Copyright (c) 2013 brandymint. All rights reserved.
//

#import "CAPopoverErrorViewController.h"

@interface CAPopoverErrorViewController ()

@end

@implementation CAPopoverErrorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)title:(NSString* )title
{
    self.title = title;
}

-(id)initWithTitle:(NSString *)title font:(UIFont *)font size:(CGSize)size
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        UILabel* errorTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 280, size.height)];
        errorTitle.text = title;
        errorTitle.font = font;
        errorTitle.textColor = [UIColor orangeColor];
        errorTitle.textAlignment = UITextAlignmentLeft;
        errorTitle.contentMode = UIViewContentModeTop;
        errorTitle.lineBreakMode = UILineBreakModeCharacterWrap;
        errorTitle.numberOfLines = 0;
        
        [self.view addSubview:errorTitle];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_delegate touchesBeganCAPopoverError];
}

@end
