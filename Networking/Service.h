//
//  Service.h
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"
#import <CoreLocation/CoreLocation.h>

@interface Service : MTLModel <MTLJSONSerializing>

/*
 
 "stationboard": [
     {
         "capacity1st": null,
         "capacity2nd": null,
         "category": "S",
         "categoryCode": 5,
         "name": "S 15",
         "number": "15",
         "operator": "SBB",
         "passList": [],
         "stop": {
             "arrival": null,
             "delay": null,
             "departure": "2014-07-14T13:10:00+0200",
             "location": {
                             "coordinate": {
                                 "type": "WGS84",
                                 "x": 8.540192,
                                 "y": 47.378177
                                },
                          "distance": null,
                          "id": "8503000",
                          "name": "Z\u00fcrich HB",
                          "score": null
                          },
     "platform": "43/44",
     "prognosis": {
         "arrival": null,
         "capacity1st": 1,
         "capacity2nd": 1,
         "departure": null,
         "platform": "43"
     },
     "station": {
        "coordinate": {
             "type": "WGS84",
             "x": 8.540192,
             "y": 47.378177
                },
        "distance": null,
        "id": "8503000",
        "name": "Z\u00fcrich HB",
        "score": null
     }
     },
     "subcategory": "S",
     "to": "Rapperswil"
     },
 
 
*/

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *to;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *line;
@property (nonatomic, strong) NSDictionary *stop;

@end
