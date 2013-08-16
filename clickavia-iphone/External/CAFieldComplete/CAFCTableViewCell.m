//
//  CATableViewCellComplete.m
//  cafieldcomplete
//
//  Created by macmini1 on 31.07.13.
//  Copyright (c) 2013 easylab. All rights reserved.
//

#import "CAFCTableViewCell.h"

@implementation CAFCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        _destinationCode = [UILabel new];
        _destinationName = [UILabel new];
        _destinationCode.font = [[CAFCStyle sharedStyle] fontForDestinationCode];
        _destinationCode.textColor = [[CAFCStyle sharedStyle] colorForDestinationCode];
        _destinationName.font = [[CAFCStyle sharedStyle] fontForDestinationName];
        _destinationName.textColor = [[CAFCStyle sharedStyle] colorForDestinationName];
        [self addSubview:_destinationName];
        [self addSubview:_destinationCode];
        _destinationName.backgroundColor = [UIColor clearColor];
        _destinationCode.backgroundColor = [UIColor clearColor];
        _destinationName.frame = CGRectMake(0, 0, self.frame.size.width*0.75, self.frame.size.height);
        _destinationCode.frame = CGRectMake(self.frame.size.width*0.75,0, self.frame.size.width*0.25, self.frame.size.height);
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGSize textSize = [_destinationName.text sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationName]];
    
    NSString *str = @" WWW";
    CGSize size = [str sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationCode]];
    if(textSize.width<(self.frame.size.width-size.width))
    {
        NSString *space = @" ";
        CGSize spaceSize = [space sizeWithFont:[[CAFCStyle sharedStyle] fontForDestinationCode]];
        _destinationCode.frame = CGRectMake(textSize.width+spaceSize.width, 0, self.frame.size.width, self.frame.size.height);
    }
    else
    {
        _destinationCode.frame = CGRectMake(self.frame.size.width-size.width, 0,self.frame.size.width, self.frame.size.height);
    }
    _destinationCode.center = CGPointMake(_destinationCode.center.x, _destinationName.center.y+[[CAFCStyle sharedStyle] codeLabelCenterOffsetForCell]);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
