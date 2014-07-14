//
//  DetailViewController.h
//  Networking
//
//  Created by Tim on 14/07/14.
//  Copyright (c) 2014 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Station.h"
#import "SBBClient.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SBBClientDelegate>

@property (strong, nonatomic) Station *station;

@end
