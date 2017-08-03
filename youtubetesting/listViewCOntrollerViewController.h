//
//  listViewCOntrollerViewController.h
//  youtubetesting
//
//  Created by Nicky on 7/31/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YoutubeStreamingLayer.h"
#import "LiveViewController.h"

@interface listViewCOntrollerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end
