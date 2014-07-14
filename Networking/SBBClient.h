//
//  SBBClient.h
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol SBBClientDelegate;

@interface SBBClient : AFHTTPSessionManager

@property (nonatomic, weak) id<SBBClientDelegate>delegate;

+(SBBClient *)sharedSBBClient;
-(instancetype)initWithBaseURL:(NSURL *)url;
-(void)getStationsListForLocation:(NSString *)location;
-(void)getDeparturesFromStation:(NSNumber *)stationId;

@end

@protocol SBBClientDelegate <NSObject>

@optional
-(void)sbbClient:(SBBClient *)client didUpdateStations:(id)stationsList;
-(void)sbbClient:(SBBClient *)client didUpdateDepartures:(id)departures;
-(void)sbbClient:(SBBClient *)client didFailWithError:(NSError *)error;
@end

