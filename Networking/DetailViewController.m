//
//  DetailViewController.m
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>
#import "Service.h"

@interface DetailViewController ()

@property (nonatomic, strong) SBBClient *sbbClient;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *servicesArray;

- (void)configureView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setStation:(Station *)newStation
{
    if (_station != newStation) {
        _station = newStation;
        
        // Update the view.
        [self configureView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.servicesArray = [[NSMutableArray alloc] init];
    
    [self configureSbbClient];
    [self configureView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Setup methods

- (void)configureView
{
    // Update the user interface for the detail item.
    self.title = self.station.name;
    
    if (self.station) {
        
        [self.mapView setCenterCoordinate:self.station.locationCoordinate];
        
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.station.locationCoordinate, 750, 750);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:YES];
    }
}

-(void)configureSbbClient {
    
    self.sbbClient = [SBBClient sharedSBBClient];
    [self.sbbClient setDelegate:self];
    
    if (self.station) {
        
        NSNumber *stationId = self.station.stationId;
        [self.sbbClient getDeparturesFromStation:stationId];
        
    }
    
}

#pragma mark -
#pragma mark - SBBClientDelegate methods

-(void)sbbClient:(SBBClient *)client didUpdateDepartures:(id)departures {
    
    NSLog(@"departures = %@", departures);
    
    [self parseDataFromDictionary:departures];
    
    [self.tableView reloadData];
    
}

-(void)parseDataFromDictionary:(NSDictionary *)dictionary {
    
    NSArray *localServicesArray = [dictionary objectForKey:@"stationboard"];
    
    for (NSDictionary *servicenDict in localServicesArray) {
        
        NSError *error = nil;
        Service *service = [MTLJSONAdapter modelOfClass:[Service class] fromJSONDictionary:servicenDict error:&error];
        
        [self.servicesArray addObject:service];
        
    }
}


#pragma mark -
#pragma mark - UITableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.servicesArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kTableCell" forIndexPath:indexPath];
    
    Service *theService = [self.servicesArray objectAtIndex:indexPath.row];
    
    NSRange range = NSMakeRange(11, 5);
    NSString *timeString = [[theService.stop objectForKey:@"departure"] substringWithRange:range];
    
    NSString *textLabelString = [NSString stringWithFormat:@"%@ - %@", timeString, theService.name];
    
    [cell.textLabel setText:textLabelString];
    [cell.detailTextLabel setText:theService.to];
    
    return cell;
    
}

@end
