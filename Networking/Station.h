//
//  Station.h
//  
//
//  Created by Tim on 14/07/14.
//
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import <CoreLocation/CoreLocation.h>

@interface Station : MTLModel <MTLJSONSerializing>

/*
 
 coordinate = {
    type = WGS84;
    x = "8.540191999999999";
    y = "47.378177";
    };
 distance = "<null>";
 id = 008503000;
 name = "Z\U00fcrich HB";
 score = 100;
 
*/

@property (strong, nonatomic) NSNumber *stationId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *score;
@property (strong, nonatomic) NSNumber *distance;
@property (nonatomic) CLLocationCoordinate2D locationCoordinate;

@end
