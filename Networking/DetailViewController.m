//
//  DetailViewController.m
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *stationNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationScoreLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

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

- (void)configureView
{
    // Update the user interface for the detail item.
    self.title = self.station.name;

    if (self.station) {
        
        self.stationIdLabel.text = [NSString stringWithFormat:@"%@", [self.station stationId]];
        
        [self.mapView setCenterCoordinate:self.station.locationCoordinate];

        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.station.locationCoordinate, 750, 750);
        MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:adjustedRegion animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
