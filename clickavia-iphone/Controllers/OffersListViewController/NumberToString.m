//
//  NuberToString.m
//  NumberToString
//
//  Created by bespalown on 9/23/13.
//  Copyright (c) 2013 bespalown. All rights reserved.
//

#import "NumberToString.h"

@implementation NumberToString

-(NSString*) numberToString:(NSInteger)number
{
    int m1, m2, m3;
    int sum = number;
    
    m1=sum/100000000;
    m2=sum/10000000-(sum/100000000)*10;
    m3=sum/1000000-(sum/10000000)*10;
    NSString* m1string = [self m1:m1 m2:m2 m3:m3 flag:1];
    
    m1=sum/100000-(sum/1000000)*10;
    m2=sum/10000-(sum/100000)*10;
    m3=sum/1000-(sum/10000)*10;
    NSString* m2string = [self m1:m1 m2:m2 m3:m3 flag:2];
    
    m1=sum/100-(sum/1000)*10;
    m2=sum/10-(sum/100)*10;
    m3=sum/1-(sum/10)*10;
    NSString* m3string = [self m1:m1 m2:m2 m3:m3 flag:3];

    return [NSString stringWithFormat:@"вот %@%@%@",m1string, m2string, m3string];
}

-(NSString*) m1:(int)m1 m2:(int)m2 m3:(int)m3 flag:(int)flag
{
    NSMutableString* mutString = [[NSMutableString alloc] initWithCapacity:10];
    
    switch( m1 )
    {
        case 1:
            [mutString appendString:@"сто "];
            break;
        case 2:
            [mutString appendString:@"двести "];
            break;
        case 3:
            [mutString appendString:@"триста "];
            break;
        case 4:
            [mutString appendString:@"четыреста "];
            break;
        case 5:
            [mutString appendString:@"пятьсот "];
            break;
        case 6:
            [mutString appendString:@"шестьсот "];
            break;
        case 7:
            [mutString appendString:@"семьсот "];
            break;
        case 8:
            [mutString appendString:@"восемьсот "];
            break;
        case 9:
            [mutString appendString:@"девятьсот "];
            break;
    }
    if( m2 == 0 || m2 > 1 )
    {
        if( m2 > 1 )
        {
            switch( m2 )
            {
                case 2:
                    [mutString appendString:@"двадцать "];
                    break;
                case 3:
                    [mutString appendString:@"тридцать "];
                    break;
                case 4:
                    [mutString appendString:@"сорок "];
                    break;
                case 5:
                    [mutString appendString:@"пятьдесят "];
                    break;
                case 6:
                    [mutString appendString:@"шестьдесят "];
                    break;
                case 7:
                    [mutString appendString:@"семьдесят "];
                    break;
                case 8:
                    [mutString appendString:@"восемьдесят "];
                    break;
                case 9:
                    [mutString appendString:@"девяносто "];
                    break;
            }
        }
        switch( m3 )
        {
            case 1:
                if( flag == 2 ) [mutString appendString:@"одна "];
                else [mutString appendString:@"один "];
                break;
            case 2:
                if( flag == 2 ) [mutString appendString:@"две "];
                else [mutString appendString:@"два "];
                break;
            case 3:
                [mutString appendString:@"три "];
                break;
            case 4:
                [mutString appendString:@"четыре "];
                break;
            case 5:
                [mutString appendString:@"пять "];
                break;
            case 6:
                [mutString appendString:@"шесть "];
                break;
            case 7:
                [mutString appendString:@"семь "];
                break;
            case 8:
                [mutString appendString:@"восемь "];
                break;
            case 9:
                [mutString appendString:@"девять "];
                break;
        }
    }
    else if( m2 == 1 )
    {
        switch( m3 )
        {
            case 0:
                [mutString appendString:@"десять "];
                break;
            case 1:
                [mutString appendString:@"одиннадцать "];
                break;
            case 2:
                [mutString appendString:@"двенадцать "];
                break;
            case 3:
                [mutString appendString:@"тринадцать "];
                break;
            case 4:
                [mutString appendString:@"четырнадцать "];
                break;
            case 5:
                [mutString appendString:@"пятнадцать "];
                break;
            case 6:
                [mutString appendString:@"шестнадцать "];
                break;
            case 7:
                [mutString appendString:@"семнадцать "];
                break;
            case 8:
                [mutString appendString:@"восемнадцать "];
                break;
            case 9:
                [mutString appendString:@"девятнадцать "];
                break;
        }
    }
    
    if( flag == 1 )
    {
        if( m3 == 0 && m2 == 0 && m1 == 0 ) [mutString appendString:@""];
        else if( m2 == 1 )
        {
            [mutString appendString:@"миллионов "];
        }
        else
        {
            if( m3 == 1 ) [mutString appendString:@"миллион "];
            else if( m3 >= 2 && m3 <= 4 ) [mutString appendString:@"миллиона "];
            else [mutString appendString:@"миллионов "];
        }
    }
    else if( flag == 2 )
    {
        if( m3 == 0 && m2 == 0 && m1 == 0 ) [mutString appendString:@""];
        else if( m2 == 1 )
        {
            [mutString appendString:@"тысяч "];
        }
        else
        {
            if( m3 == 1 ) [mutString appendString:@"тысяча "];
            else if( m3 >= 2 && m3 <= 4 ) [mutString appendString:@"тысячи "];
            else [mutString appendString:@"тысяч "];
        }
    }
    else if( flag == 3 )
    {
        if( m3 == 0 && m2 == 0 && m1 == 0 ) [mutString appendString:@"рублей "];
        else if( m2 == 1 )
        {
            [mutString appendString:@"рублей "];
        }
        else
        {
            if( m3 == 1 ) [mutString appendString:@"рубль "];
            else if( m3 >= 2 && m3 <= 4 ) [mutString appendString:@"рубля "];
                else [mutString appendString:@"рублей "];
        }
    }

    return [NSString stringWithFormat:@"%@",mutString];
}

@end
