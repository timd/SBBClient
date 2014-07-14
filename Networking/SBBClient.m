//
//  SBBClient.m
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "SBBClient.h"


static NSString * const kSbbUrlString = @"http://transport.opendata.ch/v1/";

@implementation SBBClient

+(SBBClient *)sharedSBBClient {
    
    static SBBClient *_sharedSBBClient;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedSBBClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kSbbUrlString]];
        
    });
    
    return _sharedSBBClient;
    
    
}

-(instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
    
}

-(void)getStationsListForLocation:(NSString *)location {
    
    // http://transport.opendata.ch/v1/locations?query=Zuerich&type=station
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"query"] = location;
    parameters[@"type"] = @"station";
    
    [self GET:@"locations" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(sbbClient:didUpdateStations:)]) {
            [self.delegate sbbClient:self didUpdateStations:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(sbbClient:didFailWithError:)]) {
            [self.delegate sbbClient:self didFailWithError:error];
        }
        
    }];
}

-(void)getDeparturesFromStation:(NSNumber *)stationId {

    // http://transport.opendata.ch/v1/stationboard?station=Uitliberg&limit=1
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    parameters[@"station"] = [NSString stringWithFormat:@"%@", stationId];
    //parameters[@"limit"] = @"1";
    
    [self GET:@"stationboard" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([self.delegate respondsToSelector:@selector(sbbClient:didUpdateDepartures:)]) {
            [self.delegate sbbClient:self didUpdateDepartures:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([self.delegate respondsToSelector:@selector(sbbClient:didFailWithError:)]) {
            [self.delegate sbbClient:self didFailWithError:error];
        }
        
    }];
}


@end
