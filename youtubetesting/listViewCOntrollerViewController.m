//
//  listViewCOntrollerViewController.m
//  youtubetesting
//
//  Created by Nicky on 7/31/17.
//  Copyright © 2017 Nicky. All rights reserved.
//

#import "listViewCOntrollerViewController.h"

@interface listViewCOntrollerViewController (){
    NSArray *value;
}

@end

@implementation listViewCOntrollerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YoutubeStreamingLayer getInstance]  listUpcomingVideosCompletion:^(BOOL success, NSDictionary *dict) {
        
        value = dict[@"items"];
        [_tableView reloadData];
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [value count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    cell.textLabel.text = value[indexPath.row][@"snippet"][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LiveViewController *live = [self.storyboard instantiateViewControllerWithIdentifier:@"LiveViewController"];
    live.dict = value[indexPath.row];
    [self.navigationController pushViewController:live animated:YES];
    
}





@end
