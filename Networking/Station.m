//
//  Station.m
//  
//
//  Created by Tim on 14/07/14.
//
//

#import "Station.h"
#import "Mantle.h"
#import <MapKit/MapKit.h>

@implementation Station

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    // properties defined in header < : > key in JSON Dictionary
    return @{
             
             @"stationId" : @"id",
             @"name" : @"name",
             @"score" : @"score",
             @"distance" : @"distance",
             @"locationCoordinate" : @"coordinate"
             };
}

+ (NSValueTransformer *)locationCoordinateJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *coordinateDict) {
        
        CLLocationDegrees latitude = [coordinateDict[@"y"] doubleValue];
        CLLocationDegrees longitude = [coordinateDict[@"x"] doubleValue];
        return [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
        
    } reverseBlock:^(NSValue *coordinateValue) {
        
        CLLocationCoordinate2D coordinate = [coordinateValue MKCoordinateValue];
        return @{@"y": @(coordinate.latitude), @"x": @(coordinate.longitude)};
        
    }];
}

@end
