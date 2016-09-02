//
//  NSUserDefaults+Settings.m
//  RaoooScore
//
//  Created by 瞿 伦平 on 13-12-31.
//  Copyright (c) 2013年 Allran. All rights reserved.
//

#import "NSUserDefaults+Settings.h"

static NSString * const keyLatitude                            = @"keyLatitude";
static NSString * const keyLongitude                            = @"keyLongitude";


@implementation NSUserDefaults (Settings)

@dynamic latitude;
@dynamic longitude;


-(NSString *)latitude
{
    return [self stringForKey:keyLatitude];
}
-(void)setLatitude:(NSString *)latitude
{
    [self setObject:latitude forKey:keyLatitude];
    [self synchronize];
}


-(NSString *)longitude
{
    return [self stringForKey:keyLongitude];
}
-(void)setLongitude:(NSString *)longitude
{
    [self setObject:longitude forKey:keyLongitude];
    [self synchronize];
}




-(void)loadUserZro
{
    self.latitude = @"";
    self.longitude = @"";
}

@end
