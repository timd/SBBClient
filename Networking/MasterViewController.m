//
//  MasterViewController.m
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

#import <AFNetworking/AFHTTPRequestOperation.h>
#import "Station.h"

static NSString * const BaseURLString = @"http://transport.opendata.ch/v1/";

@interface MasterViewController ()

@property (nonatomic, strong) NSMutableArray *stationsArray;
@property (nonatomic, strong) SBBClient *sbbClient;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *loadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapLoadButton:)];
    self.navigationItem.rightBarButtonItem = loadButton;
    
    self.stationsArray = [[NSMutableArray alloc] init];
    
    self.title = @"Stations";
    
    self.sbbClient = [SBBClient sharedSBBClient];
    [self.sbbClient setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.stationsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Station *station = [self.stationsArray objectAtIndex:indexPath.row];
    NSString *name = station.name;
    
    [cell.textLabel setText:name];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Station *selectedStation = [self.stationsArray objectAtIndex:indexPath.row];
        [[segue destinationViewController] setStation:selectedStation];
        
    }
}


#pragma mark -
#pragma mark Interaction methods

-(IBAction)didTapLoadButton:(id)sender {
    
    [self.sbbClient getStationsListForLocation:@"Zuerich"];
    
//    NSString *requestUrlString = [NSString stringWithFormat:@"%@locations?query=Zuerich", BaseURLString];
//    NSURL *requestUrl = [NSURL URLWithString:requestUrlString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//       
//        NSDictionary *responseDict = (NSDictionary *)responseObject;
//        [self parseDataFromDictionary:responseDict];
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Request failed with error: %@", [error localizedDescription]);
//        
//    }];
//    
//    [operation start];
    
}

-(void)parseDataFromDictionary:(NSDictionary *)dictionary {

    NSArray *stationsArray = [dictionary objectForKey:@"stations"];
    
    for (NSDictionary *stationDict in stationsArray) {
        
        NSError *error = nil;
        Station *station = [MTLJSONAdapter modelOfClass:[Station class] fromJSONDictionary:stationDict error:&error];

        [self.stationsArray addObject:station];
        
    }
}

#pragma mark -
#pragma mark SBBClientDelegate methods

-(void)sbbClient:(SBBClient *)client didUpdateStations:(id)stationsList {
    
    NSDictionary *stationsDictionary = (NSDictionary *)stationsList;
    [self parseDataFromDictionary:stationsDictionary];
    [self.tableView reloadData];
    
}

@end
