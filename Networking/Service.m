//
//  Service.m
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "Service.h"

@implementation Service

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             @"name" : @"name",
             @"to" : @"to",
             @"number" : @"number",
             @"line" : @"category",
             @"stop" : @"stop"
             };
}



@end
